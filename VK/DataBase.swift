//
//  RealmDB.swift
//  VK
//
//  Created by Mikhail on 06.08.2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import Foundation
import RealmSwift


class DataBase {
    
    private let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    public func saveVKDataFriends(_ friends: [FriendsParams]) {
        do {
            let realm = try? Realm(configuration: config)
            let oldFriends = realm?.objects(FriendsParams.self)
            realm?.beginWrite()
            if oldFriends != nil {
                realm?.delete(oldFriends!)
            }
            realm?.add(friends)
            try realm?.commitWrite()
        }
        catch {
            print("\(error)")
        }
    }
    
    public func saveVKDataGroups (_ groups: [GroupsParams]) {
        do  {
            let realm = try? Realm(configuration: config)
            let oldGroups = realm?.objects(GroupsParams.self)
            realm?.beginWrite()
            if oldGroups != nil  {
                realm?.delete(oldGroups!)
            }
            realm?.add(groups)
            try realm?.commitWrite()
        }
        catch {
            print("\(error)")
        }
    }
    
    
    public func loadDataGroups() -> [GroupsParams] {
        var returnGroups = [GroupsParams]()
        do {
            let realm = try? Realm()
            print(realm?.configuration.fileURL)
            if let groups = realm?.objects(GroupsParams.self) {
                returnGroups = Array(groups)
            }
            return returnGroups
        }
        catch {
            print(error)
            return []
        }
    }
    
    
    public func loadDataFriends() -> [FriendsParams] {
        var returnFriends = [FriendsParams]()
        do {
            let realm = try? Realm()
            print(realm?.configuration.fileURL)
            if let friends = realm?.objects(FriendsParams.self) {
                returnFriends = Array(friends)
            }
            return returnFriends
        }
        catch {
            print(error)
            return []
        }
    }
}
