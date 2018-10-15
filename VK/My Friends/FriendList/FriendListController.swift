//
//  TableViewControllerFriendList.swift
//  VK
//
//  Created by Mikhail on 22.07.2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

var friendForPhotoID = Int()

class FriendListController: UITableViewController {
    
    private var arrayOfImage: [UIImage?]?
    private var arrayOfImageLinks: [String]?
    private var myFriends: [FriendsParams]?
    

    
    private func fillTableData() {
        VKApiService(token: globalToken, id: globalID).getFriendList {
            self.myFriends = DataBase().loadDataFriends()
                self.tableView.reloadData()
        }
    }
    

    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
       fillTableData()
    }
    var txName = String()
    
    override func viewWillAppear(_ animated: Bool) {
        fillTableData()
      
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotoOfFriends" {
            let collectionOfPhotoView = segue.destination as! FriendsPhotoController
            collectionOfPhotoView.friendName = txName
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = myFriends?.count {
            return count
        }
            else {
                return 0
            }
            
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as? CellFriendList {
                if self.myFriends?[indexPath.row].first_name != nil && self.myFriends![indexPath.row].last_name != nil  {
               
                    cell.nameLabel.text = "\(self.myFriends![indexPath.row].first_name) \(self.myFriends![indexPath.row].last_name)"
                    cell.imageDowloadURL = self.myFriends![indexPath.row].photo_100
            }
            else {
                cell.nameLabel.text = "Загрузка..."
                cell.photoImage.image = nil
            }
            
        return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        friendForPhotoID = myFriends![indexPath.row].id
        performSegue(withIdentifier: "showPhotoOfFriends", sender: nil)
    }
    
}
