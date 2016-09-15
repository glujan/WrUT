#include <cmath>
#include <QGraphicsItem>
#include <QGraphicsScene>
#include <QPainter>
#include "walkingcustomer.h"
#include "threads.h"

WalkingCustomer::WalkingCustomer(QGraphicsItem *parent, QGraphicsScene *scene)
    : QGraphicsItem(parent,scene), m_dx(1.0), m_dy(1.0), scene(scene) {
    desired = new QPoint();
}

void WalkingCustomer::advance(int phase) {
    if (phase == 0){
        if (x() < desired->x()){
            m_dx = 1.0;
        } else if (x() > desired->x()){
            m_dx = -1.0;
        } else {
            m_dx = 0;
        }

        if (y() < desired->y()){
            m_dy = 1.0;
        } else if (y() > desired->y()){
            m_dy = -1.0;
        } else {
            m_dy = 0;
        }
    } else if (phase == 1){
        this->setPos(x() + m_dx, y() + m_dy);
    }
}

QRectF WalkingCustomer::boundingRect() const {
    return QRectF(-16.0,-16.0,32.0,32.0);
}

void WalkingCustomer::paint(QPainter *painter,
                            const QStyleOptionGraphicsItem *option, QWidget *widget) {
    painter->drawEllipse(this->boundingRect());
}

QPainterPath WalkingCustomer::shape() const {
    QPainterPath p;
    p.addEllipse(boundingRect());
    return p;
}

bool WalkingCustomer::goTo(u_int32_t desiredShop){
    int width = scene->width(), height_half = scene->height()/2;
    int shopWidth = width/SHOPS_COUNT;
    int shopStart = shopWidth * desiredShop;

    if (desiredShop == SHOPS_COUNT){
        desired->setY(height_half + boundingRect().height() * 0.5 + rand() % static_cast<int>(height_half - boundingRect().height()));
        desired->setX( 0          + boundingRect().width()  * 0.5 + rand() % static_cast<int>(width       - boundingRect().width( )));
    } else {
        desired->setY( 0          + boundingRect().height() * 0.5 + rand() % static_cast<int>(height_half - boundingRect().height()));
        desired->setX(shopStart   + boundingRect().width()  * 0.5 + rand() % static_cast<int>(shopWidth   - boundingRect().width( )));
    }

    if (m_dx == 0 && m_dy == 0){
        return false;
    }
    return true;
}
