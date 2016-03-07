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
    
    var ImageWidth: CGFloat = 320
    var ImageHeight: CGFloat = 454
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
    
    @IBAction func redBtnClk(sender: UIButton) {
        alert("Red Heart Clicked!")
    }
    
    @IBAction func blackBtnClk(sender: UIButton) {
        alert("Black Heart Clicked!")
    }
    
    @IBAction func updateBtnClk(sender: UIButton) {
        alert("Update Button Clicked!")
    }
}
