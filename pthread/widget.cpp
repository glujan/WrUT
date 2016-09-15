#include "widget.h"
#include "ui_widget.h"
#include "threads.h"

Widget::Widget(QWidget *parent) :
        QWidget(parent), ui(new Ui::Widget){
    ui->setupUi(this);
    setUiEnabled(true);
}

Widget::~Widget() {
    delete ui;
    if(tData){
        tData->quit = true;
        pthread_join(mallThread, NULL);
        delete tData;
    }
}

void Widget::on_startButton_clicked() {
    setUiEnabled(false);
    u_int32_t cust_total = ui->customerSpin->value();
    const u_int8_t speed = getSpeed();
    Options *options = new Options(cust_total, speed, ui->graphicsView);
    ui->graphicsView->start(cust_total);
    pthread_create(&mallThread, NULL, &run, options);
}

void Widget::setUiEnabled(bool enabled) {
    ui->customerSpin->setEnabled(enabled);
    ui->customerSpinLabel->setEnabled(enabled);
    ui->radio1->setEnabled(enabled);
    ui->radio2->setEnabled(enabled);
    ui->radio3->setEnabled(enabled);
    ui->speedRadioLabel->setEnabled(enabled);

    ui->startButton->setEnabled(enabled);
    ui->stopButton->setEnabled(!enabled);
}

u_int8_t Widget::getSpeed() {
    if(ui->radio1->isChecked()) {
        return FAST;
    } else if(ui->radio2->isChecked()) {
        return MODERATE;
    } else {
    return SLOW;
    }
}

void Widget::on_stopButton_clicked() {
    setUiEnabled(true);
    tData->quit = true;
    pthread_join(mallThread, NULL);
    ui->graphicsView->stop();
}
