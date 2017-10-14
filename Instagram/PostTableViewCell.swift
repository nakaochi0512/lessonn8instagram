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
   
    
  
var commentArray: [CommentData] = []
    
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
    
        
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: UIControlState.normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: UIControlState.normal)
        }
    }
    

    
    @IBAction func CommentButtom(_ sender: Any) {
        
        let name = FIRAuth.auth()?.currentUser?.displayName
        let postRef = FIRDatabase.database().reference().child(Const.commentPath)
        
        let postData = ["commenttext": commentField.text!,"name": name!]
        postRef.childByAutoId().setValue(postData)
        
        
        postRef.observe(.childAdded, with: { snapshot in
            print("DEBUG_PRINT: .childAddedイベントが発生しました。")
            // PostDataクラスを生成して受け取ったデータを設定する
           
            
            
            if let uid = FIRAuth.auth()?.currentUser?.uid {
                
                 let commentdata = CommentData(snapshot: snapshot, myId: uid)
                self.commentArray.insert(commentdata, at: 0)
                 
                 // 保持している配列からidが同じものを探す
                 var index: Int = 0
                 for post in self.commentArray {
                 if post.id == commentdata.id {
                 index = self.commentArray.index(of: post)!
                 break
                 }
                 }
      
                // 差し替えるため一度削除する
                self.commentArray.remove(at: index)
                
                // 削除したところに更新済みのデータを追加する
                self.commentArray.insert(commentdata, at: index)
                print(self.commentArray)
                

            }
        })
    }
}

    

