//
//  LoginViewController.swift
//  3NGAGE
//
//  Created by Blue Silver on 3/7/16.
//  Copyright © 2016 Blue Silver. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var unameTxtView: UITextField!
    @IBOutlet weak var pwdTxtView: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        unameTxtView.attributedPlaceholder = NSAttributedString(string:"USER NAME",
            attributes:[NSForegroundColorAttributeName: UIColor.blackColor()])
        pwdTxtView.attributedPlaceholder = NSAttributedString(string:"PASSWORD",
            attributes:[NSForegroundColorAttributeName: UIColor.blackColor()])
    }
    
    @IBAction func backBtnClk(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
