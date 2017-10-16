//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 米住直親 on 2017/08/01.
//  Copyright © 2017年 naochika.yonezumi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentnameLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
   
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setPostData(postData: PostData) {
        self.postImageView.image = postData.image
        
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale!
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString:String = formatter.string(from: postData.date! as Date)
        self.dateLabel.text = dateString
        
        
        if (postData.comment != nil) && (postData.commentname != nil) {
        self.commentLabel.text = "\(postData.comment!)"
        self.commentnameLabel.text = "\(postData.commentname!)"
        }
        
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: UIControlState.normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: UIControlState.normal)
        }
    }
    

    
}


