import QtQuick 2.4
import Ubuntu.Components 1.3

Item {
    anchors {
        left: parent.left
        right: parent.right
        verticalCenter: parent.verticalCenter
    }
    TextField {
        id: searchField
        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        primaryItem: Icon {
            anchors.leftMargin: units.gu(0.2)
            height: parent.height*0.5
            width: height
            name: "find"
        }
        hasClearButton: true
        inputMethodHints: Qt.ImhNoPredictiveText
        onVisibleChanged: {
            if (visible) {
                forceActiveFocus()
            }
        }
        onAccepted: {
            translatePage.search_term = text
            translatePage.getTranslations();
        }
    }
}
