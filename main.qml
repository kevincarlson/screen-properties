import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

ApplicationWindow {
    id: mainWindow
    title: qsTr("Display Properties")
    width: 640
    height: 480
    visible: true

    GridLayout {
        id: gridLayout1
        anchors.rightMargin: 16
        anchors.leftMargin: 16
        anchors.bottomMargin: 16
        anchors.topMargin: 16
        columnSpacing: 16
        rowSpacing: 16
        anchors.fill: parent
        flow: getLayoutDirection()

        ColumnLayout {
            id: columnLayout1
            spacing: 16

            Label {
                id: label1
                text: qsTr("Horizontal Resolution")
                font.pointSize: 12
            }

            TextField {
                id: horizontalResolution
                font.pointSize: 12
                Layout.fillWidth: true
                placeholderText: qsTr("Horizontal Resolution")
                text: Screen.width
                validator: IntValidator {bottom: 0}
            }

            Label {
                text: qsTr("Vertical Resolution")
                font.pointSize: 12
            }

            TextField {
                id: verticalResolution
                font.pointSize: 12
                Layout.fillWidth: true
                placeholderText: qsTr("Vertical Resolution")
                text: Screen.height
                validator: IntValidator {bottom: 0}
            }

            Label {
                text: qsTr("Diagonal Measure")
                font.pointSize: 12
            }

            TextField {
                id: diagonalMeasure
                font.pointSize: 12
                Layout.fillWidth: true
                placeholderText: qsTr("Diagonal Measure")
                text: getDiagonalMeasureFromResolutionAndDensity(Screen.width, Screen.height, Screen.pixelDensity * 25.4)
                validator: DoubleValidator {bottom: 0}
            }
        }

        ColumnLayout {
            id: columnLayout2
            spacing: 16

            Label {
                text: qsTr("Pixel Density:")
                font.pointSize: 12
            }

            RowLayout {
                Label {
                    text: Math.floor(getPixelsPerUnit());
                    font.pointSize: 37
                }

                Label {
                    text: qsTr("pixels per unit")
                    font.pointSize: 12
                }
            }

            Label {
                text: qsTr("Width:")
                font.pointSize: 12
            }

            Label {
                text: (horizontalResolution.text / getPixelsPerUnit())
                font.pointSize: 22
            }

            Label {
                text: qsTr("Height:")
                font.pointSize: 12
            }

            Label {
                text: (verticalResolution.text / getPixelsPerUnit())
                font.pointSize: 22
            }
        }
    }

    function getDiagonalMeasureFromResolutionAndDensity(hres, vres, dpu) {
        return Math.sqrt(Math.pow((hres / dpu), 2) + Math.pow((vres / dpu), 2));
    }

    function getPixelsPerUnit() {
        var height = verticalResolution.text,
            width = horizontalResolution.text,
            diagonal = diagonalMeasure.text,
            result;

        result = Math.sqrt(Math.pow(height, 2) + Math.pow(width, 2)) / diagonal;

        return result;
    }

    function getLayoutDirection() {
        var direction;

        if (mainWindow.height < mainWindow.width) {
            direction = GridLayout.LeftToRight
        } else {
            direction = GridLayout.TopToBottom
        }

        return direction;
    }
}
