//
//  LoadViewController.swift
//  3NGAGE
//
//  Created by Blue Silver on 3/8/16.
//  Copyright © 2016 Blue Silver. All rights reserved.
//

import UIKit

class LoadViewController: UIViewController {

    var appDelegate: AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func menuBtnClk(sender: UIButton) {
        SlideNavigationController.sharedInstance().toggleRightMenu()
    }
    
    func start() {
        
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let page: QBGeneralResponsePage = QBGeneralResponsePage(currentPage: UInt(appDelegate.g_var.currentPage), perPage: 20)
        
        QBRequest.usersForPage(page, successBlock: { (response: QBResponse, responsePage: QBGeneralResponsePage?, users: [QBUUser]?) -> Void in
            if users!.count > 0 {
                self.appDelegate.g_var.users = []
                for user in users! {
                    let nUser: User = User(user: user)
                    nUser.loadTag()
                    self.appDelegate.g_var.users.append(nUser)
                }
                
                let resultView:SResultViewController = self.appDelegate.mainStoryboard.instantiateViewControllerWithIdentifier("resultCtrl") as! SResultViewController
                SlideNavigationController.sharedInstance().pushViewController(resultView, animated: true)
                resultView.initData(self.appDelegate.g_var.users[0])
            } else {
                SVProgressHUD .showErrorWithStatus("There is no search result!")
            }
            
            }) { (errResponse: QBResponse) -> Void in
                
        }
    }
}
