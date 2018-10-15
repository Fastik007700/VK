//
//  CollectionViewCellFriendsPhoto.swift
//  VK
//
//  Created by Mikhail on 22.07.2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import UIKit
import Kingfisher

class CellFriendsPhoto: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    var photoURL: String = "" {
        didSet {
            if let url = URL(string: photoURL) {
                image.kf.setImage(with: url)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
        image.kf.cancelDownloadTask()
    }
}
