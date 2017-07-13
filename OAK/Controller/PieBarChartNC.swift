//
//  MyNavigationViewController.swift
//  LandscapePortrateTest
//
//  Created by Mac on 10/02/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class PieBarChartNC: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(MyNavigationViewController.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rotated()
    {
        //print("Bismillah, Its Coming in Rotate Delegate. Complex")
        //adjustViewsForOrientation(orientation: UIApplication.shared.statusBarOrientation)
        self.moveToPortrateOrLandScapeMode()
    }
    
    private func moveToPortrateOrLandScapeMode() -> Void
    {
    
         /*
         Orientation Logic
         
         1. If Current View Controller is Portrate && .current Orientation == LandScape
         Call Push Pop Method
         
         2. If Current View Controller is Landscape && .current orientation == Portrate
         Call Push Pop Method
         
         */
        
        let currentOrientation = UIApplication.shared.statusBarOrientation
        let applicationDelegate = UIApplication.shared.delegate
        let myWindow = ((applicationDelegate?.window)!)! as UIWindow
        let rootController = myWindow.rootViewController as! UITabBarController
        
        if rootController.selectedViewController is PieBarChartNC
        {
            let navigationController = rootController.selectedViewController as! PieBarChartNC
            
            if navigationController.topViewController is PieBarChartVC
            {
                if(currentOrientation == .landscapeLeft || currentOrientation == .landscapeRight)
                {
                    let currentView = navigationController.topViewController as! PieBarChartVC
                    currentView.MoveToNextControllerOnRotationChange()
                }
            }
            else if navigationController.topViewController is PieBarChartVC_LC
            {
                if(currentOrientation == .portrait)
                {
                    let currentView = navigationController.topViewController as! PieBarChartVC_LC
                    currentView.MoveToNextControllerOnRotationChange()
                }
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
