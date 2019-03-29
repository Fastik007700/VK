//
//  TableViewCellFriendList.swift
//  VK
//
//  Created by Mikhail on 22.07.2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import UIKit

class CellFriendList: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView! {
        didSet {
            self.photoImage.layer.cornerRadius = self.photoImage.frame.height / 2
        }
    }
    var imageDowloadURL: String = "" {
        didSet {
            let url = URL(string: imageDowloadURL)
            photoImage.kf.setImage(with: url)
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImage.kf.cancelDownloadTask()
        photoImage.image = nil
    }
    
    
    func configure(with viewModel: FriendsViewModel) {
        
        self.nameLabel.text = viewModel.firstName + " " + viewModel.lastName
        let url = URL(string: viewModel.avatarURL)
        photoImage.kf.setImage(with: url)
    }
}
