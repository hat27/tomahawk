import QtQuick 1.1
import tomahawk 1.0
import "tomahawkimports"

Rectangle {
    id: scene
    color: "black"
    anchors.fill: parent
    state: "list"

    ListModel {
        id: modeModel
        ListElement { label: "By Artist"; image: "../images/artist-placeholder-grid.png"; creatorContent: "stations/CreateByArtist.qml" }
        ListElement { label: "By Genre"; image: "../images/album-placeholder-grid.png"; creatorContent: "stations/CreateByGenre.qml" }
        ListElement { label: "By Year"; image: "image://albumart/foobar"; creatorContent: "year" }
    }

    VisualItemModel {
        id: stationVisualModel

        StationCreatorPage1 {
            height: scene.height
            width: scene.width
            model: modeModel

            onItemClicked: {
                stationCreator.content = modeModel.get(index).creatorContent
                stationListView.incrementCurrentIndex()
            }
        }

        StationCreatorPage2 {
            id: stationCreator
            height: scene.height
            width: scene.width
            nextEnabled: rootView.configured

            onBack: stationListView.decrementCurrentIndex()

            onNext: stationListView.incrementCurrentIndex()
        }

        StationView {
            coverSize: Math.min(scene.height, scene.width) / 2
            height: scene.height
            width: scene.width
//            visible: stationListView.currentIndex == 1

            onBackClicked: stationListView.decrementCurrentIndex()
        }

    }

    ListView {
        id: stationListView
        anchors.fill: parent
        contentHeight: scene.height
        contentWidth: scene.width
        orientation: ListView.Horizontal
        model: stationVisualModel
        interactive: false
        highlightMoveDuration: 300

        onHeightChanged: {
            contentHeight = scene.height
        }
        onWidthChanged: {
            contentWidth = scene.width
        }
    }
}