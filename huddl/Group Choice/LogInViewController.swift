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
    @IBOutlet var logInButton: UIButton!
    
    var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if PFFacebookUtils.isLinkedWithUser(PFUser.currentUser()) {
            self.performSegueWithIdentifier("loggedIn", sender: self)
        }
        
        logInButton.backgroundColor = GroupsandEventsTableViewController().UIColorFromRGB(facebookBlue)
        logInButton.layer.cornerRadius = 4

        back.backgroundColor = GroupsandEventsTableViewController().UIColorFromRGB(orangeColor)
        back.alpha = 0.7
        back.layer.cornerRadius = 50
        
        huddl.textColor = GroupsandEventsTableViewController().UIColorFromRGB(mediumBlueColor)
        
        
        self.navigationItem.setHidesBackButton(true, animated: false)
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logIn(sender: AnyObject) {
        var permissionsArray: NSArray = ["public_profile", "read_friendlists", "user_friends"]
        
        PFFacebookUtils.logInWithPermissions(permissionsArray, {
            (user: PFUser!, error: NSError!) -> Void in
            if !user {
                NSLog("Uh oh. The user cancelled the Facebook login.")
            } else if user.isNew {
                NSLog("User signed up and logged in through Facebook!")
                self.performSegueWithIdentifier("loggedIn", sender: self)
            } else {
                NSLog("User logged in through Facebook!")
                self.performSegueWithIdentifier("loggedIn", sender: self)
            }
            })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
