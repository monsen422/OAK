//
//  ViewController.swift
//  OAK
//
//  Created by MobileDev on 9/8/16.
//  Copyright © 2016 MobileDev. All rights reserved.
//

import UIKit
import AFNetworking

class LoginVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    var overlayView : UIView!
    var activityIndicator : UIActivityIndicatorView!
    
    
    //MARK: - SELF
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        /*
        txtUsername.layer.cornerRadius = 5.0
        txtUsername.backgroundColor = hexStringToUIColor("#f1f2f2")
        txtPassword.layer.cornerRadius = 5.0
        txtPassword.backgroundColor = hexStringToUIColor("#f1f2f2")
        btnLogin.layer.cornerRadius = 5.0
        
        btnLogin.backgroundColor = hexStringToUIColor("#71c18b")
 */
        txtPassword.delegate = self
        txtUsername.delegate = self
        
        
        self.overlayView = UIView()
        self.activityIndicator = UIActivityIndicatorView()
        
        overlayView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        overlayView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        overlayView.layer.zPosition = 1
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        overlayView.addSubview(activityIndicator)
    }
    override func viewWillAppear(_ animated: Bool) {
        txtUsername.text = "dev"
        txtPassword.text = "12345"
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
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
    @IBAction func loginTapped(_ sender: UIButton) {
        
        login()
        
    }
    func login(){
        
//        if (IS_IPAD) {
//            let des = STORYBOARD_MAIN.instantiateViewController(withIdentifier: "HomeVC")
//            self.present(des, animated: true, completion: nil)
//        }
//        else {
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.LoadTabBarHomeController()
//        }
        
        
        let username:String = txtUsername.text!
        let password:String = txtPassword.text!
        
        if ( username.isEmpty || password.isEmpty) {
            
            let alert = UIAlertController(title: "Sorry!", message:"Please enter username and password", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { _ in }
            alert.addAction(action)
            self.present(alert, animated: true){}
        } else {
            loginServer(username, password: password);
        }
 
    }
    func loginServer(_ username:String, password:String){
        self.showLoading()
        
        let parameters = ["username":username, "password":password] as Dictionary<String, String>

        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        manager.post(API_LOGIN, parameters: parameters, progress: { (Progress) in
            
            
        }, success: { (task, responseObject) in
            
            print("RESULT" + "%@",responseObject as Any)
            
            if responseObject != nil {
                
                let json: NSDictionary = responseObject as! NSDictionary
                //success
                let success = json["success"] as? Bool
                if(success == false){
                    let msg =  json["msg"] as? String
                    
                    DispatchQueue.main.async {
                        self.hideLoading()
                        self.showMessage(msg!)
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        self.hideLoading()
                        self.successHandler(json);
                    }
                }
                
            }else {
                
                //Error
             
                self.hideLoading()
                self.showMessage("Network error!")
            }
            
            
            
        }) { (operation, error) in
            
            //Error
            self.hideLoading()
            self.showMessage("Network error!")

        }
        
    
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
    func showMessage(_ msg:String){
        let alert = UIAlertController(title: "Sorry!", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in  }
        alert.addAction(action)
        self.present(alert, animated: true){}
    }
    func successHandler(_ json:NSDictionary){
            let prefs:UserDefaults = UserDefaults.standard
        
            let yearData = NSKeyedArchiver.archivedData(withRootObject: json["years"]!)
            let user_data = json["user_data"] as! NSDictionary
        
            prefs.set(user_data["api_key"], forKey: "API_KEY")
            prefs.set(user_data["avatar"], forKey: "AVATAR")
            prefs.set(user_data["fullname"], forKey: "FULLNAME")
        

        
            prefs.set(yearData, forKey: "YEARS")
            prefs.synchronize()
        
        if (IS_IPAD) {
            let des = STORYBOARD_MAIN.instantiateViewController(withIdentifier: "HomeVC")
            self.present(des, animated: true, completion: nil)
        }
        else {
            /*
            let des = STORYBOARD_MAIN_IPHONE.instantiateViewController(withIdentifier: "BaseTabbarViewController_iphone") as! BaseTabbarViewController_iphone
            self.present(des, animated: true, completion: nil)
 */
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.LoadTabBarHomeController()
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

