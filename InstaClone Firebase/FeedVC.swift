//
//  FirstViewController.swift
//  InstaClone Firebase
//
//  Created by Maverick on 2/10/20.
//  Copyright © 2020 Maverick. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import SDWebImage

class FeedVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var UsernameArray = [String]()
    var postedImageURLArray = [String]()
    var PostedCommentArray = [String]()
    var UUIDS = [String]()
    var Likes : Double = 0
    var UUIDS2 : String = ""
    var postID = [String] ()
    var UsersUID = [String] ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        getInfo()
    }
    
    @objc func getInfo(){
        
        
        Database.database().reference().child("users").observe(DataEventType.childAdded) { (Snapshot) in
            
            //user key
            let values = Snapshot.value as! NSDictionary
            
            //to enter posts Folder
            let posts = values["posts"] as! NSDictionary
           
            //post key
            let postsIDs = posts.allKeys
            
            
            //the posts Inside Informations
            for ID in postsIDs {
                
                self.postID.append(ID as! String)
                
                
                let postt = posts[ID] as! NSDictionary
                
                self.UsernameArray.append(postt["postBy"] as! String)
                self.postedImageURLArray.append(postt["image"] as! String)
                self.PostedCommentArray.append(postt["PostCaption"] as! String)
                self.UUIDS.append(postt["UID"] as! String)
                self.UsersUID.append(postt["UserUID"] as! String)
                
                //self.postID.append(postt["])
                
                
                print(postt)
            }
            self.tableView.reloadData()
            
            
           
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UsernameArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCell
        
        Cell.Caption.text = PostedCommentArray[indexPath.row]
        Cell.UserNameLbl.text = UsernameArray[indexPath.row]
        Cell.UUIDS = UUIDS[indexPath.row]
        //self.UUIDS2 = UUIDS[indexPath.row]
        Cell.postIDDD = postID[indexPath.row]
        Cell.userUID = UsersUID[indexPath.row]
        
        
        print ("Posted URL : \(self.postedImageURLArray)")
        Cell.postedImageView.sd_setImage(with: URL(string: self.postedImageURLArray[indexPath.row]))
       // Cell.postedImageView.sd_setImage(with: URL(self.postedImageURLArray[indexPath.row]), placeholderImage: UIImage(named: "123.png"))

        
        
        return Cell
    }
  
            

    @IBAction func Logout(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "user")
        UserDefaults.standard.synchronize()
        
        let SignIn = storyboard?.instantiateViewController(withIdentifier: "SignIn") as! SignInVC
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = SignIn
        
        delegate.rememberLogin()
    }


}
