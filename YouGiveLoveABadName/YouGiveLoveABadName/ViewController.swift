//
//  ViewController.swift
//  YouGiveLoveABadName
//
//  Created by Flatiron School on 6/30/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bonJovi: UIImageView!
    
    var startingHeightConstraintHalfOfScreen : NSLayoutConstraint?
    var shrinkHeightConstraint: NSLayoutConstraint?
    var expandedHeightConstraintBeyondScreen : NSLayoutConstraint?
    var heightConstraintEqualToFullScreenJoeLecture: NSLayoutConstraint? //7-14 Morning
    
    var shouldExpand : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        bonJovi.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
//        bonJovi.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor).active = true
//        bonJovi.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        
        self.startingHeightConstraintHalfOfScreen = bonJovi.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.5)
        self.startingHeightConstraintHalfOfScreen?.active = true
        
        
    }
    
    @IBAction func expandButtonTapped(sender: AnyObject) {
        UIView.animateKeyframesWithDuration(0.5, delay: 0, options: UIViewKeyframeAnimationOptions.CalculationModePaced, animations: {
            
                //UIViewKeyframeAnimationOptionCalculationModeLinear -- key frames can speed up and slow down, all key frames are taken in whole "linearly interpolated"
                //UIViewKeyframeAnimationOptionCalculationModePaced -- frames are attempted to be displayed together at an average rate
                
                self.shouldExpand ? self.expandJoviKeyFrames() : self.shrinkJoviKeyFrames()

            
            
            }) { (completed) in
                self.shouldExpand = !self.shouldExpand
                }
    }
    
    func expandJoviKeyFrames() { //#be jovial
            
            //Shrink height less than original size
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1.0/3.0, animations: {
                self.startingHeightConstraintHalfOfScreen?.active = false
                
                self.shrinkHeightConstraint = self.bonJovi.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.45)
                self.shrinkHeightConstraint?.active = true
                self.view.layoutIfNeeded()
            })
            
            //Expand height beyond borders of screen
            UIView.addKeyframeWithRelativeStartTime(1.0/3.0, relativeDuration: 1.0/3.0, animations: {
                self.shrinkHeightConstraint?.active = false
                
                self.expandedHeightConstraintBeyondScreen = self.bonJovi.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 1.05)
                self.expandedHeightConstraintBeyondScreen?.active = true
                self.view.layoutIfNeeded()
            })
            
            //Settle to height of screen
            UIView.addKeyframeWithRelativeStartTime(2.0/3.0, relativeDuration: 1.0/3.0, animations: {
                self.expandedHeightConstraintBeyondScreen?.active = false
            
                self.heightConstraintEqualToFullScreenJoeLecture = self.bonJovi.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 1.0)
                self.heightConstraintEqualToFullScreenJoeLecture?.active = true
                self.view.layoutIfNeeded()
            })
            
    }
    
    

    func shrinkJoviKeyFrames() {
        
            //Expand height beyond borders of screen
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1.0/3.0) {
                self.heightConstraintEqualToFullScreenJoeLecture?.active = false
                self.expandedHeightConstraintBeyondScreen?.active = true
                self.view.layoutIfNeeded()
        }
            //Shrink height less than original size
            UIView.addKeyframeWithRelativeStartTime(1.0/3.0, relativeDuration: 1.0/3.0) { 
                self.expandedHeightConstraintBeyondScreen?.active = false
                self.shrinkHeightConstraint?.active = true
                self.view.layoutIfNeeded()
        }
            //Settle to original 1/2 height
            UIView.addKeyframeWithRelativeStartTime(2.0/3.0, relativeDuration: 1.0/3.0) { 
                self.shrinkHeightConstraint?.active = false
                self.startingHeightConstraintHalfOfScreen?.active = true
                self.view.layoutIfNeeded()
        }
        
    }
}

