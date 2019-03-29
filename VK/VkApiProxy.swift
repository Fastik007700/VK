//
//  VkApiProxy.swift
//  VK
//
//  Created by Михаил on 29/03/2019.
//  Copyright © 2019 Mikhail. All rights reserved.
//

import Foundation


class VkApiProxy: VkApi {
    
    let vkApiService: VKApiService!
    
    init(vkServise: VKApiService) {
        self.vkApiService = vkServise
    }
    
    
    func getFriendList(completion: @escaping () -> Void) {
        vkApiService.getFriendList {
            print("Friends")
            completion()
        }
    }
    
    func getPhoto(currentID: Int, comlection: @escaping ([ItemParams]) -> Void) {
        vkApiService.getPhoto(currentID: currentID) { params in
            print("Photo")
            comlection(params)
        }
    }
    
    func getGroups(comlection: @escaping () -> Void) {
        vkApiService.getGroups {
            print("groups")
            comlection()
        }
    }
    
    func seachGroups(search: String, comlection: @escaping ([GroupsParams]) -> Void) {
        vkApiService.seachGroups(search: search) { (groups) in
            comlection(groups)
        }
    }
    
    func getNews(comlection: @escaping ([News], String?) -> Void) {
        vkApiService.getNews { (news, string) in
            print("news")
            comlection(news, string)
        }
    }
    
    
}
