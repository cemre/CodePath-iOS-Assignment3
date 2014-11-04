//
//  MailboxViewController.swift
//  Assignment3
//
//  Created by Cemre Güngör on 11/2/14.
//  Copyright (c) 2014 cemre. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController, UIGestureRecognizerDelegate {
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer!, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer!) -> Bool {
        return true
    }

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var listPanelView: UIImageView!
    @IBOutlet weak var reschedulePanelView: UIImageView!
    @IBOutlet weak var feedView: UIImageView!
    
    
    @IBOutlet weak var screenView: UIView!
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var deleteView: UIImageView!
    @IBOutlet weak var archiveView: UIImageView!
    @IBOutlet weak var laterView: UIImageView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet var containerView: UIView!

    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet var tapGestureRecognizer1: UITapGestureRecognizer!
    @IBOutlet var tapGestureRecognizer2: UITapGestureRecognizer!
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    
    @IBOutlet var longPressGestureRecognizer: UILongPressGestureRecognizer!

    var edgePanGestureRecognizer: UIScreenEdgePanGestureRecognizer!
    
    func convertValue(value: Float, r1Min: Float, r1Max: Float, r2Min: Float, r2Max: Float) -> Float {
        var ratio = (r2Max - r2Min) / (r1Max - r1Min)
        return value * ratio + r2Min - r1Min * ratio
    }


    @IBAction func menuButtonTap(sender: AnyObject) {
        UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
            self.screenView.frame.origin.x = 300
        }, completion: nil)
    }
    
    @IBAction func screenTouch(sender: AnyObject) {
        if screenView.frame.origin.x > 0 {
            UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
                self.screenView.frame.origin.x = 0
                }, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGestureRecognizer1.delegate = self
        tapGestureRecognizer2.delegate = self
        longPressGestureRecognizer.delegate = self
        // Do any additional setup after loading the view.
        scrollView.contentSize = CGSize(width: 320, height: 1288)
        reschedulePanelView.alpha = 0
        reschedulePanelView.frame.origin.x = 0
        listPanelView.alpha = 0
        listPanelView.frame.origin.x = 0
        
        edgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "onScreenEdgePan:")
        edgePanGestureRecognizer.edges = UIRectEdge.Left
        edgePanGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(edgePanGestureRecognizer)
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onTap(sender: AnyObject) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.reschedulePanelView.alpha = 0
            self.listPanelView.alpha = 0
        })
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options: nil, animations: { () -> Void in
            self.messageView.frame.origin.x = 0
            }, completion: nil)

    }
    
    @IBAction func onDrag(sender: UIPanGestureRecognizer) {
        var translation = sender.translationInView(view)
        var currentX = messageView.frame.origin.x
        var iconX: CGFloat
        
        
        if sender.state == UIGestureRecognizerState.Began {
            leftView.frame.origin.x = 10
            rightView.frame.origin.x = 280
            containerView.backgroundColor = UIColor.groupTableViewBackgroundColor()
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            listView.alpha = 0
            deleteView.alpha = 0
            archiveView.alpha = 0
            laterView.alpha = 0

            messageView.frame.origin.x = translation.x
            
            
            if currentX > 0 {
                leftView.alpha = CGFloat(convertValue(Float(currentX), r1Min: 0, r1Max: 60, r2Min: 0, r2Max: 1))
                
                if currentX > 60 {
                    leftView.frame.origin.x = currentX - leftView.frame.width - 20
                }
                
                if currentX > 60 && currentX < 260 {
                    containerView.backgroundColor = UIColor(red: 112/255, green: 217/255, blue: 98/255, alpha: 1)
                }
                
                if currentX < 260 {
                    archiveView.alpha = 1
                } else {
                    deleteView.alpha = 1
                    containerView.backgroundColor = UIColor(red: 235/255, green: 84/255, blue: 51/255, alpha: 1)
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
            
            if currentX > -60 {
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options: nil, animations: { () -> Void in
                    self.messageView.frame.origin.x = 0
                    }, completion: nil)
            }
            
            if currentX > 60 {
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options: nil, animations: { () -> Void in
                    
                    self.feedView.frame.origin.y = 0
                    
                    }, completion: nil)
            }
            
            if currentX < -60 && currentX > -260 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.reschedulePanelView.alpha = 1
                })
            }
            
            if currentX <= -260 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.listPanelView.alpha = 1
                })
            }
            
        }
        
    }

    @IBAction func onScreenEdgePan(sender: UIScreenEdgePanGestureRecognizer) {
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            screenView.frame.origin.x = translation.x
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            if velocity.x > CGFloat(0) {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.screenView.frame.origin.x = 300
                })
            } else {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.screenView.frame.origin.x = 0
                })
            }
        }

    }
    
    @IBAction func onLongPress(sender: AnyObject) {
        
        if screenView.frame.origin.x > 250 {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.screenView.frame.origin.x = 0
            })
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
