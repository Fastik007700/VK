//
//  TableViewCellForGroups.swift
//  VK
//
//  Created by Mikhail on 22.07.2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import UIKit
import Kingfisher

class CellForGroups: UITableViewCell {
    
    @IBOutlet weak var imageForGroup: UIImageView! {
        didSet {
            self.imageForGroup.layer.cornerRadius = self.imageForGroup.frame.height/2
        }
    }
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var subsOfGroupLabel: UILabel!
    
    var avatarURL = "" {
        didSet{
            if let url = URL(string: avatarURL) {
                imageForGroup.kf.setImage(with: url)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageForGroup.image = nil
        imageForGroup.kf.cancelDownloadTask()
    }
}
