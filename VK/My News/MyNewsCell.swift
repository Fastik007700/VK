//
//  MyNewsCell.swift
//  VK
//
//  Created by Mikhail on 16.08.2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import UIKit
import Kingfisher

class MyNewsCell: UITableViewCell {
    let instentsFromLeftForName: CGFloat = 10.0
    //let instentsFromRight: CGFloat = 36.0
    
    @IBOutlet weak var avatar: UIImageView! {
        didSet {
            avatar.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var name: UILabel!
        {
        didSet {
            name.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var postText: UILabel!
        {
        didSet {
            postText.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var numberOfLikes: UILabel!
        {
        didSet {
            numberOfLikes.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var numberOfReposts: UILabel!
        {
        didSet {
            numberOfReposts.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var numberOfComments: UILabel!
        {
        didSet {
            numberOfComments.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var numberOfViews: UILabel!
        {
        didSet {
            numberOfViews.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var postImage: UIImageView!
        {
        didSet {
            postImage.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBOutlet weak var likeIcon: UIImageView!
        {
        didSet {
            likeIcon.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBOutlet weak var repostIcon: UIImageView!
        {
        didSet {
            repostIcon.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBOutlet weak var commentsIcon: UIImageView!
        {
        didSet {
            commentsIcon.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBOutlet weak var viewsIcon: UIImageView!
        {
        didSet {
            viewsIcon.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    
    
    var avatarURL: String = "" {
        didSet {
            if let url = URL(string:avatarURL ) {
                avatar.kf.setImage(with: url)
            }
        }
    }
    
    var imagePostURL: String = "" {
        
        didSet {
            if let url1 = URL(string:imagePostURL) {
                postImage.kf.setImage(with: url1)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabelFrame()
        avatarFrame()
        postTextFrame()
        postImageFrame()
        likeIconFrame()
        likesTextFrame()
        repostsIconFrame()
        repostsTextFrame()
    }
    
    
    func getLabelSize(text: String, font: UIFont ) -> CGSize {
        let maxSize = bounds.width - instentsFromLeftForName/2
        let textBlock = CGSize(width: maxSize, height: CGFloat.greatestFiniteMagnitude)
        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil) // CGRECT
        let width = Double(rect.size.width)
        let height = Double(rect.size.height)
        let size = CGSize(width: ceil(width), height: ceil(height))
        return size
    }
    
    
    func nameLabelFrame() {
        let nameLabelSize = getLabelSize(text: name.text!, font: name.font)
        let nameLabelX = avatar.frame.maxX + 10
        let nameLabelOrigin = CGPoint(x: nameLabelX, y: 11)
        name.frame = CGRect(origin: nameLabelOrigin, size: nameLabelSize)
    }
    
    func avatarFrame() {
        let avatarSize = CGSize(width: 20.0, height: 20.0)
        let avatarOrigin = CGPoint(x: 15.0, y: 11.0)
        avatar.frame = CGRect(origin: avatarOrigin, size: avatarSize)
    }
    
    func postTextFrame() {
        let postTextSize = getLabelSize(text: postText.text!, font: postText.font)
        let postTextY = avatar.frame.maxY + 10
        let postTextOrigin = CGPoint(x: 3, y: postTextY)
        postText.frame = CGRect(origin: postTextOrigin, size: postTextSize)
    }
    
    func postImageFrame() {
        let postImageSize = CGSize(width: 367, height: 356)
        let postImageOrigin = CGPoint(x: postText.frame.minX, y: postText.frame.minY)
        postImage.frame = CGRect(origin: postImageOrigin, size: postImageSize)
    }
    
    let sizeForIcons = CGSize(width:20.0 , height: 18.0)
    
    func likeIconFrame() {
        let likeIconOrigin = CGPoint(x: 10, y: self.frame.height - 30)
        likeIcon.frame = CGRect(origin: likeIconOrigin, size: sizeForIcons)
    }
    
    func likesTextFrame() {
        let likesTextSize = getLabelSize(text: numberOfLikes.text!, font: numberOfLikes.font)
        let likesTextY = ceil(likeIcon.frame.minY)
        let likesTextX = ceil(likeIcon.frame.maxX + 5)
        let likesTextOrigin  = CGPoint(x: likesTextX, y: likesTextY)
        numberOfLikes.frame = CGRect(origin: likesTextOrigin, size: likesTextSize)
        
    }
    
    func repostsIconFrame() {
        let repostIconOrigin = CGPoint(x: numberOfLikes.frame.maxX + 10, y: likeIcon.frame.origin.y)
        repostIcon.frame = CGRect(origin: repostIconOrigin, size: sizeForIcons)
    }
    
    func repostsTextFrame() {
        let repostsTextSize = getLabelSize(text: numberOfReposts.text!, font: numberOfReposts.font)
        let repostsTextY = ceil(likeIcon.frame.minY)
        let repostsTextX = ceil(repostIcon.frame.maxX + 5)
        let repostsOrigin = CGPoint(x: repostsTextX, y: repostsTextY)
        numberOfReposts.frame = CGRect(origin: repostsOrigin, size: repostsTextSize)
        
    }
    
    func commentsIconFrame() {
        let commentsIconOrigin = CGPoint(x: numberOfReposts.frame.maxX + 10, y: likeIcon.frame.origin.y)
        commentsIcon.frame = CGRect(origin: commentsIconOrigin, size: sizeForIcons)
    }
    
    func commentsTextFrame() {
        let commentsTextSize = getLabelSize(text: numberOfComments.text!, font: numberOfComments.font)
        let commentsTextY = ceil(likeIcon.frame.minY)
        let commentsTextX = ceil(commentsIcon.frame.maxX + 5)
        let commentsOrigin = CGPoint(x: commentsTextX, y: commentsTextY)
        numberOfComments.frame = CGRect(origin: commentsOrigin, size: commentsTextSize)
    }
    
}
