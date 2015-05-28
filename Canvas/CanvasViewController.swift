//
//  CanvasViewController.swift
//  Canvas
//
//  Created by ming yeow ng on 5/27/15.
//  Copyright (c) 2015 David Kuchar. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {


    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    
    
    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        trayOriginalCenter = trayView.center
        println(trayView.center)
        
        var screenHeight = UIScreen.mainScreen().bounds.height
        trayUp = CGPoint(x: trayOriginalCenter.x, y: screenHeight - (trayView.frame.height / 2))
        trayDown = CGPoint(x: trayOriginalCenter.x, y: screenHeight + (trayView.frame.height / 2) - 50)
        
        trayView.center = trayDown
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTrayPanView(sender: AnyObject) {
        var point = panGestureRecognizer.locationInView(view)
        var velocity = panGestureRecognizer.velocityInView(view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            println("Gesture began at: \(point)")
            trayOriginalCenter = trayView.center
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            println("Gesture changed at: \(point)")
            var translation_y = point.y - trayOriginalCenter.y
            var newCenter = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation_y)
            if newCenter.y <= trayUp.y {
                trayView.center = newCenter
            }
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            if velocity.y > 0 {
                println("going down")
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.trayView.center = self.trayDown
                })
//                UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: <#UIViewAnimationOptions#>, animations: { () -> Void in
//                    
//                }, completion: { (<#Bool#>) -> Void in
//                    self.trayView.center = self.trayDown
//                })
            } else {
                println("going up")
                trayView.center = trayUp
            }
            println("Gesture ended at: \(point)")
        }
        println(trayView.center)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
