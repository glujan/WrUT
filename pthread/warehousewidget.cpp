#include <QTimer>
#include <QGraphicsScene>
#include "warehousewidget.h"
#include "walkingcustomer.h"
#include "threads.h"


WarehouseWidget::WarehouseWidget(QWidget *parent): QGraphicsView(parent),
    scene(new QGraphicsScene(rect(),this)), horLine(NULL) {
    this->setScene(scene);
    vertLines = new QGraphicsLineItem*[SHOPS_COUNT];

    this->setVerticalScrollBarPolicy(Qt::ScrollBarAlwaysOff);
    this->setHorizontalScrollBarPolicy(Qt::ScrollBarAlwaysOff);
}

void WarehouseWidget::resizeEvent(QResizeEvent *) {
    scene->setSceneRect(rect());
    if (horLine){
        scene->removeItem(horLine);
        delete horLine;
        horLine = 0;
        for (int i=1; i<SHOPS_COUNT; ++i){
            scene->removeItem(vertLines[i]);
            delete vertLines[i];
            vertLines[i] = 0;
        }
    }

    QLine line = QLine(0, height()/2, width(), height()/2);
    horLine = scene->addLine(line);

    for (int i=1; i<SHOPS_COUNT; ++i){
        line = QLine(width()/SHOPS_COUNT * i, 0, width()/SHOPS_COUNT * i, height()/2);
        vertLines[i] = scene->addLine(line);
    }
}

void WarehouseWidget::start(const u_int32_t total){
    custTotal = total;
    walkingCustomers = new WalkingCustomer*[total];
    for (u_int32_t i=0; i!=total; ++i) {
        WalkingCustomer* customer = new WalkingCustomer(0, scene);
        customer->setPos((i - 1.0) * 32 + (0.5 * width()),
                        (i - 1.0) * 32 + (0.5 * height())
        );
        walkingCustomers[i] = customer;
    }

    {
        QTimer * const timer = new QTimer(this);
        QObject::connect(timer, SIGNAL(timeout()), scene, SLOT(advance()));
        timer->setInterval(20);
        timer->start();
    }
}

void WarehouseWidget::stop(){
    for (u_int32_t i=0; i!=custTotal; ++i) {
        scene->removeItem(walkingCustomers[i]);
    }
    delete [] walkingCustomers;
    walkingCustomers = 0;
}

void WarehouseWidget::updateWarehouses() {
    for (u_int32_t i=0; i!=custTotal; ++i) {
        customersData[i].busy = walkingCustomers[i]->goTo(customersData[i].desiredShop);
    }
}
