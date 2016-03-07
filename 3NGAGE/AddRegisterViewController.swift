//
//  AddRegisterViewController.swift
//  3NGAGE
//
//  Created by Blue Silver on 3/7/16.
//  Copyright © 2016 Blue Silver. All rights reserved.
//

import UIKit

class AddRegisterViewController: UIViewController {

    @IBOutlet weak var fnameTxtView: UITextField!
    @IBOutlet weak var aliasTxtView: UITextField!
    @IBOutlet weak var emailTxtView: UITextField!
    @IBOutlet weak var locationTxtView: UITextField!
    
    @IBOutlet weak var dobTxtView: UITextField!
    @IBOutlet weak var ageTxtView: UITextField!
    @IBOutlet weak var ethnicityTxtView: UITextField!
    @IBOutlet weak var heightTxtView: UITextField!
    @IBOutlet weak var bodyTxtView: UITextField!
    @IBOutlet weak var bioTxtView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fnameTxtView.attributedPlaceholder = NSAttributedString(string:"Birthday",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 50/255.0, green: 80/255.0, blue: 50/255.0, alpha: 1.0)])
        aliasTxtView.attributedPlaceholder = NSAttributedString(string:"Alias",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 50/255.0, green: 80/255.0, blue: 50/255.0, alpha: 1.0)])
        emailTxtView.attributedPlaceholder = NSAttributedString(string:"Email",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 50/255.0, green: 80/255.0, blue: 50/255.0, alpha: 1.0)])
        locationTxtView.attributedPlaceholder = NSAttributedString(string:"Location",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 50/255.0, green: 80/255.0, blue: 50/255.0, alpha: 1.0)])
        
        dobTxtView.attributedPlaceholder = NSAttributedString(string:"Birthday",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 200/255.0, green: 80/255.0, blue: 160/255.0, alpha: 1.0)])
        ageTxtView.attributedPlaceholder = NSAttributedString(string:"Age",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 200/255.0, green: 80/255.0, blue: 160/255.0, alpha: 1.0)])
        ethnicityTxtView.attributedPlaceholder = NSAttributedString(string:"Ethnicity",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 200/255.0, green: 80/255.0, blue: 160/255.0, alpha: 1.0)])
        heightTxtView.attributedPlaceholder = NSAttributedString(string:"Body Type",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 200/255.0, green: 80/255.0, blue: 160/255.0, alpha: 1.0)])
        bodyTxtView.attributedPlaceholder = NSAttributedString(string:"Birthday",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 200/255.0, green: 80/255.0, blue: 160/255.0, alpha: 1.0)])
        bioTxtView.attributedPlaceholder = NSAttributedString(string:"Bio",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 200/255.0, green: 80/255.0, blue: 160/255.0, alpha: 1.0)])
    }

    @IBAction func nextBtnClk(sender: UIButton) {

        if self.checkValidate() {
            self.dismissViewControllerAnimated(true, completion: nil)
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let resultView:SResultViewController = appDelegate.mainStoryboard.instantiateViewControllerWithIdentifier("resultCtrl") as! SResultViewController
            SlideNavigationController.sharedInstance().pushViewController(resultView, animated: false)
        }
    }

    func checkValidate() -> Bool {
        if fnameTxtView.text == "" {
            alert("Please input Full Name")
            return false
        } else if aliasTxtView.text == "" {
            alert("Please input ")
            return false
        } else if emailTxtView.text == "" {
            alert("Please input ")
            return false
        } else if locationTxtView.text == "" {
            alert("Please input ")
            return false
        } else if dobTxtView.text == "" {
            alert("Please input ")
            return false
        } else if ageTxtView.text == "" {
            alert("Please input ")
            return false
        } else if ethnicityTxtView.text == "" {
            alert("Please input ")
            return false
        } else if heightTxtView.text == "" {
            alert("Please input ")
            return false
        } else if bodyTxtView.text == "" {
            alert("Please input ")
            return false
        } else if bioTxtView.text == "" {
            alert("Please input ")
            return false
        }
        
        return true
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
