import QtQuick 2.4
import Ubuntu.Components 1.3

import "../components"
import "../js/scripts.js" as Scripts

Page {
    id: translatePage

    header: PageHeader {
        id: pageHeader
        title: i18n.tr("Translate")
        leadingActionBar {
            actions: navActions
        }

        contents: SearchPanel {

        }

        extension: LanguageChooserPanel {
            id: languageChooserPanel
        }

        StyleHints {
            foregroundColor: "#fff"
            backgroundColor: "#146eb4" //4285f4
        }
    }

    property bool clear_models: false

    property bool list_loading: false

    property string search_term: ""

    function getTranslationsFinished(data) {
        if (data.result === "ok") {
            worker.sendMessage({'feed': 'translatePage', 'obj': data, 'model': translationsModel, 'clear_model': clear_models})

            list_loading = false
        }
    }

    function getTranslations()
    {
        if (search_term != "") {
            list_loading = true
            clear_models = true

            translationsModel.clear()

            Scripts.get_translations(search_term)
        }
    }

    WorkerScript {
        id: worker
        source: "../js/Worker.js"
        onMessage: {

        }
    }

    Component.onCompleted: {

    }

    BouncingProgressBar {
        z: 10
        anchors.top: translatePage.header.bottom
        visible: list_loading
    }

    ListModel {
        id: translationsModel
    }

    ListView {
        id: translationsList
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            top: translatePage.header.bottom
        }
        visible: translationsModel.count != 0
        clip: true
        model: translationsModel
        header: ListItem {
            height: translationsHeaderLayout.height

            ListItemLayout {
                id: translationsHeaderLayout

                title.text: i18n.tr("Translations")
                title.font.weight: Font.Normal
            }
        }
        delegate: ListItem {
            id: translateDelegate
            height: layout.height + divider.height
            divider.visible: true
            onClicked: {

            }

            SlotsLayout {
                id: layout
                anchors.centerIn: parent

                mainSlot: Row {
                    id: label
                    spacing: units.gu(1)
                    width: parent.width - showDetails.width - units.gu(6)

                    Column {
                        width: parent.width
                        Text {
                            text: phrase.text
                            font.weight: Font.DemiBold
                            width: parent.width
                            wrapMode: Text.WordWrap
                        }

                        Text {
                            text: typeof(meanings) != 'undefined' ? meanings.get(0).text : ""
                            visible: typeof(meanings) != 'undefined' && !transMeanings.visible
                            width: parent.width
                            wrapMode: Text.WordWrap

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    if (typeof(meanings) != 'undefined' && typeof(meanings.get(1)) != 'undefined') {
                                        transMeanings.visible = !transMeanings.visible
                                    }
                                }
                            }
                        }

                        Column {
                            id: transMeanings
                            width: parent.width
                            spacing: units.gu(1)
                            visible: false
                            Repeater {
                                model: meanings

                                Label {
                                    text: meanings.get(index).text
                                    width: parent.width
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }
                    }
                }

                Icon {
                    id: showDetails
                    name: transMeanings.visible ? "up" : "down"
                    width: typeof(meanings) != 'undefined' && typeof(meanings.get(1)) != 'undefined' ? units.gu(2) : 0
                    height: width
                    visible: typeof(meanings) != 'undefined' && typeof(meanings.get(1)) != 'undefined'

                    SlotsLayout.position: SlotsLayout.Trailing

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            transMeanings.visible = !transMeanings.visible
                        }
                    }
                }
            }
        }
    }

    Column {
        anchors.centerIn: parent
        visible: translationsModel.count == 0 && !list_loading
        spacing: units.gu(1)

        Icon {
            anchors.horizontalCenter: parent.horizontalCenter
            width: units.gu(5)
            height: width
            name: translationsModel.count == 0 && search_term == "" ? "find" : "dialog-warning-symbolic"
        }

        Label {
            id: emptyTextLabel
            font.weight: Font.Normal
            fontSize: "large"
            wrapMode: Text.WordWrap
            text: translationsModel.count == 0 && search_term == "" ? i18n.tr("Search anything") : i18n.tr("No results found")
        }
    }
}
