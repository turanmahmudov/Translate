import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
    id: translatePage

    header: PageHeader {
        id: pageHeader
        title: i18n.tr("Translate")

        leadingActionBar {
            actions: navActions
        }

        trailingActionBar {
            actions: [
                Action {
                    text: i18n.tr("Change languages")
                    iconName: "language-chooser"
                    onTriggered: {
                        pageStack.push(languageChooserPage)
                    }
                }

            ]
        }

        StyleHints {
            //foregroundColor: "#fff"
            //backgroundColor: "#4d90fe"
        }

        /*contents: Rectangle {
            color: "#fff"
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
                }
            }
        }*/
    }

    Item {
        id: languageChooserPanel
        anchors {
            left: parent.left
            right: parent.right
            top: translatePage.header.bottom
        }
        height: units.gu(5.1)

        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: units.gu(0.1)
            color: UbuntuColors.lightGrey
        }

        Row {
            anchors {
                left: parent.left
                right: parent.right
                margins: units.gu(2)
                topMargin: 0
            }

            Rectangle {
                width: parent.width/2 - units.gu(3)
                height: units.gu(5)

                Column {
                    anchors.centerIn: parent
                    width: parent.width

                    Label {
                        width: parent.width
                        text: "English"
                        font.weight: Font.Normal
                        horizontalAlignment: Text.AlignLeft
                    }
                }
            }

            Rectangle {
                width: units.gu(6)
                height: units.gu(5)

                Icon {
                    anchors.centerIn: parent
                    name: "user-switch"
                    width: units.gu(3)
                    height: width
                }
            }

            Rectangle {
                width: parent.width/2 - units.gu(3)
                height: units.gu(5)

                Column {
                    anchors.centerIn: parent
                    width: parent.width

                    Label {
                        width: parent.width
                        text: "Spanish"
                        font.weight: Font.Normal
                        horizontalAlignment: Text.AlignRight
                    }
                }
            }
        }
    }

    Flickable {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            top: languageChooserPanel.bottom
        }
        contentHeight: columnSuperior.height
        clip: true

        Column {
           id: columnSuperior
           width: parent.width

           Item {
               anchors {
                   left: parent.left
                   right: parent.right
               }
               height: units.gu(7.1)

               Rectangle {
                   anchors.bottom: parent.bottom
                   width: parent.width
                   height: units.gu(0.1)
                   color: UbuntuColors.lightGrey
               }

               TextField {
                   anchors {
                       left: parent.left
                       right: parent.right
                       leftMargin: units.gu(1)
                       rightMargin: units.gu(1)
                   }
                   height: units.gu(6)
                   placeholderText: i18n.tr("Tap to enter text")
                   font.weight: Font.Normal
                   font.pixelSize: FontUtils.sizeToPixels("large")
                   StyleHints {
                       borderColor: "transparent"
                   }
               }
           }

           ListItem {
               visible: false
               height: translationsHeaderLayout.height

               ListItemLayout {
                   id: translationsHeaderLayout

                   title.text: i18n.tr("Translations")
                   title.font.weight: Font.Normal
               }
           }
        }
    }
}

