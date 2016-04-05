//
//  Global.swift
//  3NGAGE
//
//  Created by Blue Silver on 3/7/16.
//  Copyright © 2016 Blue Silver. All rights reserved.
//

import UIKit

class Global: NSObject {
    var currentUser:User!

    var currentPage: Int = 1
    var currentIndex: Int = 0
    var users: [User]!
    
    var sDiscoverable: Bool!
//    var sLocationX: Double!
//    var sLocationY: Double!
    var sLocation: Int!
    var sDistance: Int!
    var sEthnicity: [Bool]!
    var sAgeMin: Float!
    var sAgeMax: Float!
    var sBody: [Bool]!
    
    var locations = ["Austin, NC", "New York, NJ", "Atlanta, GA", "Los Angeles, SA", "Washington, VA"]
    var distances = ["1 Miles", "10 Miles", "100 Miles", "1000 Miles", "Over 1000 Miles"]
    var ethnicitys = ["WHT", "LTN", "ASN", "BLK", "OTR"]
    var bodys = ["SLIM", "FIT", "AVERAGE", "CHUBBY", "OVERWEIGHT"]
    
    func saveSetting() {
        let defaults = NSUserDefaults.standardUserDefaults()

        defaults.setBool(true, forKey: "sSave")
        defaults.setBool(sDiscoverable, forKey: "sDiscoverable")
//        defaults.setDouble(sLocationX, forKey: "sLocationX")
//        defaults.setDouble(sLocationY, forKey: "sLocationY")
        defaults.setInteger(sLocation, forKey: "sLocation")
        defaults.setInteger(sDistance, forKey: "sDistance")
        defaults.setObject(sEthnicity, forKey: "sEthnicity")
        defaults.setFloat(sAgeMax, forKey: "sAgeMin")
        defaults.setFloat(sAgeMin, forKey: "sAgeMax")
        defaults.setObject(sBody, forKey: "sBody")
    }
    
    func loadSetting() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if defaults.boolForKey("sSave") != true {
            self.sDiscoverable = true
//            self.sLocationX = 0.0
//            self.sLocationY = 0.0
            self.sLocation = 0
            self.sDistance = 3
            self.sEthnicity = [true, true, true, true, true]
            self.sAgeMin = 15
            self.sAgeMax = 60
            self.sBody = [true, true, true, true, true]
            
            self.saveSetting()
            return
        }
        
        self.sDiscoverable = defaults.boolForKey("sDiscoverable")
//        self.sLocationX = defaults.doubleForKey("sLocationX")
//        self.sLocationY = defaults.doubleForKey("sLocationY")
        self.sLocation = defaults.integerForKey("sLocation")
        self.sDistance = defaults.integerForKey("sDistance")
        self.sEthnicity = defaults.objectForKey("sEthnicity") as? [Bool] ?? [Bool]()
        self.sAgeMin = defaults.floatForKey("sAgeMin")
        self.sAgeMax = defaults.floatForKey("sAgeMax")
        self.sBody = defaults.objectForKey("sBody") as? [Bool] ?? [Bool]()
    }
}
