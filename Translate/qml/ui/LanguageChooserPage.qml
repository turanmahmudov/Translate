import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

Page {
    id: languageChooserPage

    header: PageHeader {
        title: mode == "src" ? i18n.tr("Translate from") : i18n.tr("Translate to")
        leadingActionBar.actions: [
            Action {
                id: closePageAction
                text: i18n.tr("Close")
                iconName: "close"
                onTriggered: {
                    pageStack.pop();
                }
            }
        ]

        StyleHints {
            foregroundColor: "#fff"
            backgroundColor: "#146eb4" //4285f4
        }
    }

    property string mode: "src"

    property var languages: {
        "sq":{"code":"sq", "name":i18n.tr("Albanian")},
        "ar":{"code":"ar", "name":i18n.tr("Arabic")},
        "hy":{"code":"hy", "name":i18n.tr("Armenian")},
        "az":{"code":"az", "name":i18n.tr("Azerbaijan")},
        "be":{"code":"be", "name":i18n.tr("Belarusian")},
        "bs":{"code":"bs", "name":i18n.tr("Bosnian")},
        "bg":{"code":"bg", "name":i18n.tr("Bulgarian")},
        "ca":{"code":"ca", "name":i18n.tr("Catalan")},
        "zh":{"code":"zh", "name":i18n.tr("Chinese")},
        "hr":{"code":"hr", "name":i18n.tr("Croatian")},
        "cs":{"code":"cs", "name":i18n.tr("Czech")},
        "da":{"code":"da", "name":i18n.tr("Danish")},
        "nl":{"code":"nl", "name":i18n.tr("Dutch")},
        "en":{"code":"en", "name":i18n.tr("English")},
        "et":{"code":"et", "name":i18n.tr("Estonian")},
        "fi":{"code":"fi", "name":i18n.tr("Finnish")},
        "fr":{"code":"fr", "name":i18n.tr("French")},
        "gl":{"code":"gl", "name":i18n.tr("Galician")},
        "ka":{"code":"ka", "name":i18n.tr("Georgian")},
        "de":{"code":"de", "name":i18n.tr("German")},
        "el":{"code":"el", "name":i18n.tr("Greek")},
        "he":{"code":"he", "name":i18n.tr("Hebrew")},
        "hi":{"code":"hi", "name":i18n.tr("Hindi")},
        "hu":{"code":"hu", "name":i18n.tr("Hungarian")},
        "is":{"code":"is", "name":i18n.tr("Icelandic")},
        "id":{"code":"id", "name":i18n.tr("Indonesian")},
        "it":{"code":"it", "name":i18n.tr("Italian")},
        "ja":{"code":"ja", "name":i18n.tr("Japanese")},
        "ko":{"code":"ko", "name":i18n.tr("Korean")},
        "ku":{"code":"ku", "name":i18n.tr("Kurdish")},
        "lv":{"code":"lv", "name":i18n.tr("Latvian")},
        "lt":{"code":"lt", "name":i18n.tr("Lithuanian")},
        "mk":{"code":"mk", "name":i18n.tr("Macedonian")},
        "ms":{"code":"ms", "name":i18n.tr("Malay")},
        "mt":{"code":"mt", "name":i18n.tr("Maltese")},
        "cmn":{"code":"cmn", "name":i18n.tr("Mandarin")},
        "no":{"code":"no", "name":i18n.tr("Norwegian")},
        "fa":{"code":"fa", "name":i18n.tr("Persian")},
        "pl":{"code":"pl", "name":i18n.tr("Polish")},
        "pt":{"code":"pt", "name":i18n.tr("Portuguese")},
        "ro":{"code":"ro", "name":i18n.tr("Romanian")},
        "ru":{"code":"ru", "name":i18n.tr("Russian")},
        "sr":{"code":"sr", "name":i18n.tr("Serbian")},
        "sk":{"code":"sk", "name":i18n.tr("Slovak")},
        "sl":{"code":"sl", "name":i18n.tr("Slovenian")},
        "es":{"code":"es", "name":i18n.tr("Spanish")},
        "sv":{"code":"sv", "name":i18n.tr("Swedish")},
        "tr":{"code":"tr", "name":i18n.tr("Turkish")},
        "uk":{"code":"uk", "name":i18n.tr("Ukranian")},
        "vi":{"code":"vi", "name":i18n.tr("Vietnamese")},
        "cy":{"code":"cy", "name":i18n.tr("Welsh")}
    }

    property var languages_var: ["sq","ar","hy","az","be","bs","bg","ca","zh","hr","cs","da","nl","en","et","fi","fr","gl","ka","de","el","he","hi","hu","is","id","it","ja","ko","ku","lv","lt","mk","ms","mt","cmn","no","fa","pl","pt","ro","ru","sr","sk","sl","es","sv","tr","uk","vi","cy"]

    function refreshList() {
        languagesModel.clear()
        for (var i = 0; i < languages_var.length; i++) {
            var code = languages_var[i]
            languagesModel.append({"code":code, "name":languages[code].name})
        }
    }

    Component.onCompleted: {

    }

    ListModel {
        id: languagesModel
    }

    ListView {
        id: languagesList
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            top: languageChooserPage.header.bottom
        }
        clip: true
        model: languagesModel
        delegate: ListItem {
            id: languageDelegate
            height: layout.height
            divider.visible: true
            onClicked: {
                var tmpSrcLang = srcLang
                var tmpDestLang = destLang

                if (mode == "src") {
                    srcLang = code

                    if (destLang == code) {
                        destLang = tmpSrcLang
                    }
                } else {
                    destLang = code

                    if (srcLang == code) {
                        srcLang = tmpDestLang
                    }
                }

                translatePage.getTranslations()

                pageStack.pop()
            }

            SlotsLayout {
                id: layout
                anchors.centerIn: parent

                mainSlot: Row {
                    id: label
                    spacing: units.gu(1)
                    width: parent.width - checkedLangIcon.width - units.gu(6)

                    Text {
                        text: name
                    }
                }

                Icon {
                    id: checkedLangIcon
                    width: units.gu(2)
                    height: width
                    name: "tick"

                    visible: mode == "src" ? (code == srcLang) : (code == destLang)

                    anchors.verticalCenter: parent.verticalCenter
                    SlotsLayout.position: SlotsLayout.Trailing
                    SlotsLayout.overrideVerticalPositioning: true
                }
            }
        }
    }
}
