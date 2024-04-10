#include "notepad.h"
#include "ui_notepad.h"
#include <QFile>
#include <QMessageBox>
#include <QFontDialog>
#include <QColorDialog>
#include <QFileDialog>
#include <iostream>
#include <fstream>
#include <string>

using namespace std;



Notepad::Notepad(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::Notepad)
{
    ui->setupUi(this);
    this->setCentralWidget(ui->textEdit);

    connect(ui->actionFont, &QAction::triggered, this, &Notepad::selectFont);
    connect(ui->actionCopy, &QAction::triggered, this, &Notepad::Copy);
    connect(ui->actionCut, &QAction::triggered, this, &Notepad::Cut);
    connect(ui->actionPaste, &QAction::triggered, this, &Notepad::Paste);
    connect(ui->actionUndo, &QAction::triggered, this, &Notepad::Undo);
    connect(ui->actionRedo, &QAction::triggered, this, &Notepad::Redo);
    connect(ui->actionItalique, &QAction::triggered, this, &Notepad::setItalic);
    connect(ui->actionUnderline, &QAction::triggered, this, &Notepad::setUnderline);
    connect(ui->actionBold, &QAction::triggered, this, &Notepad::setBold);
}

Notepad::~Notepad()
{
    delete ui;
}


void Notepad::setItalic(bool italic){
    ui->textEdit->setFontItalic(italic);
}
void Notepad::setUnderline(bool underline){
    ui->textEdit->setFontUnderline(underline);
}
void Notepad::setBold(bool b){
    if(!b){
        ui->textEdit->setFontWeight(QFont::Normal);
    }else{
        ui->textEdit->setFontWeight(QFont::Bold);
    }
}

void Notepad::selectFont()
{
    bool fontSelected;
    QFont font = QFontDialog::getFont(&fontSelected, this);
    if (fontSelected)
    ui->textEdit->setCurrentFont(font);
}

void Notepad::Copy(){
    ui->textEdit->copy();
}
void Notepad::Cut(){
    ui->textEdit->cut();
}
void Notepad::Paste(){
    ui->textEdit->paste();
}
void Notepad::Undo(){
    ui->textEdit->undo();
}
void Notepad::Redo(){
    ui->textEdit->redo();

}

void Notepad::on_actionNew_triggered()
{
    currentFile.clear();
    ui->textEdit->setText(QString());
}


void Notepad::on_actionOpen_triggered()
{
    QString fileName = QFileDialog::getOpenFileName(this, "Open the file");
    if (fileName.isEmpty())
    return;
    QFile file(fileName);
    currentFile = fileName;
    if (!file.open(QIODevice::ReadOnly | QFile::Text)) {
    QMessageBox::warning(this, "Warning", "Cannot open file: " +
    file.errorString());
    return;
    }
    setWindowTitle(fileName);
    QTextStream in(&file);
    QString text = in.readAll();
    ui->textEdit->setText(text);
    file.close();
}


void Notepad::on_actionSave_triggered()
{
    QFile file(currentFile);
    if(!file.open(QFile::WriteOnly | QFile::Text)){
        on_actionSave_as_triggered();
        return;
    }

    QTextStream out(&file);
    QString text = ui->textEdit->toPlainText();

    out << text;
    file.flush();
    file.close();
}


void Notepad::on_actionSave_as_triggered()
{
    QString fileName = QFileDialog::getSaveFileName(this, "Choose directory");
    QFile file(fileName);
    if(!file.open(QFile::WriteOnly | QFile::Text)){
        return;
    }
    currentFile = fileName;

    QTextStream out(&file);
    QString text = ui->textEdit->toPlainText();

    out << text;
    file.flush();
    file.close();
}


void Notepad::on_actionAbout_triggered(){
    QMessageBox message;
    message.setText("The Notepad example demonstrates how to code a basic text editor using QtWidgets");
    message.setStandardButtons(QMessageBox::Ok);
    message.setWindowTitle("About MDI");
    message.exec();
}


void Notepad::on_actionExit_triggered()
{
    QMessageBox::StandardButton message;
    message = QMessageBox::question(this, "Test", "Quit?",
                                    QMessageBox::Yes|QMessageBox::No);
      if (message == QMessageBox::Yes) {
        qDebug() << "Yes was clicked";
        QApplication::quit();
      } else {
        qDebug() << "Yes was *not* clicked";
      }
}


void Notepad::on_actionColor_triggered()
{
    QColorDialog color;
    ui->textEdit->setTextColor(color.getColor(Qt::yellow, this ));
}

