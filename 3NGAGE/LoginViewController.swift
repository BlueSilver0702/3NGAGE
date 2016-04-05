//
//  LoginViewController.swift
//  3NGAGE
//
//  Created by Blue Silver on 3/7/16.
//  Copyright © 2016 Blue Silver. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var inc:Int = 2
    
    @IBOutlet weak var bgView: UIImageView!
    
    @IBOutlet weak var unameTxtView: UITextField!
    @IBOutlet weak var pwdTxtView: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        unameTxtView.attributedPlaceholder = NSAttributedString(string:"USER NAME",
            attributes:[NSForegroundColorAttributeName: UIColor.blackColor()])
        pwdTxtView.attributedPlaceholder = NSAttributedString(string:"PASSWORD",
            attributes:[NSForegroundColorAttributeName: UIColor.blackColor()])
        
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "setBack", userInfo: nil, repeats: true)
    }
    
    func setBack() {
        let imgs:[String] = ["bg1.png", "bg2.png", "bg3.png", "bg4.png", "bg5.png", "bg6.png"]
        
        UIView.transitionWithView(self.bgView, duration: 1.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            self.bgView.image = UIImage(named: imgs[self.inc])
            }, completion: nil)
        
        inc++;
        if inc==imgs.count {
            inc=0;
        }
    }
    
    @IBAction func loginBtnClk(sender:UIButton) {
        
        if unameTxtView.text == "" {
            alert("Please input username!")
            return
        }
        
        if pwdTxtView.text == "" {
            alert("Please input password!")
            return
        }
        
        let user:QBUUser = QBUUser()
        user.login = unameTxtView.text
        user.password = pwdTxtView.text! + "1234567";
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        SVProgressHUD.showWithStatus("Logging in...")
        QBRequest.logInWithUserLogin(user.login!, password: user.password!, successBlock: { (response:QBResponse, loginUser:QBUUser?) -> Void in
            
            appDelegate.g_var.currentUser.qbUser = loginUser
            
            QBRequest.objectWithClassName("Meta", ID: (loginUser?.twitterDigitsID)!, successBlock: { (response1: QBResponse, obj: QBCOCustomObject?) -> Void in

                appDelegate.g_var.currentUser.mAge = (response1.data?.valueForKey("Age"))! as! String
                appDelegate.g_var.currentUser.mEthnicity = (response1.data?.valueForKey("Ethnicity"))! as! String
                appDelegate.g_var.currentUser.mHeight = (response1.data?.valueForKey("Alias"))! as! String
                appDelegate.g_var.currentUser.mBody = (response1.data?.valueForKey("BodyType"))! as! String
                appDelegate.g_var.currentUser.mBio = (response1.data?.valueForKey("Bio"))! as! String
                appDelegate.g_var.currentUser.mAlias = (response1.data?.valueForKey("Alias"))! as! String
                appDelegate.g_var.currentUser.mLocation = (response1.data?.valueForKey("Location"))! as! String

                SVProgressHUD.dismiss()
                
                let loadView:LoadViewController = appDelegate.mainStoryboard.instantiateViewControllerWithIdentifier("loadCtrl") as! LoadViewController
                loadView.start()
                SlideNavigationController.sharedInstance().pushViewController(loadView, animated: true)

                }, errorBlock: { (err: QBResponse) -> Void in
                    SVProgressHUD.dismiss()
                    self.alert("Retriving Meta Failed!")
            })
            
            }) { (errResponse: QBResponse) -> Void in
                SVProgressHUD.dismiss()
                self.alert("Login Failed!")
        }
    }
    
    @IBAction func backBtnClk(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func alert(txtMSG: String) {
        // create the alert
        let alert = UIAlertController(title: "Alert", message: txtMSG, preferredStyle: UIAlertControllerStyle.Alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
