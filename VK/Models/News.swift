//
//  News.swift
//  VK
//
//  Created by Mikhail on 20.08.2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import Foundation
//
class NewsJson {

    var items: [String: Any]?
    var profiles: [FriendsParams]?
    var groups: [GroupsParams]?
    var next_offset: String?
    var next_from : String?

    init(json: [String:Any]) {
        self.items = json["items"] as?  [String:Any]
        self.profiles = json["profiles"] as? [FriendsParams]
        self.groups = json["groups"] as? [GroupsParams]
        self.next_offset = json["next_offset"] as? String
        self.next_from = json["next_from"] as? String
    }
}


class FriendsForNews {
    var id = 0
    var first_name = ""
    var last_name = ""
    var photo_100 = ""
    var online = 0
    
    init(json: [String:Any]) {
        self.id = json["id"] as! Int
        self.first_name = json["first_name"] as! String
        self.last_name = json["last_name"] as! String
        self.photo_100 = json["photo_100"] as! String
        self.online = json["online"] as! Int
    }
}

class GroupsForNews {
    var id = 0
    var name = ""
    var photo_100 = ""
    
    init(json: [String:Any]) {
        self.id = json["id"] as! Int
        self.photo_100 = json["photo_100"] as! String
        self.name = json["name"] as! String
    }
}

class CommentsNews {
    var count: Int?
    init(json: [String:Any]) {
        self.count = json["count"] as? Int
    }
}

class LikesNews {
    var count: Int?
    init(json: [String:Any]) {
        self.count = json["count"] as? Int
    }
}
class RepostsNews {
    var count: Int?
    init(json: [String:Any]) {
        self.count = json["count"] as? Int
    }
}

class ViewsNews {
    var count: Int?
    init(json: [String:Any]) {
        self.count = json["count"] as? Int
}
    
}

class PhotoNews {
    var src: String?
    init(json: [String:Any]) {
        self.src = json["url"] as? String
    }
}

class News {
    
    var type: String?
    var date: Int?
    var text: String?
    var source_id: Int?
    var comments: CommentsNews?
    var likes: LikesNews?
    var reposts: RepostsNews?
    var views: ViewsNews?
    var photo: PhotoNews?
    var name: String?
    var avatarURL: String?
    
    init(json: [String:Any], profiles: [[String:Any]], groups: [[String:Any]]) {
        self.type = json["type"] as? String
        self.date = json["date"] as? Int
        self.text = json["text"] as? String ?? ""
        self.source_id = json["source_id"] as? Int
        
        if let commectJson = json["comments"] as? [String: Any] {
            self.comments = CommentsNews(json: commectJson)
        }
        if let likesJson = json["likes"] as? [String: Any] {
            self.likes = LikesNews(json: likesJson)
        }
        if let repostsJson = json["reposts"] as? [String: Any] {
            self.reposts = RepostsNews(json: repostsJson)
        }
        if let photoJson = json["photos"] as? [String: Any] {
            self.photo = PhotoNews(json: photoJson)
        }
        if let viewsJson = json["views"] as? [String: Any] {
            self.views = ViewsNews(json: viewsJson)
        }
        if self.source_id! > 0 {
            let m = profiles.compactMap{FriendsForNews(json: $0)}
            let friend = m.filter{$0.id == source_id}
            self.name = friend[0].first_name + " " + friend[0].last_name
            self.avatarURL = friend[0].photo_100
        }
        else {
            let m = groups.compactMap{GroupsForNews(json: $0)}
            let group = m.filter{$0.id == abs(source_id!)}
            self.name = group[0].name
            self.avatarURL = group[0].photo_100
        }
    }
}



