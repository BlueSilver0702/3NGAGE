//
//  MenuViewController.swift
//  3NGAGE
//
//  Created by Blue Silver on 3/7/16.
//  Copyright © 2016 Blue Silver. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    var appDelegate: AppDelegate!
    
    @IBOutlet weak var fnameTxtView: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    @IBAction func viewProfileBtnClk(sender: UIButton) {
        let resultView:SResultViewController = appDelegate.mainStoryboard.instantiateViewControllerWithIdentifier("resultCtrl") as! SResultViewController
        SlideNavigationController.sharedInstance().pushViewController(resultView, animated: false)
    }
    
    @IBAction func communicationBtnClk(sender: UIButton) {
        SlideNavigationController.sharedInstance().toggleRightMenu()
        //self.alert("Coming Soon!")
    }
    
    @IBAction func interestsBtnClk(sender: UIButton) {
        SlideNavigationController.sharedInstance().toggleRightMenu()
        //self.alert("Coming Soon!")
    }
    
    @IBAction func logoutBtnClk(sender: UIButton) {
        
        SVProgressHUD.showWithStatus("Logging out...")
        
        QBRequest.logOutWithSuccessBlock({ (response: QBResponse) -> Void in
                SVProgressHUD.dismiss()
                SlideNavigationController.sharedInstance().popToRootViewControllerAnimated(true)
            
            }) { (errResponse: QBResponse) -> Void in
                SVProgressHUD.dismiss()
                self.alert("Error during signout")
        }
    }
    
    func updateMenu() {
        self.fnameTxtView.text = appDelegate.g_var.currentUser.fullName
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
