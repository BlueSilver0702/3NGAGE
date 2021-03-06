//
//  MenuViewController.swift
//  3NGAGE
//
//  Created by Blue Silver on 3/7/16.
//  Copyright © 2016 Blue Silver. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var fnameLab: UILabel!
    
    var appDelegate: AppDelegate!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
//
        self.updateMenu()
    }
    
    @IBAction func viewProfileBtnClk(sender: UIButton) {
        let resultView:SResultViewController = appDelegate.mainStoryboard.instantiateViewControllerWithIdentifier("resultCtrl") as! SResultViewController
        SlideNavigationController.sharedInstance().pushViewController(resultView, animated: true)
        resultView.initData(appDelegate.g_var.currentUser)
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
        
        SlideNavigationController.sharedInstance().toggleRightMenu()
        
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
        fnameLab.text = appDelegate.g_var.currentUser.qbUser.fullName
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
