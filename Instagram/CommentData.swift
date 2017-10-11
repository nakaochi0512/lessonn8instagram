//
//  CommentData.swift
//  Instagram
//
//  Created by 米住直親 on 2017/10/11.
//  Copyright © 2017年 naochika.yonezumi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CommentData: NSObject{
    var id: String?
    var comment: String?
    var name: String?
    
    
    init(snapshot: FIRDataSnapshot, myId: String) {
        self.id = snapshot.key
        
        let valueDictionary = snapshot.value as! [String: AnyObject]
        
        comment = valueDictionary["commentuser"] as? String
                self.name = valueDictionary["name"] as? String
        
        
}
}


