

//
//  PostDate.swift
//  Instagram
//
//  Created by 米住直親 on 2017/08/01.
//  Copyright © 2017年 naochika.yonezumi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CommentData: NSObject {
    var id: String?
    var name: String?
    var comment: String?
    
    
    init(snapshot: FIRDataSnapshot, myId: String) {
        self.id = snapshot.key
        let valueDictionary = snapshot.value as! [String: AnyObject]
        self.name = valueDictionary["name"] as? String
        self.comment = valueDictionary["commenttext"] as? String
        
    }
}
