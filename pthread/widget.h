#ifndef WIDGET_H
#define WIDGET_H

#include <QWidget>
#include <pthread.h>

namespace Ui {
class Widget;
}

class Widget : public QWidget
{
    Q_OBJECT
    
public:
    explicit Widget(QWidget *parent = 0);
    ~Widget();
    
private slots:
    void on_startButton_clicked();

    void on_stopButton_clicked();

private:
    u_int8_t getSpeed();
    void setUiEnabled(bool enable);
    pthread_t mallThread;
    Ui::Widget *ui;
};

#endif // WIDGET_H
