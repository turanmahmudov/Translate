import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import Qt.labs.settings 1.0

import "qml/ui"

MainView {
    id: mainView
    objectName: "mainView"
    applicationName: "translate.turan-mahmudov-l"

    automaticOrientation: true

    width: units.gu(50)
    height: units.gu(75)

    // API
    property string api_url: "https://glosbe.com/gapi/"

    // App version
    property string current_version: "0.1"

    // Startup settings
    Settings {
        id: settings
        property string donateMe: ""

        property string lastSrcLang: "en"
        property string lastDestLang: "es"
    }
    property alias donateMe: settings.donateMe

    property alias srcLang: settings.lastSrcLang
    property alias destLang: settings.lastDestLang

    // Navigation Menu Actions
    property list<Action> navActions: [
        Action {
            text: i18n.tr("Translate")
            iconName: "user-switch"
            onTriggered: {
                tabs.selectedTabIndex = 0
            }
        },
        Action {
            text: i18n.tr("About")
            iconName: "info"
            onTriggered: {
                tabs.selectedTabIndex = 1
            }
        }
    ]

    Component.onCompleted: {
        start()
    }

    function start() {
        pageStack.clear()
        init()
    }

    function init() {
        pageStack.push(tabs)

        // Donate me dialog
        if (donateMe === "") {
            PopupUtils.open(donateMeComponent);
            donateMe = "showed"
        }
    }

    PageStack {
        id: pageStack
    }

    Tabs {
        id: tabs
        visible: false

        Tab {
            id: homeTab

            TranslatePage {
                id: translatePage
            }
        }

        Tab {
            id: aboutTab

            AboutPage {
                id: aboutPage
            }
        }
    }

    LanguageChooserPage {
        id: languageChooserPage
        visible: false
    }

    Component {
        id: donateMeComponent

        Dialog {
            id: donateMeDialog
            title: i18n.tr("Donate me")
            text: i18n.tr("Donate to support me continue developing for Ubuntu.")

            Row {
                spacing: units.gu(1)
                Button {
                    width: parent.width/2 - units.gu(0.5)
                    text: i18n.tr("Ignore")
                    onClicked: PopupUtils.close(donateMeDialog)
                }

                Button {
                    width: parent.width/2 - units.gu(0.5)
                    text: i18n.tr("Donate")
                    color: UbuntuColors.blue
                    onClicked: {
                        Qt.openUrlExternally("https://liberapay.com/turanmahmudov")
                        PopupUtils.close(donateMeDialog)
                    }
                }
            }
        }
    }
}
