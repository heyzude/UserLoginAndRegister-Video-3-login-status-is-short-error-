//
//  RegisterPageViewController.swift
//  UserLoginAndRegister
//
//  Created by Hey Jude on 2015. 7. 17..
//  Copyright (c) 2015년 Hey Jude. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func registerButtonTapped(sender: AnyObject) {
        
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        let userRepeatPassword = repeatPasswordTextField.text
        
        // Check for empty fields
        if(userEmail.isEmpty || userPassword.isEmpty || userRepeatPassword.isEmpty)
        {
            // Display alert message 
            displayMyAlertMessage("All fields are required")
            
            return
        }
        
        // Check if passwords match
        if(userPassword != userRepeatPassword)
        {
            // Display an alert message
            displayMyAlertMessage("Passwords do not match")
            
            return
        }
        
        // Store data
        
    
      
        // Send user data to server side
        let myUrl = NSURL(string: "http://www.earthlandia.com/user-register/userRegister.php" )
        let request = NSMutableURLRequest(URL: myUrl!)
        request.HTTPMethod = "POST"
        
        let postString = "email=\(userEmail)&password=\(userPassword)"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        
    
    
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
        {
            data, response, error in
            
            if error != nil {
                println("error=\(error)")
                return
            }
            
            
            
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &err) as? NSDictionary
            
            
            
            if let parseJSON = json {
                var resultValue = parseJSON["Status"] as? String
                println("result: \(resultValue)")
                
                
                var isUserRegistered: Bool = false
                if(resultValue == "Success") { isUserRegistered = true }
                
                var messageToDisplay: String = parseJSON["message"] as! String!
                
                if(!isUserRegistered)
                    {
                    messageToDisplay = parseJSON["message"] as! String!
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    // Display alert message with confirmation
                    
                    var myAlert = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: UIAlertControllerStyle.Alert);
                    
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default)  {
                        action in
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                })
                
                
                }
                
                
            }
            
            task.resume()
            
            
            
            
            
            
    }
    
    
    
    
    func displayMyAlertMessage(userMessage: String)
    {
        var myAlert =  UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title:"OK", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
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
