/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/


import QtQuick          2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts  1.2

import QGroundControl                       1.0
import QGroundControl.Controls              1.0
import QGroundControl.MultiVehicleManager   1.0
import QGroundControl.ScreenTools           1.0
import QGroundControl.Palette               1.0

//-------------------------------------------------------------------------
//-- Message Indicator
Item {
    width:          message.height
    anchors.top:    parent.top
    anchors.bottom: parent.bottom

    property bool showIndicator: true

    property bool _isMessageImportant:    activeVehicle ? !activeVehicle.messageTypeNormal && !activeVehicle.messageTypeNone : false

    function getMessageColor() {
        if (activeVehicle) {
            if (activeVehicle.messageTypeNone)
                return qgcPal.colorGrey
            if (activeVehicle.messageTypeNormal)
                return qgcPal.colorBlue;
            if (activeVehicle.messageTypeWarning)
                return qgcPal.colorOrange;
            if (activeVehicle.messageTypeError)
                return qgcPal.colorRed;
            // Cannot be so make make it obnoxious to show error
            console.log("Invalid vehicle message type")
            return "purple";
        }
        //-- It can only get here when closing (vehicle gone while window active)
        return qgcPal.colorGrey
    }

    Row {
        id:             message
        anchors.top:    parent.top
        anchors.bottom: parent.bottom
        anchors.left:     parent.left
        spacing:        ScreenTools.defaultFontPixelWidth * 0.25

            Image {
                id:                 criticalMessageIcon
                //anchors.fill:       parent
                source:             "/qmlimages/Yield.svg"
                width:              height*0.7
                anchors.top:        parent.top
                anchors.bottom:     parent.bottom
                sourceSize.height:  height*0.7

                fillMode:           Image.PreserveAspectFit
                cache:              false
                visible:            activeVehicle && activeVehicle.messageCount > 0 && _isMessageImportant
            }

            QGCColoredImage {
                //anchors.fill:       parent
                source:             "/qmlimages/Megaphone.svg"
                width:              height*0.5
                anchors.top:        parent.top
                anchors.bottom:     parent.bottom
                sourceSize.height:  height*0.5

                fillMode:           Image.PreserveAspectFit
                color:              getMessageColor()
                visible:            !criticalMessageIcon.visible
            }


        }

//    Image {
//        id:                 criticalMessageIcon
//        anchors.fill:       parent
//        source:             "/qmlimages/Yield.svg"
//        width:              height*0.5
//        sourceSize.height:  height*0.5
//        fillMode:           Image.PreserveAspectFit
//        cache:              false
//        visible:            activeVehicle && activeVehicle.messageCount > 0 && _isMessageImportant
//    }

//    QGCColoredImage {
//        anchors.fill:       parent
//        source:             "/qmlimages/Megaphone.svg"
//        sourceSize.height:  height*0.5
//        width:              height*0.5
//        fillMode:           Image.PreserveAspectFit
//        color:              getMessageColor()
//        visible:            !criticalMessageIcon.visible
//    }

    MouseArea {
        anchors.fill:   parent
        onClicked:      mainWindow.showVehicleMessages()
    }
}
