import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
Page {
    id: personPage
    width: parent.width
    height: parent.height
    property string url
    ListView{
        model: personModel
        width: parent.width
        height:parent.height
        delegate:Item{
            width: personPage.width
            height:personPage.height
            /*Image {
                id: backgroundImage
                width:  parent.width
                height:  units.gu(20)
                source:personModel.attributes.coverPhoto
            }
            */
            UbuntuShape{
                id: icon
                width: parent.width / 2
                height:  width
                anchors{
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    topMargin: units.gu(3)
                }
                image:Image {
                    sourceSize.height: icon.height
                    sourceSize.width: icon.width
                    source: personModel.attributes.iconImage
                    smooth: true
                }
            }
            Rectangle{
                id: infoRec
                width:parent.width / 1.04
                radius: 10
                height: parent.height/ 3
                color: "#88000000"
                anchors{
                    horizontalCenter: parent.horizontalCenter
                    top: icon.bottom
                    topMargin: units.gu(1)
                }
                Button{
                    text: "Feed"
                    width: parent.width / 2
                    anchors{
                        top:infoRec.bottom
                        horizontalCenter: parent.horizontalCenter
                        topMargin: units.gu(3)

                    }
                    onClicked: {
                        stack.push(gplus_feed)
                        urls.text = "https://www.googleapis.com/plus/v1/people/me/activities/public?maxResults=20?access_token="+oauth2.getaccessToken.toString()
                        gplus_feed.visible = true
                    }
                }
            }
            Column{
                spacing: units.gu(1)
                anchors.centerIn:infoRec
                Label{
                    text: personModel.attributes.displayName
                    fontSize:"large"
                    color:"white"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Label{
                    text:  personModel.attributes.occupation
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Label{
                    text: personModel.attributes.tagline
                    fontSize: "small"
                    wrapMode: Text.WordWrap
                }
            }

        }
    }
    BaseModel {
        id: personModel
        source: url
        property variant attributes: {
            'displayName': '',
            'coverPhoto':'',
            'iconImage':'',
            'occupation':'',
            'tagline':''
        }
        function updateJSONModel() {
            var ob = JSON.parse(json)
            attributes = {
                'coverPhoto': ob.cover.coverPhoto.url,
                'displayName': ob.displayName,
                'iconImage' :ob.image.url,
                'occupation':ob.occupation,
                'tagline':ob.tagline
            };
            updated()
        }
    }
}
