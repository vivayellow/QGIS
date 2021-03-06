/**
 * The QgsLayerTreeMapCanvasBridge class takes care of updates of layer set
 * for QgsMapCanvas from a layer tree. The class listens to the updates in the layer tree
 * and updates the list of layers for rendering whenever some layers are added, removed,
 * or their visibility changes.
 *
 * The update of layers is not done immediately - it is postponed, so a series of updates
 * to the layer tree will trigger just one update of canvas layers.
 *
 * Also allows the client to override the default order of layers. This is useful
 * in advanced cases where the grouping in layer tree should be independent from the actual
 * order in the canvas.
 *
 * @note added in 2.4
 */
class QgsLayerTreeMapCanvasBridge : QObject
{
%TypeHeaderCode
#include <qgslayertreemapcanvasbridge.h>
%End

  public:
    //! Constructor: does not take ownership of the layer tree nor canvas
    QgsLayerTreeMapCanvasBridge( QgsLayerTreeGroup* root, QgsMapCanvas* canvas, QObject* parent /TransferThis/ = 0 );

    void clear();

    QgsLayerTreeGroup* rootGroup() const;
    QgsMapCanvas* mapCanvas() const;

    //! Associates overview canvas with the bridge, so the overview will be updated whenever main canvas is updated
    //! @note added in 3.0
    void setOvervewCanvas( QgsMapOverviewCanvas* overviewCanvas );
    //! Returns associated overview canvas (may be null)
    //! @note added in 3.0
    QgsMapOverviewCanvas* overviewCanvas() const;

    bool hasCustomLayerOrder() const;
    QStringList customLayerOrder() const;

    QStringList defaultLayerOrder() const;

    //! if enabled, will automatically set full canvas extent and destination CRS + map units
    //! when first layer(s) are added
    void setAutoSetupOnFirstLayer( bool enabled );
    bool autoSetupOnFirstLayer() const;

  public slots:
    void setHasCustomLayerOrder( bool state );
    void setCustomLayerOrder( const QStringList& order );

    //! force update of canvas layers from the layer tree. Normally this should not be needed to be called.
    void setCanvasLayers();

    void readProject( const QDomDocument& doc );
    void writeProject( QDomDocument& doc );

  signals:
    void hasCustomLayerOrderChanged( bool );
    void customLayerOrderChanged( const QStringList& order );
    void canvasLayersChanged( const QList< QgsMapLayer* >& layers );

  protected:

    void defaultLayerOrder( QgsLayerTreeNode* node, QStringList& order ) const;

    void setCanvasLayers( QgsLayerTreeNode *node, QList<QgsMapLayer *> &canvasLayers, QList<QgsMapLayer *> &overviewLayers,
                          QList<QgsMapLayer *> &allLayers );

    void deferredSetCanvasLayers();

  protected slots:
    void nodeAddedChildren( QgsLayerTreeNode* node, int indexFrom, int indexTo );
    void nodeRemovedChildren();
    void nodeVisibilityChanged();
    void nodeCustomPropertyChanged( QgsLayerTreeNode* node, const QString& key );
};
