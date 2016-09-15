#ifndef WALKINGCUSTOMER_H
#define WALKINGCUSTOMER_H

#include <QGraphicsItem>

struct QGraphicsScene;

struct WalkingCustomer : public QGraphicsItem {
    WalkingCustomer(QGraphicsItem *parent, QGraphicsScene *scene);
    void advance(int phase);
    QRectF boundingRect() const;
    QPainterPath shape() const;
    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget);
    bool goTo(u_int32_t desiredShop);

private:
    double m_dx;
    double m_dy;
    QPoint * desired;
    QGraphicsScene * const scene;
};

#endif // WALKINGCUSTOMER_H
