//
//  ViewController.swift
//  UserLoginAndRegister
//
//  Created by Hey Jude on 2015. 7. 17..
//  Copyright (c) 2015년 Hey Jude. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIN")
        
        if(!isUserLoggedIn)
        {
        
        self.performSegueWithIdentifier("loginView", sender: self)
        }
    }

    @IBAction func logoutButtonTapped(sender: AnyObject) {
        
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIN")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        self.performSegueWithIdentifier("loginView", sender: self)
    }

}

