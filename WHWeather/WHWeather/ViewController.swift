//
//  ViewController.swift
//  WHWeather
//
//  Created by airshiner on 10/12/16.
//  Copyright © 2016 airshiner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var sideController:sideMenuController!
    var homeController:homeViewController!
    var homeNavigationController:UINavigationController!
    var tapGesture:UITapGestureRecognizer!
    var mainView:UIView!
    var panGesture:UIPanGestureRecognizer!
    
    var centerOfHomeViewAtBegin:CGPoint!
    var centerOfSideMenu:CGPoint!
    var centerOfHomeView:CGPoint!
    
    var screenWidth = UIScreen.mainScreen().bounds.maxX
    var screenHeight = UIScreen.mainScreen().bounds.maxY
    
    var distanceLeftLimit:CGFloat!
    var distanceRightLimit:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        distanceLeftLimit = -self.view.center.x * 0.7
        distanceRightLimit = self.view.center.x * 0.7
        
        backViewDidLoad()
        sideMenuDidLoad()
        mainViewDidload()
        rootInit()
        gestureInit()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func backViewDidLoad() {
        let imageView = UIImageView(image: UIImage(named: "back2"))
        imageView.frame = UIScreen.mainScreen().bounds
        self.view.addSubview(imageView)
    }
    
    func sideMenuDidLoad() {
        sideController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SideMenuController") as! sideMenuController
        sideController.view.center = CGPointMake(-self.view.center.x * 0.7, sideController.view.center.y)
        sideController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 1)
        sideController.view.backgroundColor = UIColor.clearColor()
        self.view.addSubview(sideController.view)
        centerOfSideMenu = sideController.view.center
    }
    
    func mainViewDidload() {
        mainView = UIView(frame: self.view.frame)
        homeNavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HomeNavigationController") as! UINavigationController
        homeController = homeNavigationController.viewControllers.first as! homeViewController
        homeController.navigationItem.leftBarButtonItem?.action = #selector(ViewController.showLeft)
        centerOfHomeView = mainView.center
        centerOfHomeViewAtBegin = centerOfHomeView
    }
    
    func rootInit() {
        mainView.addSubview(homeController.navigationController!.view)
        mainView.addSubview(homeController.view)
        self.view.addSubview(mainView)
        self.view.addSubview(sideController.view)
    }
    
    func gestureInit() {
        let panGesture = homeController.pullOutMenu
        panGesture.addTarget(self, action: #selector(ViewController.pan(_:)))
        homeController.view.addGestureRecognizer(panGesture)
        tapGesture = UITapGestureRecognizer(target:self,action:#selector(ViewController.showHome))
    }
    
    func pan(recongnizer: UIPanGestureRecognizer) {
        
        let Distance = recongnizer.translationInView(self.view).x
        
        if centerOfSideMenu.x + Distance > distanceLeftLimit && centerOfSideMenu.x + Distance < distanceRightLimit {
            
            sideController.view!.center = CGPointMake(centerOfSideMenu.x + Distance, sideController.view.center.y)
            
            mainView.center = CGPointMake(centerOfHomeView.x + Distance, mainView.center.y)
            let tmp:CGFloat = 1 - (centerOfHomeView.x + Distance - centerOfHomeViewAtBegin.x) / (screenWidth * 2)
            mainView.transform = CGAffineTransformScale(CGAffineTransformIdentity, tmp, tmp)
            
        }
        
        if recongnizer.state == UIGestureRecognizerState.Ended {
            
            if centerOfSideMenu.x > 0 {
                centerOfSideMenu = sideController.view.center
                centerOfHomeView = mainView.center
                if centerOfSideMenu.x > screenWidth * 0.15 {
                    showLeft()
                }else {
                    showHome()
                }
            }
            else {
                centerOfSideMenu = sideController.view.center
                centerOfHomeView = mainView.center
                if centerOfSideMenu.x > -screenWidth * 0.15 {
                    showLeft()
                }else {
                    showHome()
                }
            }
            centerOfSideMenu = sideController.view.center
            centerOfHomeView = mainView.center
        }
    }
    
    func showLeft() {
        mainView.addGestureRecognizer(tapGesture)
        doTheAnimate("left")
    }

    func showHome() {
        mainView.removeGestureRecognizer(tapGesture)
        doTheAnimate("home")
    }
    
    func doTheAnimate(showWhat: String) {
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            if showWhat == "left" {
                self.sideController.view.center = CGPointMake(self.distanceRightLimit, self.sideController.view.center.y)
                self.mainView.center = CGPointMake(self.screenWidth * 1.2, self.mainView.center.y)
                self.mainView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7)
            }else {
                self.sideController.view.center = CGPointMake(self.distanceLeftLimit, self.sideController.view.center.y)
                self.mainView.center = CGPointMake(self.screenWidth * 0.5, self.mainView.center.y)
                self.mainView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1)
            }
            self.centerOfSideMenu = self.sideController.view.center
            self.centerOfHomeView = self.mainView.center
            
            } , completion: nil)
    }

}

