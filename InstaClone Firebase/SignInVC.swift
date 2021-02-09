//
//  SignInVC.swift
//  InstaClone Firebase
//
//  Created by Maverick on 2/10/20.
//  Copyright © 2020 Maverick. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInVC: UIViewController {

    @IBOutlet weak var UsernameTextLbl: UITextField!
    @IBOutlet weak var PasswordTextLbl: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    @IBAction func SignInBtn(_ sender: Any) {
        
        if UsernameTextLbl.text != nil && PasswordTextLbl.text != nil {
            
            Auth.auth().signIn(withEmail: UsernameTextLbl.text!, password: PasswordTextLbl.text!) { (data, error) in
                
                if error != nil {
                    
                    let alert = UIAlertController(title: "error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okBttn = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(okBttn)
                    self.present(alert, animated: true, completion: nil)
                }else{
                    
                    UserDefaults.standard.set(data!.user.email, forKey: "user")
                    UserDefaults.standard.synchronize()
                    
                    
                    //let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    //appdelegate.rememberLogin()
                    
                    self.performSegue(withIdentifier: "ToFeed", sender: nil)
                    
                    
                }
                
            }
            
        }else {
            let alert = UIAlertController(title: "error", message: "error", preferredStyle: UIAlertController.Style.alert)
            let okBttn = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okBttn)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    @IBAction func SignUpBtn(_ sender: Any) {
        
        if UsernameTextLbl.text != nil && PasswordTextLbl.text != nil {
            
            Auth.auth().createUser(withEmail: UsernameTextLbl.text!, password: PasswordTextLbl.text!) { (user, error) in
                
                if error != nil{
                    
                    let alert = UIAlertController(title: "error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okBttn = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(okBttn)
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    
                   self.performSegue(withIdentifier: "ToFeed", sender: nil)
                }
            }
        }else{
            
            let alert = UIAlertController(title: "error", message: "error", preferredStyle: UIAlertController.Style.alert)
            let okBttn = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okBttn)
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
        
       
        
    }
    

}
