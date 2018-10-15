//
//  Photos.swift
//  VK
//
//  Created by Mikhail on 02.08.2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift


class photoJson: Object {
     var count = 0
     var items: ItemParams?
    
   convenience init(json: JSON) {
    self.init()
        self.count = json["count"].intValue
        self.items = ItemParams(json: json["items"])
    }
}
    
class ItemParams: Object {
         var id = 0
        var album_id = 0
        var owner_id = 0
       var text  = ""
        var sizes: [sizeParams]?
        var likes = 0
         var url = ""
        
       convenience init(json: JSON) {
        self.init()
            self.id = json["id"].intValue
            self.album_id = json["album_id"].intValue
            self.owner_id = json["owner_id"].intValue
            self.sizes = json["sizes"].arrayValue.compactMap({sizeParams(json: $0)})
            self.text = json["text"].stringValue
        }
}

class sizeParams: Object  {
   @objc dynamic var url = ""
   @objc dynamic var width = 0
   @objc dynamic var height = 0
   @objc dynamic var  type = ""
    
   convenience init(json: JSON) {
    self.init()
        self.url = json["url"].stringValue
        self.height = json["height"].intValue
        self.width = json["width"].intValue
        self.type = json["type"].stringValue
    }
}
