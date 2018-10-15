//
//  jsonClassGroups.swift
//  VK
//
//  Created by Mikhail on 30.07.2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import Foundation
import RealmSwift



class GroupsJson: Object {
    var count = 0
    var groups: [GroupsParams]?
    
    convenience init(json: [String:Any]) {
        self.init()
        self.count = json["count"] as! Int
        if let items = json["items"] as? [[String:Any]] {
            self.groups = items.compactMap{GroupsParams(json: $0)}
        }
    }
}

class GroupsParams: Object {
    @objc dynamic var id = 0
    @objc dynamic var is_admin = 0
    @objc dynamic var is_closed = 0
    @objc dynamic var is_member = 0
    @objc dynamic var name = ""
    @objc dynamic var photo_100 = ""
    @objc dynamic var photo_200 = ""
    @objc dynamic var photo_50 = ""
    @objc dynamic var screen_name = ""
    @objc dynamic var type = ""
    @objc dynamic var members_count = 0
    
    convenience init(json: [String:Any]) {
        self.init()
        
        self.id = json["id"] as? Int ?? 0
        self.is_admin = json["is_admin"] as? Int ?? 0
        self.is_closed = json["is_closed"] as? Int ?? 0
        self.is_member = json["is_member"] as? Int ?? 0
        self.name = json["name"] as? String ?? "error"
        self.photo_100 = json["photo_100"] as? String ?? "error"
        self.photo_200 = json["photo_200"] as? String ?? "error"
        self.photo_50 = json["photo_50"] as? String ?? "error"
        self.screen_name = json["screen_name"]  as? String ?? "error"
        self.type = json["type"]  as? String ?? "error"
        if json["members_count"] != nil {
        self.members_count = json["members_count"] as? Int ?? 0
        }
    }
    
}
