//
//  User.swift
//  3NGAGE
//
//  Created by Blue Silver on 3/9/16.
//  Copyright © 2016 Blue Silver. All rights reserved.
//

import UIKit

class User: NSObject {
    var qbUser:QBUUser!
    var mAge: String = ""
    var mEthnicity: Int = 0
    var mHeight: String = ""
    var mBody: Int = 0
    var mBio: String = ""
    var mAlias: String = ""
    var mLocation: Int = 0
    
    init(user: QBUUser) {
        super.init()
        qbUser = user
        //loadTag()
    }
    
    func loadTag() {
//        mAge = qbUser.tags![0] as! String
//        mEthnicity = qbUser.tags![1] as! Int
//        mHeight = qbUser.tags![2] as! String
//        mBody = qbUser.tags![3] as! Int
//        mBio = qbUser.tags![4] as! String
//        mAlias = qbUser.tags![5] as! String
//        mLocation = qbUser.tags![6] as! Int
    }
}
