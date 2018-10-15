//
//  MyNewsController.swift
//  VK
//
//  Created by Mikhail on 16.08.2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import UIKit

class MyNewsController: UITableViewController {
    
    var myNews: [News]!
    var beginFrom: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if myNews != nil {
            return (myNews?.count)!
        }
        else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 435
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! MyNewsCell
        if myNews != nil {
        cell.avatarURL = myNews[indexPath.row].avatarURL!
        cell.numberOfLikes.text = String((myNews[indexPath.row].likes?.count)!)
        cell.numberOfComments.text = String((myNews[indexPath.row].comments?.count)!)
        cell.numberOfReposts.text = String((myNews[indexPath.row].reposts?.count)!)
        cell.numberOfViews.text = String((myNews[indexPath.row].views?.count)!)
        cell.name.text = String((myNews[indexPath.row].name)!)
            if myNews[indexPath.row].type == "post" {
                cell.postText.text = myNews[indexPath.row].text
                cell.postImage.isHidden = true
            }
            else if  myNews[indexPath.row].type == "photo" {
                cell.postText.isHidden = true
                cell.imagePostURL = (myNews[indexPath.row].photo?.src)!
                print("ok")
            }
        }
        else {
            return UITableViewCell()
        }
        
        
        return cell
    }
    
    func fillTableView() {
        VKApiService(token: globalToken, id: globalID).getNews() { arrayOfNews, startFrom  in
            self.myNews = arrayOfNews
            self.tableView.reloadData()
        }
    }

}
