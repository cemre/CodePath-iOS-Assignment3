//
//  CellViewController.swift
//  Assignment3
//
//  Created by Cemre Güngör on 11/2/14.
//  Copyright (c) 2014 cemre. All rights reserved.
//

import UIKit

class CellViewController: UIViewController {

    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var deleteView: UIImageView!
    @IBOutlet weak var archiveView: UIImageView!
    @IBOutlet weak var laterView: UIImageView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func convertValue(value: Float, r1Min: Float, r1Max: Float, r2Min: Float, r2Max: Float) -> Float {
        var ratio = (r2Max - r2Min) / (r1Max - r1Min)
        return value * ratio + r2Min - r1Min * ratio
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onDrag(sender: UIPanGestureRecognizer) {
        var translation = sender.translationInView(view)
        var currentX = messageView.frame.origin.x
        var iconX: CGFloat
        
        listView.alpha = 0
        deleteView.alpha = 0
        archiveView.alpha = 0
        laterView.alpha = 0
        
        println(currentX)

        
        if sender.state == UIGestureRecognizerState.Began {
            leftView.frame.origin.x = 10
            rightView.frame.origin.x = 280
            containerView.backgroundColor = UIColor.groupTableViewBackgroundColor()
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            messageView.frame.origin.x = translation.x
            
            
            if currentX > 0 {
                leftView.alpha = CGFloat(convertValue(Float(currentX), r1Min: 0, r1Max: 60, r2Min: 0, r2Max: 1))
                
                if currentX > 60 {
                    leftView.frame.origin.x = currentX - leftView.frame.width - 20
                }
                
                if currentX > 60 && currentX < 260 {
                    containerView.backgroundColor = UIColor(red: 248/255, green: 209/255, blue: 51/255, alpha: 1)
                }
                
                if currentX < 260 {
                    archiveView.alpha = 1
                } else {
                    deleteView.alpha = 1
                    containerView.backgroundColor = UIColor(red: 112/255, green: 217/255, blue: 98/255, alpha: 1)
                }
                

            } else {
                rightView.alpha = CGFloat(convertValue(Float(currentX), r1Min: 0, r1Max: -60, r2Min: 0, r2Max: 1))
                if currentX < -60 {
                    rightView.frame.origin.x = currentX + messageView.frame.width + 20
                }
                
                if currentX < -60 && currentX > -260 {
                    containerView.backgroundColor = UIColor(red: 250/255, green: 211/255, blue: 51/255, alpha: 1)
                }
                
                if currentX > -260 {
                    laterView.alpha = 1
                } else {
                    listView.alpha = 1
                    containerView.backgroundColor = UIColor(red: 216/255, green: 166/255, blue: 117/255, alpha: 1)
                }
            }
            

            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            if currentX < 60 || currentX > -60 {
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options: nil, animations: { () -> Void in
                    self.messageView.frame.origin.x = 0
                    }, completion: nil)
            }
            
            if currentX > 60 && currentX < 260 {
                
            }
                
        }

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
