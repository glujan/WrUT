#ifndef WAREHOUSEWIDGET_H
#define WAREHOUSEWIDGET_H

#include <QGraphicsView>

struct QGraphicsScene;
struct WalkingCustomer;

class WarehouseWidget : public QGraphicsView {
public:
    WarehouseWidget(QWidget *parent = 0);
    void start(const u_int32_t total);
    void stop();
    void updateWarehouses();

protected:
    void resizeEvent(QResizeEvent *event);

private:
    QGraphicsScene * const scene;
    QGraphicsLineItem *horLine;
    QGraphicsLineItem **vertLines;
    WalkingCustomer **walkingCustomers;
    u_int32_t custTotal;
};

#endif // WAREHOUSEWIDGET_H
