#ifndef THREADS_H
#define THREADS_H

#include <pthread.h>
#include "warehousewidget.h"

#define SHOPS_COUNT 5
#define DELIVERY_SIZE 15

struct Customer {
    size_t desiredShop;
    int32_t id;
    bool busy;

    bool wantToBuy();
    void chooseShop();
};

struct Options {
    Options(u_int32_t custTotal, u_int8_t speed, WarehouseWidget *widget);
    u_int32_t custTotal;
    u_int8_t speed;
    WarehouseWidget* widget;
};

struct ThreadData {
    ThreadData(void *options);
    ~ThreadData();

    pthread_mutex_t mutexBuy;
    pthread_cond_t conditionDelivery;
    u_int32_t deliveryAt;
    u_int32_t custTotal;
    u_int32_t *shops;
    u_int8_t speed;
    WarehouseWidget *widget;
    bool quit;
};

extern Customer* customersData;
extern ThreadData* tData;

extern enum Speed {
    FAST = 1,
    MODERATE = 3,
    SLOW = 5
} speed;

void *run(void *options);
void *buy(void *cust);
void *deliver(void *deliveryAt);
void *endDelivery(void* c);

#endif // THREADS_H
