import QtQuick 2.4
import Ubuntu.Components 1.3

Item {
    anchors {
        left: parent.left
        right: parent.right
    }
    height: units.gu(5)

    Row {
        anchors {
            left: parent.left
            right: parent.right
        }

        Rectangle {
            width: parent.width/2 - units.gu(3)
            height: units.gu(5)
            color: "transparent"

            Column {
                anchors.centerIn: parent
                width: parent.width

                ListItem {
                    height: units.gu(5)
                    divider.visible: false

                    ListItemLayout {
                        anchors.verticalCenter: parent.verticalCenter

                        title.text: languageChooserPage.languages[srcLang].name
                        title.font.weight: Font.Normal
                        title.color: "#fff"

                        Icon {
                            name: "down"
                            width: units.gu(2)
                            height: width
                            color: "#fff"
                        }
                    }

                    onClicked: {
                        languageChooserPage.mode = "src"
                        languageChooserPage.refreshList()
                        pageStack.push(languageChooserPage)
                    }
                }
            }
        }

        Rectangle {
            width: units.gu(6)
            height: units.gu(5)
            color: "transparent"

            ListItem {
                height: units.gu(5)
                divider.visible: false

                ListItemLayout {
                    anchors.verticalCenter: parent.verticalCenter

                    Icon {
                        anchors.centerIn: parent
                        name: "user-switch"
                        width: units.gu(3)
                        height: width
                        color: "#fff"
                    }
                }

                onClicked: {
                    var tmpSrcLang = srcLang
                    var tmpDestLang = destLang

                    srcLang = tmpDestLang
                    destLang = tmpSrcLang

                    translatePage.getTranslations()
                }
            }
        }

        Rectangle {
            width: parent.width/2 - units.gu(3)
            height: units.gu(5)
            color: "transparent"

            Column {
                anchors.centerIn: parent
                width: parent.width

                ListItem {
                    height: units.gu(5)
                    divider.visible: false

                    ListItemLayout {
                        anchors.verticalCenter: parent.verticalCenter

                        title.text: languageChooserPage.languages[destLang].name
                        title.font.weight: Font.Normal
                        title.color: "#fff"

                        Icon {
                            name: "down"
                            width: units.gu(2)
                            height: units.gu(2)
                            color: "#fff"
                        }
                    }

                    onClicked: {
                        languageChooserPage.mode = "dest"
                        languageChooserPage.refreshList()
                        pageStack.push(languageChooserPage)
                    }
                }
            }
        }
    }
}
