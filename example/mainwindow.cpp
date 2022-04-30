#include "mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
{
    //Включаем наш QML
        ui = new QDeclarativeView;
        ui->setSource(QUrl("qrc:/main.qml"));
        setCentralWidget(ui);
        ui->setResizeMode(QDeclarativeView::SizeRootObjectToView);
}

MainWindow::~MainWindow()
{
    delete ui;
}

