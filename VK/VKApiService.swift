//
//  getVKListsClass.swift
//  VK
//
//  Created by Mikhail on 30.07.2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

var allUrFriendsList: [FriendsParams]?
var allUrGroupsList: [GroupsParams]?

class VKApiService {
    
    private let baseUrl = URL(string: "https://api.vk.com/method/")
    private let baseUrl1 =  "https://api.vk.com/method/"
    private var token: String?
    private var id: String?
    private let apiVersion = "5.80"
    public var friendsCount: Int?
    
    
    public func getFriendList(completion: @escaping()->Void) {
        
        let parameters: Parameters = [
            "user_id":id!,
            "access_token":token!,
            "v":apiVersion,
            "fields":"photo_100"
        ]
        let methodName = "friends.get"
        Alamofire.request((baseUrl?.appendingPathComponent(methodName))!, method: .get, parameters: parameters).responseData(queue: DispatchQueue.global()) { (response) in
            guard let data = response.value else {return}
            let json = try? JSON(data:data)
            self.friendsCount = json?["response"]["count"].int
            allUrFriendsList = json!["response"]["items"].compactMap{FriendsParams(json:$0.1)}
            DispatchQueue.main.async {
                DataBase().saveVKDataFriends(allUrFriendsList!)
                completion()
            }
        }
        
    }
    
    public func getPhoto(currentID:Int, comlection: @escaping([ItemParams])->Void) {
        let parameters: Parameters = [
            "owner_id":currentID,
            "access_token":token!,
            "v":apiVersion,
            ]
        let methodName = "photos.getAll"
        Alamofire.request((baseUrl?.appendingPathComponent(methodName))!, method: .get, parameters: parameters).responseData(queue: DispatchQueue.global()) { (response) in
            guard let data = response.value else {return}
            let json = try? JSON(data:data)
            let m = json!["response"]["items"].compactMap{ItemParams(json: $0.1)}
            DispatchQueue.main.async {
                comlection(m)
            }
        }
    }
    
    
    public func getGroups(comlection: @escaping () -> Void) {
        
        var url = URLComponents(string: "https://api.vk.com/method/groups.get")!
        
        url.queryItems = [
            URLQueryItem (name: "user_id" , value: id ),
            URLQueryItem (name: "access_token" , value: token ),
            URLQueryItem (name: "v" , value: apiVersion ),
            URLQueryItem (name: "extended" , value: "1" ),
            URLQueryItem (name: "fields" , value: "members_count" )
        ]
        DispatchQueue.global().async {
            let session = URLSession.shared
            let task = session.dataTask(with: url.url!) { (data, responce, error) in
                DispatchQueue.main.async {
                    guard let data = data,
                        let json = try? JSONSerialization.jsonObject(with:data, options: JSONSerialization.ReadingOptions.mutableContainers) else {
                            return
                    }
                    if let dictionary = json as? [String:Any],
                        let response = dictionary["response"] as? [String:Any]
                    {
                        let m = GroupsJson(json:response)
                        allUrGroupsList = m.groups
                        
                    }
                    
                    DispatchQueue.main.async {
                        DataBase().saveVKDataGroups(allUrGroupsList!)
                        comlection()
                    }
                }
            }
            task.resume()
        }

    }
    
    
    public func seachGroups(search: String, comlection: @escaping ([GroupsParams])-> Void) {
        
        let parameters: Parameters = [
            "q":search,
            "user_id":id!,
            "access_token":token!,
            "v":apiVersion
        ]
        let methodName = "groups.search"
        Alamofire.request((baseUrl?.appendingPathComponent(methodName))!, method: .get, parameters: parameters).responseData(queue: DispatchQueue.global()) { (response) in
            guard let data = response.value,
                let json = try? JSON(data: data) else {return}
            let m = json["response"].dictionaryObject
            let l = GroupsJson(json: m!)
            DispatchQueue.main.async {
                comlection(l.groups!)
            }
        }
    }
    
    public func getNews(comlection: @escaping ([News], String?) -> Void) {
        
        let params: Parameters = [
            "filters": "post, photo",
            "source_ids": "groups, pages",
            "count": "30",
            "user_id": self.id!,
            "access_token": self.token!,
            "v": self.apiVersion,
            ]
        
        let method = "newsfeed.get"
        
        Alamofire.request((self.baseUrl?.appendingPathComponent(method))!, method: .get, parameters:  params).responseJSON(queue: DispatchQueue.global()) {
            (response) in
            let data = response.value
            var dictionary = data as? [String:Any]
            print(response)
            let responce = dictionary!["response"] as? [String:Any]
            let items = responce!["items"] as? [[String:Any]]
            let profiles = responce!["profiles"] as? [[String:Any]]
            let groups = responce!["groups"] as? [[String:Any]]
            let news = items?.compactMap{News(json: $0, profiles: profiles!, groups: groups!)}
            
            DispatchQueue.main.async {
                comlection(news!, responce!["next_offset"] as? String)
            }
        }
    }
    
    init(token:String, id:String) {
        self.token = token
        self.id = id
    }
}
