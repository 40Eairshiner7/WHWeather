//
//  ViewController.swift
//  WHWeather
//
//  Created by airshiner on 10/12/16.
//  Copyright © 2016 airshiner. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


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
    
    var screenWidth = UIScreen.main.bounds.maxX
    var screenHeight = UIScreen.main.bounds.maxY
    
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
        imageView.frame = UIScreen.main.bounds
        self.view.addSubview(imageView)
    }
    
    func sideMenuDidLoad() {
        sideController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenuController") as! sideMenuController
        sideController.view.center = CGPoint(x: -self.view.center.x * 0.7, y: sideController.view.center.y)
        sideController.view.transform = CGAffineTransform.identity.scaledBy(x: 0.7, y: 1)
        sideController.view.backgroundColor = UIColor.clear
        self.view.addSubview(sideController.view)
        centerOfSideMenu = sideController.view.center
    }
    
    func mainViewDidload() {
        mainView = UIView(frame: self.view.frame)
        homeNavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNavigationController") as! UINavigationController
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
        panGesture?.addTarget(self, action: #selector(ViewController.pan(_:)))
        homeController.view.addGestureRecognizer(panGesture!)
        tapGesture = UITapGestureRecognizer(target:self,action:#selector(ViewController.showHome))
    }
    
    func pan(_ recongnizer: UIPanGestureRecognizer) {
        
        let Distance = recongnizer.translation(in: self.view).x
        
        if centerOfSideMenu.x + Distance > distanceLeftLimit && centerOfSideMenu.x + Distance < distanceRightLimit {
            
            sideController.view!.center = CGPoint(x: centerOfSideMenu.x + Distance, y: sideController.view.center.y)
            
            mainView.center = CGPoint(x: centerOfHomeView.x + Distance, y: mainView.center.y)
            let tmp:CGFloat = 1 - (centerOfHomeView.x + Distance - centerOfHomeViewAtBegin.x) / (screenWidth * 2)
            mainView.transform = CGAffineTransform.identity.scaledBy(x: tmp, y: tmp)
            
        }
        
        if recongnizer.state == UIGestureRecognizerState.ended {
            
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
    
    func doTheAnimate(_ showWhat: String) {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            if showWhat == "left" {
                self.sideController.view.center = CGPoint(x: self.distanceRightLimit, y: self.sideController.view.center.y)
                self.mainView.center = CGPoint(x: self.screenWidth * 1.2, y: self.mainView.center.y)
                self.mainView.transform = CGAffineTransform.identity.scaledBy(x: 0.7, y: 0.7)
            }else {
                self.sideController.view.center = CGPoint(x: self.distanceLeftLimit, y: self.sideController.view.center.y)
                self.mainView.center = CGPoint(x: self.screenWidth * 0.5, y: self.mainView.center.y)
                self.mainView.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            }
            self.centerOfSideMenu = self.sideController.view.center
            self.centerOfHomeView = self.mainView.center
            
            } , completion: nil)
    }

}

