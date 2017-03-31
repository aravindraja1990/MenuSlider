//
//  ContainerViewController.swift
//  MenuSlider
//
//  Created by aravind raja on 8/25/16.
//  Copyright © 2016 aravind raja. All rights reserved.
//Added new comment
//

import UIKit

class ContainerViewController: UIViewController, SliderNavigationProtocol {
    //Set the Menu State
    var menuState  = MenuState.collapsed
    //Create properties for container view controllers
     var centerViewController : CenterViewController?{
        didSet{
            centerViewController?.delegate = self
        }
    }
    
    //Dynamically assign navigation controller based on the selected menu
     var centerNavigationController : UINavigationController?{
        didSet{
            //TODO clear any old value if any
            if (centerNavigationController != nil){
                centerViewController = centerNavigationController?.viewControllers.first as?CenterViewController
                centerViewController?.index = 0
            }

        }
    }
    
    
    lazy var leftPanelViewController: LeftMenuTableViewController? = {
        //Get instance of left panel table view
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let leftVC = storyBoard.instantiateViewController(withIdentifier: "leftPanelViewController") as? LeftMenuTableViewController
        leftVC?.delegate = self
        return leftVC
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerNavigationController = self.childViewControllers.first as? UINavigationController
        //Load the initial view controller and set it as navigation controller's rootview controller
    }
    
    
    //Toggle Function for sliding
    func toggleLeftMenu (sender:AnyObject,userInfo:[String:AnyObject]?)
    {        //Perform actual toggle here after checking the state
        if menuState == .collapsed{
            //Add the leftPanelViewController as Child View Controller and perform animation
            if let vc = leftPanelViewController{

                view.insertSubview(vc.view, at: 0)
                self.addChildViewController(vc)
                vc.didMove(toParentViewController: self)
                //Get the index and assign the center navigation controller
                //Add the new navigation controller based on the index
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions(), animations: {
                    
                    self.centerNavigationController!.view.frame.origin.x = self.centerNavigationController!.view.frame.width-80
                    self.menuState = .leftMenu
                    }, completion: nil)
                
            }
        }else{
            //Slide in and destroy
            leftPanelViewController?.willMove(toParentViewController: nil)
            leftPanelViewController?.view.removeFromSuperview()
            leftPanelViewController?.removeFromParentViewController()
            //Get the index and assign the center navigation controller
            if let info = userInfo{
                leftPanelViewController?.index = info["menuIndex"] as? Int
                if let index = info["menuIndex"] as? Int , index == 1{
                    self.removeChildViewControllerFromContainer(centerNavigationController!)
                    centerNavigationController = UIStoryboard.navigationController("secondNavigationController")
                    self.addChildViewControllerInContainer(centerNavigationController!)
                }else{
                    self.removeChildViewControllerFromContainer(centerNavigationController!)
                    centerNavigationController = UIStoryboard.navigationController("firstNavigationController")
                    self.addChildViewControllerInContainer(centerNavigationController!)

                }
            }

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions(), animations: {
                self.centerNavigationController!.view.frame.origin.x = CGRect.zero.origin.x
                self.menuState = .collapsed
                }, completion: nil)
        }

        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}

extension UIStoryboard{
    class func navigationController(_ identifier:String)->UINavigationController?{
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier: identifier) as? UINavigationController
    }
}

extension UIViewController{
    func removeChildViewControllerFromContainer(_ controller:UIViewController){
        controller.willMove(toParentViewController: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParentViewController()
    }
    
    func addChildViewControllerInContainer(_ controller:UIViewController){
        self.view.addSubview(controller.view)
        self.addChildViewController(controller)
        controller.didMove(toParentViewController: self)
    }
    
}
