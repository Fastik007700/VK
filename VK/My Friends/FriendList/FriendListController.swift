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
    private var vkServiceAdapter = VkServiceAdapter()
    
    private var friendsFactory = FriendViewModelFactory()
    private var viewModels: [FriendsViewModel] = []
    
    
    
    private func fillTableData() {
        vkServiceAdapter.getFriendListAdapter(complection: { array in
            self.viewModels = self.friendsFactory.constructViewModel(friends: array)
            DispatchQueue.main.async {
                 self.tableView.reloadData()
            }
        })
        
    }
    
    
    private func setupUI() {
        self.navigationController?.navigationBar.barTintColor =  .vkColor
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        fillTableData()
    }
    var txName = String()
    
    override func viewWillAppear(_ animated: Bool) {
        fillTableData()
        
    }
    
    override func viewDidLoad() {
        self.setupUI()
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
        
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as? CellFriendList {
            cell.configure(with: viewModels[indexPath.row])
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        friendForPhotoID = viewModels[indexPath.row].id
        performSegue(withIdentifier: "showPhotoOfFriends", sender: nil)
    }
    
}
