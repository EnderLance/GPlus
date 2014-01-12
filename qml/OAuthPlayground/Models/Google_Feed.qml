import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
Page {
    id: personPage
    width: parent.width
    height: parent.height
    property string url
    ListView{
        model: feedModel
        width: parent.width
        height:parent.height
        delegate:ListItem.Standard {
            text: feedModel.attributes.itemTitle
        }
    }

    BaseModel {
        id: feedModel
        source: url
        property variant attributes: {
            'kind': '',
            'title':'',
            'items':'',
            'id':'',
            'itemTitle':''
        }
        function updateJSONModel() {
            var ob = JSON.parse(json)
            attributes = {
                'kind': ob.kind,
                'title': ob.title,
                'items': ob.items,
                'id' :ob.items.id,
                'itemTitle': ob.items.title
            };
            updated()
        }
    }
}
