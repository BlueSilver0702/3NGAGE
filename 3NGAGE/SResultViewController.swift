//
//  SResultViewController.swift
//  3NGAGE
//
//  Created by Blue Silver on 3/3/16.
//  Copyright © 2016 Blue Silver. All rights reserved.
//

import UIKit

class SResultViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgContainer: UIScrollView!
    @IBOutlet weak var wrapperScroll: UIScrollView!
    
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var aliasLab: UILabel!
    @IBOutlet weak var metaLab: UILabel!
    @IBOutlet weak var bioLab: UILabel!
    
    var appDelegate: AppDelegate!
    
    var ImageWidth: CGFloat = 320
    var ImageHeight: CGFloat = 454
    
    var mUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        // Do any additional setup after loading the view.
        let imgs: [String] = ["7335a.png", "7335b.png", "7335c.png", "7335d.png", "7335e.png", "7335f.png", "7335g.png", "7335h.png"]
        
        var tag:Int = 0
        
        for img in imgs {
            let imgView:UIImageView = UIImageView(image: UIImage(named: img))
            imgView.frame = CGRectMake(ImageWidth*CGFloat(tag), 0, ImageWidth, ImageHeight);
            imgView.tag = tag + 10
            tag++
            self.imgContainer.addSubview(imgView)
            //self.wrapperScroll.addSubview(imgView)
        }
        
        self.imgContainer.contentSize = CGSizeMake(CGFloat(imgs.count)*ImageWidth, ImageHeight);
        self.imgContainer.backgroundColor = UIColor.grayColor()
        
        /////////
        self.wrapperScroll.contentSize = CGSizeMake(CGFloat(imgs.count)*ImageWidth, ImageHeight);
        
        /////////
        self.scrollView.backgroundColor = UIColor.clearColor()
        self.scrollView.contentSize = CGSizeMake(320, 850);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        nameLab.text = mUser.qbUser.fullName
        aliasLab.text = mUser.mAlias
        metaLab.text = appDelegate.g_var.ethnicitys[mUser.mEthnicity] + ": " + mUser.mHeight + "cm : age-" + mUser.mAge + " : " + appDelegate.g_var.bodys[mUser.mBody]
        bioLab.text = mUser.mBio
    }
    
    func initData(user: User) {
        mUser = user
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let yOffset:CGFloat = self.scrollView.contentOffset.y
        let xOffset:CGFloat = self.wrapperScroll.contentOffset.x
        
        if (yOffset < 0) {
            let pageWidth:CGFloat = self.wrapperScroll.frame.size.width
            let page:Int = Int(floor((self.wrapperScroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1.0)
            
            var imgTmp:UIImageView!
            
            print("count:"+String(self.imgContainer.subviews.count))
            
            for view in self.imgContainer.subviews {
                if view.isKindOfClass(UIImageView) {
                    if view.tag == page+10 {
                        imgTmp = view as! UIImageView
                    }
                }
            }
            
            let factor:CGFloat = ((abs(yOffset)+ImageHeight)*ImageWidth)/ImageHeight
            var f:CGRect = CGRectMake((-(factor-ImageWidth)/2)+320.0*CGFloat(page), 0, ImageWidth, ImageHeight)
            f.size.height = abs(yOffset)+ImageHeight
            f.size.width = factor;
            imgTmp.frame = f;
            
            var frame:CGRect = self.imgContainer.frame;
            frame.origin.y = 0;
            self.imgContainer.frame = frame;
        } else {
            self.imgContainer.contentOffset = CGPointMake(xOffset, yOffset);
        }
    }
    
    func alert(txtMSG: String) {
        // create the alert
        let alert = UIAlertController(title: "Alert", message: txtMSG, preferredStyle: UIAlertControllerStyle.Alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func menuBtnClk(sender: UIButton) {
        SlideNavigationController.sharedInstance().toggleRightMenu()
        if (appDelegate.rightMenu.fnameLab != nil) {
            appDelegate.rightMenu.updateMenu()
        }
    }
    
    @IBAction func redBtnClk(sender: UIButton) {
        if (mUser == appDelegate.g_var.currentUser) {
            return
        }
        alert("You liked " + mUser.qbUser.fullName!)
        self.next()
    }
    
    @IBAction func blackBtnClk(sender: UIButton) {
        if (mUser == appDelegate.g_var.currentUser) {
            return
        }
        self.next()
    }
    
    func next() {
        self.appDelegate.g_var.currentIndex++
        if (self.appDelegate.g_var.users.count == self.appDelegate.g_var.currentIndex) {
            appDelegate.g_var.currentPage++
            
            let page: QBGeneralResponsePage = QBGeneralResponsePage(currentPage: UInt(appDelegate.g_var.currentPage), perPage: 20)
            
            QBRequest.usersForPage(page, successBlock: { (response: QBResponse, responsePage: QBGeneralResponsePage?, users: [QBUUser]?) -> Void in
                if users!.count > 0 {
                    self.appDelegate.g_var.users = []
                    for user in users! {
                        let nUser: User = User(user: user)
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
        } else {
            let resultView:SResultViewController = self.appDelegate.mainStoryboard.instantiateViewControllerWithIdentifier("resultCtrl") as! SResultViewController
            SlideNavigationController.sharedInstance().pushViewController(resultView, animated: true)
            resultView.initData(self.appDelegate.g_var.users[self.appDelegate.g_var.currentIndex])
        }
    }
}
