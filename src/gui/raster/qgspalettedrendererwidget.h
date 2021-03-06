/***************************************************************************
                         qgspalettedrendererwidget.h
                         ---------------------------
    begin                : February 2012
    copyright            : (C) 2012 by Marco Hugentobler
    email                : marco at sourcepole dot ch
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#ifndef QGSPALETTEDRENDERERWIDGET_H
#define QGSPALETTEDRENDERERWIDGET_H

#include "qgsrasterrendererwidget.h"
#include "ui_qgspalettedrendererwidgetbase.h"
#include "qgis_gui.h"

class QgsRasterLayer;

/** \ingroup gui
 * \class QgsPalettedRendererWidget
 */
class GUI_EXPORT QgsPalettedRendererWidget: public QgsRasterRendererWidget, private Ui::QgsPalettedRendererWidgetBase
{
    Q_OBJECT

  public:

    QgsPalettedRendererWidget( QgsRasterLayer *layer, const QgsRectangle &extent = QgsRectangle() );
    static QgsRasterRendererWidget *create( QgsRasterLayer *layer, const QgsRectangle &extent ) { return new QgsPalettedRendererWidget( layer, extent ); }

    QgsRasterRenderer *renderer() override;

    void setFromRenderer( const QgsRasterRenderer *r );

  private:

    enum Column
    {
      ValueColumn = 0,
      ColorColumn = 1,
      LabelColumn = 2,
    };

    QMenu *contextMenu = nullptr;

  private slots:

    void on_mTreeWidget_itemDoubleClicked( QTreeWidgetItem *item, int column );
    void on_mTreeWidget_itemChanged( QTreeWidgetItem *item, int column );
    void changeColor();
    void changeTransparency();
};

#endif // QGSPALETTEDRENDERERWIDGET_H
