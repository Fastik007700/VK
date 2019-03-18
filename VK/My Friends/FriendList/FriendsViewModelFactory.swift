//
//  FriendsViewModelFactory.swift
//  VK
//
//  Created by Михаил on 18/03/2019.
//  Copyright © 2019 Mikhail. All rights reserved.
//

import Foundation
import Kingfisher



final class FriendViewModelFactory {
    
    func constructViewModel(friends: [FriendStruct]) -> [FriendsViewModel] {
        return friends.compactMap(self.viewModel)
    }
    
    private func viewModel(model: FriendStruct) -> FriendsViewModel {
        
        
        let firstname = model.first_name
        let lastName = model.last_name
        let online = model.online
        let id = model.id
        let avatarURL = model.photo_100
    
        
        return FriendsViewModel(firstName: firstname, lastName: lastName, avatarURL: avatarURL, online: online, id: id)
    }
}
