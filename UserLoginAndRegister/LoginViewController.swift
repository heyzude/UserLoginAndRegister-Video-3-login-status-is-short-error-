//
//  LoginViewController.swift
//  UserLoginAndRegister
//
//  Created by Hey Jude on 2015. 7. 17..
//  Copyright (c) 2015년 Hey Jude. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        
        if(userEmail.isEmpty || userPassword.isEmpty)
        {
            return
        }
        
        // Send user data to server side
        let myUrl = NSURL(string: "http://www.earthlandia.com/user-register/userLogin.php")
        let request = NSMutableURLRequest(URL: myUrl!)
        request.HTTPMethod = "POST"
        
        let postString = "email=\(userEmail)&password=\(userPassword)"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                println("error=(error)")
                return
            }
            
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &err) as? NSDictionary
            
            
            
            if let parseJSON = json {
                var resultValue: String = parseJSON["status"] as! String!
                println("result: \(resultValue)")
                
                if(resultValue == "Success")
                {
                    // Login is successfull
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
            
        }
        
        task.resume()
        
    }

    
}
