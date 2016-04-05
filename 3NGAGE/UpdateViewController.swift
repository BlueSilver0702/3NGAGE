//
//  UpdateViewController.swift
//  3NGAGE
//
//  Created by Blue Silver on 3/7/16.
//  Copyright © 2016 Blue Silver. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {

    @IBOutlet weak var discoverableCheck: M13Checkbox!
    
    @IBOutlet weak var eth1Check: M13Checkbox!
    @IBOutlet weak var eth2Check: M13Checkbox!
    @IBOutlet weak var eth3Check: M13Checkbox!
    @IBOutlet weak var eth4Check: M13Checkbox!
    @IBOutlet weak var eth5Check: M13Checkbox!
    
    @IBOutlet weak var body1Check: M13Checkbox!
    @IBOutlet weak var body2Check: M13Checkbox!
    @IBOutlet weak var body3Check: M13Checkbox!
    @IBOutlet weak var body4Check: M13Checkbox!
    @IBOutlet weak var body5Check: M13Checkbox!
    
    @IBOutlet weak var ageRange: NMRangeSlider!
    
    @IBOutlet weak var ageRangeLab: UILabel!
    
    var appDelegate: AppDelegate!
    
    var locationPicker: DownPicker!
    var distancePicker: DownPicker!
    
    @IBOutlet weak var locationTxt: UITextField!
    @IBOutlet weak var distanceTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        discoverableCheck.titleLabel.font = UIFont(name: "Avenir Next Condensed", size: 15.0)
        discoverableCheck.titleLabel.text = "DISCOVERABLE IN SEARCHES"
        discoverableCheck.radius = 10.0;
        
        eth1Check.titleLabel.font = UIFont(name: "Avenir Next Condensed", size: 14.0)
        eth1Check.titleLabel.text = "WHT"
        eth1Check.checkAlignment = M13CheckboxAlignment.Left
        eth1Check.radius = 10.0;

        eth2Check.titleLabel.font = UIFont(name: "Avenir Next Condensed", size: 14.0)
        eth2Check.titleLabel.text = "LTN"
        eth2Check.checkAlignment = M13CheckboxAlignment.Left
        eth2Check.radius = 10.0;

        eth3Check.titleLabel.font = UIFont(name: "Avenir Next Condensed", size: 14.0)
        eth3Check.titleLabel.text = "ASN"
        eth3Check.checkAlignment = M13CheckboxAlignment.Left
        eth3Check.radius = 10.0;

        eth4Check.titleLabel.font = UIFont(name: "Avenir Next Condensed", size: 14.0)
        eth4Check.titleLabel.text = "BLK"
        eth4Check.checkAlignment = M13CheckboxAlignment.Left
        eth4Check.radius = 10.0;

        eth5Check.titleLabel.font = UIFont(name: "Avenir Next Condensed", size: 14.0)
        eth5Check.titleLabel.text = "OTR"
        eth5Check.checkAlignment = M13CheckboxAlignment.Left
        eth5Check.radius = 10.0;

        body1Check.titleLabel.font = UIFont(name: "Avenir Next Condensed", size: 14.0)
        body1Check.titleLabel.text = "SLIM"
        body1Check.checkAlignment = M13CheckboxAlignment.Left
        body1Check.radius = 10.0;

        body2Check.titleLabel.font = UIFont(name: "Avenir Next Condensed", size: 14.0)
        body2Check.titleLabel.text = "FIT"
        body2Check.checkAlignment = M13CheckboxAlignment.Left
        body2Check.radius = 10.0;

        body3Check.titleLabel.font = UIFont(name: "Avenir Next Condensed", size: 14.0)
        body3Check.titleLabel.text = "AVERAGE"
        body3Check.checkAlignment = M13CheckboxAlignment.Left
        body3Check.radius = 10.0;

        body4Check.titleLabel.font = UIFont(name: "Avenir Next Condensed", size: 14.0)
        body4Check.titleLabel.text = "CHUBBY"
        body4Check.checkAlignment = M13CheckboxAlignment.Left
        body4Check.radius = 10.0;

        body5Check.titleLabel.font = UIFont(name: "Avenir Next Condensed", size: 14.0)
        body5Check.titleLabel.text = "OVERWEIGHT"
        body5Check.checkAlignment = M13CheckboxAlignment.Left
        body5Check.radius = 10.0;
        
        if (appDelegate.g_var.sDiscoverable == true) {
            discoverableCheck.checkState = M13CheckboxState.Checked
        }
        
        if (appDelegate.g_var.sEthnicity[0] == true) {
            eth1Check.checkState = M13CheckboxState.Checked
        }

        if (appDelegate.g_var.sEthnicity[1] == true) {
            eth2Check.checkState = M13CheckboxState.Checked
        }

        if (appDelegate.g_var.sEthnicity[2] == true) {
            eth3Check.checkState = M13CheckboxState.Checked
        }

        if (appDelegate.g_var.sEthnicity[3] == true) {
            eth4Check.checkState = M13CheckboxState.Checked
        }

        if (appDelegate.g_var.sEthnicity[4] == true) {
            eth5Check.checkState = M13CheckboxState.Checked
        }
        /////
        if (appDelegate.g_var.sBody[0] == true) {
            body1Check.checkState = M13CheckboxState.Checked
        }
        
        if (appDelegate.g_var.sBody[1] == true) {
            body2Check.checkState = M13CheckboxState.Checked
        }
        
        if (appDelegate.g_var.sBody[2] == true) {
            body3Check.checkState = M13CheckboxState.Checked
        }
        
        if (appDelegate.g_var.sBody[3] == true) {
            body4Check.checkState = M13CheckboxState.Checked
        }
        
        if (appDelegate.g_var.sBody[4] == true) {
            body5Check.checkState = M13CheckboxState.Checked
        }
        
        ageRange.stepValue = 1
        ageRange.stepValueContinuously = true
        ageRange.minimumValue = 10
        ageRange.maximumValue = 100
        ageRange.setLowerValue(appDelegate.g_var.sAgeMin, animated: true)
        ageRange.setLowerValue(appDelegate.g_var.sAgeMax, animated: true)
        
        ageRangeLab.text = "AGE RANGE [" + String(appDelegate.g_var.sAgeMin) + " - " + String(appDelegate.g_var.sAgeMax) + "]"
        
        locationPicker = DownPicker(textField: locationTxt, withData: appDelegate.g_var.locations)
        distancePicker = DownPicker(textField: distanceTxt, withData: appDelegate.g_var.distances)
        
        locationPicker.selectedIndex = appDelegate.g_var.sLocation
        distancePicker.selectedIndex = appDelegate.g_var.sDistance
    }
    
    @IBAction func labelSliderChanged(sender: NMRangeSlider) {
        ageRangeLab.text = "AGE RANGE [" + String(sender.lowerValue) + " - " + String(sender.upperValue) + "]"
    }
    
    @IBAction func menuBtnClk(sender: UIButton) {
        SlideNavigationController.sharedInstance().toggleRightMenu()
    }
    
    @IBAction func saveBtnClk(sender: UIButton) {
        if discoverableCheck.checkState == M13CheckboxState.Checked {
            appDelegate.g_var.sDiscoverable = true
        } else {
            appDelegate.g_var.sDiscoverable = false
        }
        
        appDelegate.g_var.sLocation = locationPicker.selectedIndex
        appDelegate.g_var.sDistance = distancePicker.selectedIndex

        appDelegate.g_var.sAgeMin = ageRange.lowerValue
        appDelegate.g_var.sAgeMax = ageRange.upperValue
        
        var eth1: Bool = false
        var eth2: Bool = false
        var eth3: Bool = false
        var eth4: Bool = false
        var eth5: Bool = false
        
        if (eth1Check.checkState == M13CheckboxState.Checked) {eth1 = true}
        if (eth2Check.checkState == M13CheckboxState.Checked) {eth2 = true}
        if (eth3Check.checkState == M13CheckboxState.Checked) {eth3 = true}
        if (eth4Check.checkState == M13CheckboxState.Checked) {eth4 = true}
        if (eth5Check.checkState == M13CheckboxState.Checked) {eth5 = true}

        appDelegate.g_var.sEthnicity = [eth1, eth2, eth3, eth4, eth5]
            
        var body1: Bool = false
        var body2: Bool = false
        var body3: Bool = false
        var body4: Bool = false
        var body5: Bool = false

        if (body1Check.checkState == M13CheckboxState.Checked) {body1 = true}
        if (body2Check.checkState == M13CheckboxState.Checked) {body2 = true}
        if (body3Check.checkState == M13CheckboxState.Checked) {body3 = true}
        if (body4Check.checkState == M13CheckboxState.Checked) {body4 = true}
        if (body5Check.checkState == M13CheckboxState.Checked) {body5 = true}

        appDelegate.g_var.sBody = [body1, body2, body3, body4, body5]
        
        appDelegate.g_var.saveSetting()
        
        appDelegate.g_var.currentPage = 1
        appDelegate.g_var.currentIndex = 0
        appDelegate.g_var.users = []
        
        let loadView:LoadViewController = appDelegate.mainStoryboard.instantiateViewControllerWithIdentifier("loadCtrl") as! LoadViewController
        loadView.start()
        SlideNavigationController.sharedInstance().pushViewController(loadView, animated: true)
    }
}
