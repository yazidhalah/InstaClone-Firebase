//
//  SecondViewController.swift
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

class UploadVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postComment: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postImage.isUserInteractionEnabled = true
        let reco = UITapGestureRecognizer(target: self, action: #selector (UploadVC.ImagePicker))
        postImage.addGestureRecognizer(reco)
        
    }
    @IBAction func postBtnClicked(_ sender: Any) {
        
        let mediaFolder = Storage.storage().reference().child("media")
        
        if let data = postImage.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = NSUUID().uuidString
            mediaFolder.child("\(uuid).jpg").putData(data, metadata: nil) { (metaData, error) in
                
                if error != nil{
                    
                    let alert = UIAlertController(title: "error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let dissmiss = UIAlertAction(title: "dismiss", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(dissmiss)
                    self.present(alert, animated: true, completion: nil)
                }else{
                    
                    //let ref = storageRef.child("media")
                    let Ref = mediaFolder.child("\(uuid).jpg")
                        Ref.downloadURL(completion: { (url, error) in
                        if error != nil {
                            let alert = UIAlertController(title: "error12", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                            let dissmiss = UIAlertAction(title: "dismiss", style: UIAlertAction.Style.cancel, handler: nil)
                            alert.addAction(dissmiss)
                            self.present(alert, animated: true, completion: nil)
                        }else{
                           let downloadURL = url!.absoluteString
                            
                            let post = ["image" : downloadURL, "postBy" : (Auth.auth().currentUser?.email)!,"UserUID" : (Auth.auth().currentUser?.uid)! , "UID" : uuid, "PostCaption" : self.postComment.text , "Likes" : 0 ] as [String : Any]
                            
                            Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("posts").childByAutoId().setValue(post)
                            
                            self.postComment.text = ""
                            self.postImage.image = UIImage(named: "123.png")
                            self.tabBarController?.selectedIndex = 0
                        }
                    })
                    
                    
                }
            }
            
            
        }
        
    }
    
    @objc func ImagePicker(){
    
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        postImage.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    

}

