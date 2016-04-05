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
    @IBOutlet weak var ageTxtView: UITextField!
    @IBOutlet weak var ethnicityTxtView: UITextField!
    @IBOutlet weak var heightTxtView: UITextField!
    @IBOutlet weak var bodyTxtView: UITextField!
    @IBOutlet weak var bioTxtView: UITextView!
    
//    var dobPicker: DownPicker!
    var agePicker: DownPicker!
    var ethnicityPicker: DownPicker!
    var heightPicker: DownPicker!
    var bodyPicker: DownPicker!
    var locationPicker: DownPicker!
    
    var appDelegate: AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        fnameTxtView.attributedPlaceholder = NSAttributedString(string:"Full Name",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 50/255.0, green: 80/255.0, blue: 50/255.0, alpha: 1.0)])
        aliasTxtView.attributedPlaceholder = NSAttributedString(string:"Alias",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 50/255.0, green: 80/255.0, blue: 50/255.0, alpha: 1.0)])
        emailTxtView.attributedPlaceholder = NSAttributedString(string:"Email",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 50/255.0, green: 80/255.0, blue: 50/255.0, alpha: 1.0)])
        
        locationTxtView.attributedPlaceholder = NSAttributedString(string:"Location",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 200/255.0, green: 80/255.0, blue: 160/255.0, alpha: 1.0)])
        ageTxtView.attributedPlaceholder = NSAttributedString(string:"Age",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 200/255.0, green: 80/255.0, blue: 160/255.0, alpha: 1.0)])
        ethnicityTxtView.attributedPlaceholder = NSAttributedString(string:"Ethnicity",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 200/255.0, green: 80/255.0, blue: 160/255.0, alpha: 1.0)])
        heightTxtView.attributedPlaceholder = NSAttributedString(string:"Height",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 200/255.0, green: 80/255.0, blue: 160/255.0, alpha: 1.0)])
        bodyTxtView.attributedPlaceholder = NSAttributedString(string:"Body Type",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 200/255.0, green: 80/255.0, blue: 160/255.0, alpha: 1.0)])
        
        // age
        var ageArr: [String] = []
        for var i = 10; i < 61; i++ {
            ageArr.append(String(i))
        }
        agePicker = DownPicker(textField: ageTxtView, withData: ageArr)
        
        // ethnicity
        ethnicityPicker = DownPicker(textField: ethnicityTxtView, withData: ["WHT", "LTN", "ASN", "BLK", "OTR"])
        
        // height
        var heightArr: [String] = []
        for var i = 150; i < 200; i++ {
            heightArr.append(String(i))
        }
        heightPicker = DownPicker(textField: heightTxtView, withData: heightArr)
        
        // body
        bodyPicker = DownPicker(textField: bodyTxtView, withData: ["SLIM", "FIT", "AVERAGE", "CHUBBY", "OVERHEIGHT"])
        
        // bio
        locationPicker = DownPicker(textField: locationTxtView, withData: appDelegate.g_var.locations)
    }

    @IBAction func nextBtnClk(sender: UIButton) {

        if self.checkValidate() {

            SVProgressHUD.showWithStatus("Saving...")
        
            let updateParameters: QBUpdateUserParameters = QBUpdateUserParameters()
            updateParameters.fullName = fnameTxtView.text
            updateParameters.email = emailTxtView.text
            
            QBRequest .updateCurrentUser(updateParameters, successBlock: { (response: QBResponse, user:QBUUser?) -> Void in
                
                self.appDelegate.g_var.currentUser.qbUser = user
                self.appDelegate.g_var.currentUser.l
                
                let object: QBCOCustomObject = QBCOCustomObject()
                object.className = "Meta"
                
                object.fields!["_parent_id"] = String(user!.ID)
                object.fields!["Age"] = self.agePicker.text
                object.fields!["Ethnicity"] = self.ethnicityPicker.text
                object.fields!["Height"] = self.heightPicker.text
                object.fields!["BodyType"] = self.bodyPicker.text
                object.fields!["Bio"] = self.bioPicker.text
                object.fields!["Alias"] = self.aliasTxtView.text
                object.fields!["Location"] = self.locationTxtView.text
                
//                QBRequest.createObject(object, successBlock: , errorBlock: )
                QBRequest .createObject(object, successBlock: { (objResponse:QBResponse, nObj: QBCOCustomObject?) -> Void in
                    
                    //print(nObj)
                    let newParameters: QBUpdateUserParameters = QBUpdateUserParameters()
                    newParameters.twitterDigitsID = (objResponse.data?.valueForKey("_id"))! as? String
                    
                    QBRequest .updateCurrentUser(newParameters, successBlock: { (response: QBResponse, user:QBUUser?) -> Void in
                        
                        SVProgressHUD.dismiss()
                        
                        self.dismissViewControllerAnimated(true, completion: nil)
                        
                        let resultView:SResultViewController = appDelegate.mainStoryboard.instantiateViewControllerWithIdentifier("resultCtrl") as! SResultViewController
                        SlideNavigationController.sharedInstance().pushViewController(resultView, animated: false)
                        
                        }, errorBlock: { (errResponse) -> Void in
                            SVProgressHUD.dismiss()
                            self.alert("Err occured!")
                    })
                    
                    }, errorBlock: { (errResponse: QBResponse) -> Void in
                        SVProgressHUD.dismiss()
                        self.alert("Custom Err occured!")
                })
                
                }, errorBlock: { (errResponse) -> Void in
                    SVProgressHUD.dismiss()
                    self.alert("Err occured!")
            })
        }
    }

    func checkValidate() -> Bool {
        if fnameTxtView.text == "" {
            alert("Please input Full Name")
            return false
        } else if aliasTxtView.text == "" {
            alert("Please input Alias")
            return false
        } else if emailTxtView.text == "" {
            alert("Please input Email")
            return false
        } else if locationTxtView.text == "" {
            alert("Please input location")
            return false
//        } else if dobTxtView.text == "" {
//            alert("Please input ")
//            return false
        } else if ageTxtView.text == "" {
            alert("Please select Age")
            return false
        } else if ethnicityTxtView.text == "" {
            alert("Please select Ethnicity")
            return false
        } else if heightTxtView.text == "" {
            alert("Please select Height")
            return false
        } else if bodyTxtView.text == "" {
            alert("Please select Body Type")
            return false
        } else if bioTxtView.text == "" {
            alert("Please select Bio")
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
