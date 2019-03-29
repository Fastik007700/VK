//
//  CollectionViewControllerFriendsPhoto.swift
//  VK
//
//  Created by Mikhail on 22.07.2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import UIKit



class FriendsPhotoController: UICollectionViewController {
    
    private let reuseIdentifier = "imageCell"
    
    private var friendID = Int()
    private var imageURLs = [ItemParams]()
    private var friendName = String()
    private let vkService = VKApiService(token: globalToken, id: globalID)
    private lazy var vkServiceProxy = VkApiProxy(vkServise: vkService)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendID = friendForPhotoID
        getphotoURLS()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(friendID)
        print(imageURLs)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CellFriendsPhoto {
            cell.photoURL = (imageURLs[indexPath.row].sizes![0].url)
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    
    private func getphotoURLS() {
        vkServiceProxy.getPhoto(currentID: friendID) { (photos) in
            self.imageURLs = photos
            self.collectionView?.reloadData()
            
        }
    }
    
}
