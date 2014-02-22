/*
    Copyright (C) 2011, 2013, 2014 Luciano Montanaro <mikelima@cirulla.net>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; see the file COPYING.  If not, write to
    the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
    Boston, MA 02110-1301, USA.
*/
import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    SilicaFlickable {
        anchors.fill: parent
        anchors.leftMargin: Theme.paddingLarge
        anchors.rightMargin: Theme.paddingLarge
        PageHeader {
            id: header
            anchors.top: parent.top
            title: qsTr("About Quattro Quarti")
        }

        Row {
            anchors.top: header.bottom
            id: firstSection
            spacing: Theme.paddingLarge
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: "/usr/share/icons/hicolor/86x86/apps/quattroquarti.png"
            }
            Label {
                textFormat: Text.RichText
                color: Theme.secondaryColor
                text: "<style>a:link{color:" + Theme.highlightColor + ";text-decoration:none}</style>" +
                      "<div style='font-size:large;font-weight:bold'><a href='https://github.com/mikelima/quattroquarti'>" +
                      qsTr("Quattro Quarti") + "</a></div>" + "<div style='font-size:small;'>" +
                      qsTr("version ") + Qt.application.version + "</div>"
                onLinkActivated: Qt.openUrlExternally(link)
            }
        }
        Column {
            anchors.top: firstSection.bottom
            anchors.topMargin: Theme.paddingLarge
            width: parent.width
            spacing: Theme.paddingLarge
            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                color: Theme.secondaryColor
                linkColor: Theme.highlightColor
                font.pixelSize: Theme.fontSizeSmall
                text: qsTr("A metronome for Sailfish OS")
            }
            Label {
                textFormat: Text.StyledText
                wrapMode: Text.WordWrap
                linkColor: Theme.highlightColor
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                text: "<p>" + qsTr("Copyright (c) 2014") +
                           "</p><p>Luciano Montanaro " +
                           "(<a href='mailto:mikelima@cirulla.net'>mikelima@cirulla.net</a>)</p><p>" +
                           qsTr("Licensed under the GNU Public License v2 or above") +
                      "</p>"
                onLinkActivated: Qt.openUrlExternally(link)
            }
        }
    }
}
