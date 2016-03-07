//
//  UpdateViewController.swift
//  3NGAGE
//
//  Created by Blue Silver on 3/7/16.
//  Copyright © 2016 Blue Silver. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {

    @IBAction func menuBtnClk(sender: UIButton) {
        SlideNavigationController.sharedInstance().toggleRightMenu()
    }
    
    @IBAction func saveBtnClk(sender: UIButton) {
        SlideNavigationController.sharedInstance().popViewControllerAnimated(true)
    }
}
