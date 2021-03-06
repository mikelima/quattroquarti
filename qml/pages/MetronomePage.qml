/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.0


Page {
    id: page
    property alias tempo: tempoSlider.value
    property alias beat: beatSlider.value
    property int type: 2
    property int counter: 0

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("About Quattro Quarti")
                onClicked: pageStack.push(Qt.resolvedUrl("SecondPage.qml"))
            }
        }

        Component {
            id: gridDelegate
            ListItem {
                contentHeight: Theme.itemSizeExtraLarge
                contentWidth: Theme.itemSizeExtraLarge
                anchors.margins: Theme.paddingLarge

                onClicked: {
                    page.beat = model.beat
                    page.tempo = model.tempo
                }
                Column {
                    spacing: Theme.paddingMedium
                    Row {
                        Label {
                            color: Theme.highlightColor
                            text: "\u2669 = "

                        }
                        Label {
                            color: Theme.highlightColor
                            text: tempo
                        }
                    }
                    Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        Column {
                            Label {
                                color: Theme.secondaryColor
                                text: beat
                            }
                            Label {
                                color: Theme.secondaryColor
                                text: "4"
                            }
                        }
                    }
                }
            }
        }
        SilicaGridView {
            id: gridView
            width: page.width
            height: Theme.itemSizeLarge * 3
            cellWidth: Theme.itemSizeExtraLarge
            cellHeight: Theme.itemSizeExtraLarge
            header: PageHeader {
                title: "Quattro Quarti"
            }

            model: ListModel {
                ListElement {
                    tempo: 60
                    beat: 4
                }
                ListElement {
                    tempo: 90
                    beat: 4
                }
                ListElement {
                    tempo: 120
                    beat: 4
                }
                ListElement {
                    tempo: 180
                    beat: 4
                }
                ListElement {
                    tempo: 45
                    beat: 3
                }
                ListElement {
                    tempo: 60
                    beat: 3
                }
                ListElement {
                    tempo: 120
                    beat: 3
                }
                ListElement {
                    tempo: 180
                    beat: 3
                }
            }
            delegate: gridDelegate
        }
        Column {
            id: column

            width: page.width
            anchors.top: gridView.bottom
            anchors.topMargin: Theme.paddingLarge
            spacing: Theme.paddingLarge
            /*
            Row {
                anchors.margins: Theme.paddingLarge
                Label {
                    text: "\u2669 = "
                }
                Label {
                    text: tempo
                }
            }*/
            Slider {
                id: tempoSlider
                value: 120
                stepSize: 1
                minimumValue: 25
                maximumValue: 250
                width: parent.width
                valueText : "\u2669 = " + value
            }
            Slider {
                id: beatSlider
                value: 4
                stepSize: 1
                minimumValue: 2
                maximumValue: 9
                width: parent.width
                valueText : value + " / 4"
            }
            ComboBox {
                width: page.width
                label: qsTr("Style")
                menu: ContextMenu {
                    MenuItem { text: "Quarter note" }
                    MenuItem { text: "Eighth rest, Eighth note" }
                    MenuItem { text: "Eight note" }
                    MenuItem { text: "Triple" }
                    MenuItem { text: "Triple with center rest" }
                    MenuItem { text: "Sixteenth" }
                }
                onValueChanged: page.type = currentIndex
            }

            Row {
                id: playControl
                anchors.horizontalCenter: parent.horizontalCenter
                property bool playing: timer.running
                spacing: Theme.paddingLarge
                IconButton {
                    icon.source: "image://theme/icon-l-play"
                    onClicked: timer.start()
                    enabled: !playControl.playing
                }
                IconButton {
                    icon.source: "image://theme/icon-l-pause"
                    onClicked: timer.stop()
                    enabled: playControl.playing
                }
            }
        }
    }
    SoundEffect {
        id: tick
        source: Qt.resolvedUrl("../../sound/tick.wav")
    }
    SoundEffect {
        id: tack
        source: Qt.resolvedUrl("../../sound/tack.wav")
    }
    SoundEffect {
        id: tock
        source: Qt.resolvedUrl("../../sound/tock.wav")
    }

    Timer {
        id: timer
        property int divider: dividerForType(type)

        interval: 60000 / tempo / divider
        repeat: true

        function dividerForType(type) {
            switch (type) {
            case 0:
                return 1
            case 1:
            case 2:
                return 2
            case 3:
            case 4:
                return 3
            case 5:
                return 4
            }
        }

        onTriggered: {
            switch (type) {
            case 0:
                if (counter % beat === 0) {
                    tick.play()
                } else {
                    tack.play()
                }
                break;
            case 1:
                if (counter % (beat * divider) === 0) {
                    tick.play()
                } else if (counter % divider === 1) {
                    tock.play()
                }
                break;
            case 2:
            case 3:
            case 5:
                if (counter % (beat * divider) === 0) {
                    tick.play()
                } else if (counter % (divider) === 0) {
                    tack.play()
                } else {
                    tock.play()
                }
                break;
            case 4:
                if (counter % (beat * divider) === 0) {
                    tick.play()
                } else if (counter % (divider) === 0) {
                    tack.play()
                } else if (counter % (divider) === 2) {
                    tock.play()
                } else {
                }
                break;
            }
            counter++
        }
    }
    Component.onCompleted: timer.start()
}


