//
//  FeedCell.swift
//  InstaClone Firebase
//
//  Created by Maverick on 2/18/20.
//  Copyright © 2020 Maverick. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase



class FeedCell: UITableViewCell {

    @IBOutlet weak var UserNameLbl: UILabel!
    @IBOutlet weak var Caption: UILabel!
    @IBOutlet weak var postedImageView: UIImageView!
    
    var UUIDS = ""
    var postIDDD = ""
    var Likes : Double = 0
    var userUID = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func Like(_ sender: Any) {
        
        //print((Auth.auth().currentUser?.email)!)
        Database.database().reference().child("users").observe(DataEventType.childAdded) { (Snapshot) in
            
            //user key
            let values = Snapshot.value as! NSDictionary
            //to enter posts Folder
            let posts = values["posts"] as! NSDictionary
            //post key
            
            let postsIDs = posts.allKeys
            //the posts Inside Informations
            
            for ID in postsIDs {
                
                let ID2 : String = ID as! String
                if ID2 == self.postIDDD{
                    
                
                print("ISSSSDDDDD : \(ID) ")
                print(self.UUIDS)
                print("posttIDS : \(self.postIDDD)")
                
                
                let postt = posts[ID] as! NSDictionary
                
                
                if let like = postt["Likes"] as? Double {
                    self.Likes = like + 1
                    
                   // let A = (Auth.auth().currentUser?.email)!
                   // let B = Database.database().reference().child("users").child((Auth.auth().currentUser?.email)!)
                    //(Auth.auth().currentUser?.uid)!
                   //(Auth.auth().currentUser?.uid)!
                    Database.database().reference().child("users").child(self.userUID).child("posts").child(ID as! String).child("Likes").setValue(self.Likes)
                    }
                
                }
            }
            
            
            
        }
    }
    
   
}


