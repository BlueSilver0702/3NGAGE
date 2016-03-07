//
//  InfoViewController.swift
//  3NGAGE
//
//  Created by Blue Silver on 3/7/16.
//  Copyright © 2016 Blue Silver. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    var inc:Int = 2
    
    @IBOutlet weak var bgView: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "setBack", userInfo: nil, repeats: true)
    }
    
    func setBack() {
        let imgs:[String] = ["bg1.png", "bg2.png", "bg3.png", "bg4.png", "bg5.png", "bg6.png"]

        UIView.transitionWithView(self.bgView, duration: 1.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            self.bgView.image = UIImage(named: imgs[self.inc])
            }, completion: nil)
        
        inc++;
        if inc==imgs.count {
            inc=0;
        }
    }
}
