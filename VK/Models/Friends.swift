//
//  jsonClassFriends.swift
//  VK
//
//  Created by Mikhail on 30.07.2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class FriendsJson: Object {
    var count = 0
    var friends: FriendsParams?
    
    convenience init(json:JSON) {
        self.init()
        self.count = json["count"].intValue
        self.friends = FriendsParams(json: json["items"])
    }
}

class FriendsParams: Object {
       @objc dynamic var id = 0
       @objc dynamic var first_name = ""
       @objc dynamic var last_name = ""
       @objc dynamic var photo_100 = ""
       @objc dynamic var online = 0
        
       convenience init(json: JSON) {
        self.init()
            self.id = json["id"].intValue
            self.first_name = json["first_name"].stringValue
            self.last_name = json["last_name"].stringValue
            self.photo_100 = json["photo_100"].stringValue
            self.online = json["online"].intValue
        }

}

