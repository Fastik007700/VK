//
//  TableViewControllerCommonGroups.swift
//  VK
//
//  Created by Mikhail on 22.07.2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import UIKit

class CommonGroupsController: UITableViewController, UISearchBarDelegate {
    
    var allGroups = [GroupsParams]()
    var seachingGroups = [GroupsParams]()
    
    @IBOutlet weak var seachBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seachBar.delegate = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return seachingGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "allGroups", for: indexPath) as? CellForGroups {
            cell.groupNameLabel.text = seachingGroups[indexPath.row].name
            cell.avatarURL = seachingGroups[indexPath.row].photo_200
            cell.subsOfGroupLabel.text = ""
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("OK")
        if seachBar.text != nil {
            VKApiService(token: globalToken, id: globalID).seachGroups(search: seachBar.text!) { (groups) in
                self.seachingGroups = groups
                self.tableView.reloadData()
            }
            self.seachBar.endEditing(true)
        }
    }
}
