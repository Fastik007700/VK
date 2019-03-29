//
//  TableViewControllerMyGroups.swift
//  VK
//
//  Created by Mikhail on 22.07.2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import UIKit
import RealmSwift

class MyGroupsController: UITableViewController {
    
   private var myGroups = [GroupStruct]()
    
    private var vkServiceAdapter = VkServiceAdapter()
    
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.global().async {
            self.groupsData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allUrGroupsList != nil {
            return allUrGroupsList!.count
        }
        else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "myGroups", for: indexPath) as? CellForGroups {
            
            cell.groupNameLabel.text = myGroups[indexPath.row].name
            cell.avatarURL = myGroups[indexPath.row].photo_100
            cell.subsOfGroupLabel.text = "Кол-во подписчиков: \(myGroups[indexPath.row].member_count)"
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myGroups.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    private func groupsData() {
        
        vkServiceAdapter.getGroups(complection: { array in
            self.myGroups = array
            self.tableView.reloadData()
        })
    }
}
