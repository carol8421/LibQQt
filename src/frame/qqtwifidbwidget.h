#ifndef QQTWIFIDBWIDGET_H
#define QQTWIFIDBWIDGET_H

#include <qqtwidget.h>

class QQtWifiDBWidget : public QQtWidget
{
    Q_OBJECT
    Q_ENUMS(DB_STAT)

public:
    enum DB_STAT
    {
        Db_S0 = 0,
        Db_S1 = 1,
        Db_S2 = 2,
        Db_S3 = 3,
        Db_S4 = 4,
        Db_S5 = 5,
        Db_SMax
    };

    explicit QQtWifiDBWidget(QWidget* parent = nullptr);
    virtual ~QQtWifiDBWidget() {}

    void setDB(DB_STAT s);
    void setDbPixMap(DB_STAT s, QString pixname);

signals:

public slots:

private:
    QString pic[DB_STAT];
};

#endif // QQTWIFIDBWIDGET_H