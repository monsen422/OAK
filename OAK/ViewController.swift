//
//  ViewController.swift
//  OAK
//
//  Created by Pham Minh Vu (Jason) on 9/8/16.
//  Copyright © 2016 Pham Minh Vu (Jason). All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    var overlayView : UIView!
    var activityIndicator : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        txtUsername.layer.cornerRadius = 5.0
        txtUsername.backgroundColor = hexStringToUIColor("#f1f2f2")
        txtPassword.layer.cornerRadius = 5.0
        txtPassword.backgroundColor = hexStringToUIColor("#f1f2f2")
        btnLogin.layer.cornerRadius = 5.0
        
        btnLogin.backgroundColor = hexStringToUIColor("#71c18b")
        txtPassword.delegate = self
        txtUsername.delegate = self
        
        
        self.overlayView = UIView()
        self.activityIndicator = UIActivityIndicatorView()
        
        overlayView.frame = CGRectMake(0, 0, 80, 80)
        overlayView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        overlayView.layer.zPosition = 1
        
        activityIndicator.frame = CGRectMake(0, 0, 20, 20)
        activityIndicator.center = CGPointMake(overlayView.bounds.width / 2, overlayView.bounds.height / 2)
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        overlayView.addSubview(activityIndicator)
    }
    override func viewWillAppear(animated: Bool) {
        txtUsername.text = ""
        txtPassword.text = ""
    }
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        
        textField.resignFirstResponder()
        login()
        return true;
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBAction func loginTapped(sender: UIButton) {
        
        login()
        
    }
    func login(){
        let username:String = txtUsername.text!
        let password:String = txtPassword.text!
        
        if ( username.isEmpty || password.isEmpty) {
            
            let alert = UIAlertController(title: "Sorry!", message:"Please enter username and password", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default) { _ in }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
        } else {
            loginServer(username, password: password);
        }
    }
    func loginServer(username:String, password:String){
        self.showLoading()
        
        
        let url: NSURL = NSURL(string: "http://50.28.18.133:8051/api/user/login")!
        let request:NSMutableURLRequest = NSMutableURLRequest(URL:url)
        request.HTTPMethod = "POST"
        //create dictionary with your parameters
        let params = ["username":username, "password":password] as Dictionary<String, String>
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            //let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
           
            
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    let success = json["success"] as? Bool
                    if(success == false){
                        let msg =  json["msg"] as? String
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            self.hideLoading()
                            self.showMessage(msg!)
                        }

                    }else{
                        dispatch_async(dispatch_get_main_queue()) {
                            self.hideLoading()
                            self.successHandler(json);
                        }
                    }
                } else {
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)    // No error thrown, but not NSDictionary
                    print("Error could not parse JSON: \(jsonStr)")
                    self.hideLoading()
                    self.showMessage("Network error!")
                }
            } catch let parseError {
                print(parseError)                                                          // Log the error thrown by `JSONObjectWithData`
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
                self.hideLoading()
                self.showMessage("Network error!")
            }
        })
        
        task.resume()
    }
    func showLoading(){
        overlayView.center = view.center
        view.addSubview(overlayView)
        activityIndicator.startAnimating()

    }
    func hideLoading(){
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
    func showMessage(msg:String){
        let alert = UIAlertController(title: "Sorry!", message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default) { _ in  }
        alert.addAction(action)
        self.presentViewController(alert, animated: true){}
    }
    func successHandler(json:NSDictionary){
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
            let yearData = NSKeyedArchiver.archivedDataWithRootObject(json["years"]!)
            prefs.setObject(json["user_data"]!["api_key"], forKey: "API_KEY")
            prefs.setObject(json["user_data"]!["avatar"], forKey: "AVATAR")
            prefs.setObject(json["user_data"]!["fullname"], forKey: "FULLNAME")
        
            //prefs.setObject(json["user_data"]!["firstname"], forKey: "FIRSTNAME")
            //prefs.setObject(json["user_data"]!["lastname"], forKey: "LASTNAME")
        
            prefs.setObject(yearData, forKey: "YEARS")
            prefs.synchronize()
        
            self.performSegueWithIdentifier("goto_home", sender: self)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

