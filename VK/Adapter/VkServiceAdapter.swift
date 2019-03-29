//
//  VkServiceAdapter.swift
//  VK
//
//  Created by Михаил on 18/03/2019.
//  Copyright © 2019 Mikhail. All rights reserved.
//

import Alamofire
import RealmSwift


protocol VkServiceAdapterProtocol {
    
    func getFriendListAdapter(complection: @escaping ([FriendStruct]) -> Void)
    
    func getPhoto()
    
    func getGroups(complection: @escaping ([GroupStruct]) -> Void)
    
    func getNews()
}


class VkServiceAdapter: VkServiceAdapterProtocol {
    
    private var dataBase = DataBase()
    private var vkService = VKApiService(token: globalToken, id: globalID)
    private lazy var vkServiceProxy = VkApiProxy(vkServise: vkService)
    
    private func friendsStructureAdapter(realmStruct: [FriendsParams]) -> [FriendStruct] {
        var returnStruct: [FriendStruct] = []
        for i in realmStruct {
            returnStruct.append (FriendStruct(id: i.id, first_name: i.first_name, last_name: i.last_name, photo_100: i.photo_100, online: i.online))
        }
        return returnStruct
    }
    
    private func groupStructureAdapter(realmStruct: [GroupsParams]) -> [GroupStruct] {
        
        var returnStruct: [GroupStruct] = []
        
        for i in  realmStruct {
            returnStruct.append(GroupStruct(id: i.id, is_admin: i.is_admin, is_closed: i.is_closed, is_member: i.is_member, name: i.name, photo_100: i.photo_100, photo_200: i.photo_200, photo_50: i.photo_50, screen_name: i.screen_name, type: i.type, member_count: i.members_count))
        }
        
        return returnStruct
        
    }
    
    func getFriendListAdapter(complection: @escaping ([FriendStruct]) -> Void) {

        vkService.getFriendList {
            complection(self.friendsStructureAdapter(realmStruct: self.dataBase.loadDataFriends()))
        }
    }
    
    func getPhoto() {
        //здесь такой же принцип
    }
    
    func getGroups(complection: @escaping ([GroupStruct]) -> Void) {
        vkService.getGroups {
            complection(self.groupStructureAdapter(realmStruct: self.dataBase.loadDataGroups()))
        }
    }
    
    func getNews() {
        //здесь такой же принцип
    }
    
    
}
