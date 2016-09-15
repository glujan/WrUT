#include <cstdio>
#include "threads.h"

Customer* customersData;
ThreadData* tData;
Speed speed;

void Customer::chooseShop() {
    int chance = rand() % 100;
    busy = true;
    if (chance < 15) {
        desiredShop = SHOPS_COUNT;
        sleep(1);
    } else {
        desiredShop = rand() % SHOPS_COUNT;
    }
}

bool Customer::wantToBuy() {
    return desiredShop < SHOPS_COUNT;
}

Options::Options(u_int32_t custTotal, const u_int8_t speed, WarehouseWidget *widget):
    custTotal(custTotal), speed(speed), widget(widget){
}

ThreadData::ThreadData(void *options){
    pthread_mutex_init(&mutexBuy, NULL);
    pthread_cond_init(&conditionDelivery, NULL);
    quit = false;

    if(options != NULL){
        Options *o = reinterpret_cast<Options*>(options);
        custTotal = o->custTotal;
        deliveryAt = 10;
        speed = o->speed;
        widget = o->widget;
    } else {
        custTotal = 20;
        deliveryAt = 10;
        speed = 1;
   }

    shops = new u_int32_t[SHOPS_COUNT];
    for (u_int8_t i = 0; i < SHOPS_COUNT; ++i) {
        shops[i] = rand() % 5 + custTotal;
    }

    customersData = new Customer[custTotal];
    for (u_int32_t i = 0; i < custTotal; ++i) {
        customersData[i].id = i;
    }
}

ThreadData::~ThreadData(){
    pthread_mutex_destroy(&mutexBuy);
    pthread_cond_destroy(&conditionDelivery);
    delete shops;
}

void *run(void *options) {
    tData = new ThreadData(options);

    pthread_t *customersThreads = new pthread_t[tData->custTotal];
    pthread_t warehouseManThread;
    pthread_t endDeliveryThread;

    pthread_create(&endDeliveryThread, NULL, &endDelivery, tData);
    pthread_create(&warehouseManThread, NULL, &deliver, &tData->deliveryAt);
    for (u_int32_t i = 0; i < tData->custTotal; ++i) {
        pthread_create(customersThreads+i, NULL, &buy, customersData+i);
    }

    for (u_int32_t i = 0; i < tData->custTotal; ++i) {
        pthread_join(customersThreads[i], NULL);
    }
    pthread_join(endDeliveryThread, NULL);
    pthread_join(warehouseManThread, NULL);

    delete tData;
    delete [] customersData;
    delete [] customersThreads;
    tData = NULL;
    customersData = NULL;
    printf("Shopping mall closed\n");
    return NULL;
}

void *buy(void *cust) {
    Customer* c = reinterpret_cast<Customer*>(cust);
    while (!tData->quit) {
        if(!c->busy){
            c->chooseShop();
            if (c->wantToBuy()) {
                pthread_cond_signal(&tData->conditionDelivery);
                pthread_mutex_lock(&tData->mutexBuy);
                --(tData->shops[c->desiredShop]);
                printf("Customer %d bought in %zu, last %d products\n", c->id,
                       c->desiredShop, tData->shops[c->desiredShop]);
                pthread_mutex_unlock(&tData->mutexBuy);
            } else {
                printf("Customer %d in cafe\n", c->id);
            }
        }
        sleep(tData->speed);
    }
    return NULL;
}

void *deliver(void *deliveryAt) {
    const u_int32_t D = *reinterpret_cast<int*>(deliveryAt);
    int i = 0;
    while (!tData->quit) {
        pthread_cond_wait(&tData->conditionDelivery, &tData->mutexBuy);

        for (i = 0; i < SHOPS_COUNT; ++i) {
            if (tData->shops[i] < D) {
                tData->shops[i] += DELIVERY_SIZE;
                printf("New delivery in shop %d\n", i);
            }
        }
    }
    return NULL;
}

void *endDelivery(void* c){
    while(!tData->quit){
        tData->widget->updateWarehouses();
        sleep(tData->speed);
    }
    pthread_mutex_lock(&tData->mutexBuy);
    pthread_cond_signal(&tData->conditionDelivery);
    pthread_mutex_unlock(&tData->mutexBuy);
    return NULL;
}
