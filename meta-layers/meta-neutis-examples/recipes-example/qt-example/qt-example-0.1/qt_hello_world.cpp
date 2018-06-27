#include <QApplication>
#include <QImage>
#include <QLabel>
 
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    QImage image("/home/root/image.png");
 
    QLabel label;
    label.setPixmap(QPixmap::fromImage(image));
 
    label.show();
    return a.exec();
}
