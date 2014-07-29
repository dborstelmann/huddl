//
//  LogInViewController.swift
//  Group Choice
//
//  Created by Daniel Borstelmann on 7/27/14.
//  Copyright (c) 2014 BorstelDiz Enterprises. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, FBLoginViewDelegate {

    //@IBOutlet weak var backView: UIView!
    @IBOutlet weak var huddl: UILabel!
    @IBOutlet weak var back: UIView!
    @IBOutlet weak var logInFB: FBLoginView!
    
    var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if FBSession.activeSession().isOpen {
            println("LOGGED IN")
            self.performSegueWithIdentifier("loggedIn", sender: self)
        }
        
        logInFB.delegate = self
        logInFB.readPermissions = ["user_friends", "read_friendlists", "manage_friendslists"]

        back.backgroundColor = GroupsandEventsTableViewController().UIColorFromRGB(orangeColor)
        back.alpha = 0.7
        back.layer.cornerRadius = 50
        
        huddl.textColor = GroupsandEventsTableViewController().UIColorFromRGB(mediumBlueColor)
        
        
        self.navigationItem.setHidesBackButton(true, animated: false)

        
        
        
//        if PFFacebookUtils.isLinkedWithUser(PFUser.currentUser()) {
//            self.navigationController.performSegueWithIdentifier("loggedIn", sender: self)
//        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
        if FBSession.activeSession().isOpen {
            println("LOGGED IN")
            self.performSegueWithIdentifier("loggedIn", sender: self)
        }
    }
    
//    @IBAction func logIn(sender: AnyObject) {
//        var permissionsArray: NSArray = ["user_about_me", "user_relationships", "user_birthday", "user_location"]
//        
//        PFFacebookUtils.logInWithPermissions(permissionsArray, {
//            (user: PFUser!, error: NSError!) -> Void in
//            if !user {
//                NSLog("Uh oh. The user cancelled the Facebook login.")
//            } else if user.isNew {
//                NSLog("User signed up and logged in through Facebook!")
//                self.navigationController.performSegueWithIdentifier("loggedIn", sender: self)
//            } else {
//                NSLog("User logged in through Facebook!")
//                self.navigationController.performSegueWithIdentifier("loggedIn", sender: self)
//            }
//            })
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
