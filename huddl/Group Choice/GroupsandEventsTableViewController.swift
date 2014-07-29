//
//  GroupsandEventsTableViewController.swift
//  Group Choice
//
//  Created by Daniel Borstelmann on 7/27/14.
//  Copyright (c) 2014 BorstelDiz Enterprises. All rights reserved.
//

import UIKit


let darkGrayColor:UInt = 0x757575
//let blueColor:UInt = 0x548bac
let darkBlueColor:UInt = 0x053162
let lightBlueColor:UInt = 0x0577FE
let mediumBlueColor:UInt = 0x084387
//let darkDarkBlueColor:UInt = 0x222D4A
let orangeColor:UInt = 0xFFB700
let redColor:UInt = 0xFF4B66
let lightGrayColor:UInt = 0xE3E3E3
let white:UInt = 0xffffff
let black:UInt = 0x000000

var groupList:Array = []

class GroupsandEventsTableViewController: UITableViewController {
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Groups"
        
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tabBarController.tabBar.selectedImageTintColor = UIColorFromRGB(orangeColor)
        
        var b = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: "logOut")
        b.tintColor = UIColorFromRGB(white)
        self.navigationItem.leftBarButtonItem = b
        
        var group1: groupManager = groupManager(gName: "The Chill Bros")
        group1.addEvent("Friday at 6", desc: "Hangout", keys: ["beer", "drunk", "pizza"])
        group1.addName("Beth")
        group1.addName("Andres")
        group1.addName("Dan")
        group1.addName("Heather")
        group1.addName("Darius")
        group1.needVote = true
        group1.haveChat = true
        
        var group2: groupManager = groupManager(gName: "Everyone Else")
        group2.addEvent("Saturday at Noon", desc: "Let's Party all Night", keys: ["beer", "drunk", "pizza"])
        group2.addEvent("Saturday at Noon", desc: "Hangout", keys: ["beer", "drunk", "pizza"])
        group2.addName("Andres")
        group2.addName("Dan")
        group2.addName("Darius")
        group2.needVote = true
        group2.haveChat = false
        
        var group3: groupManager = groupManager(gName: "The Crew")
        group3.addEvent("Friday at 3", desc: "Go out somewhere", keys: ["beer", "drunk", "pizza", "girls", "free", "tacos"])
        group3.addEvent("Saturday Morning", desc: "Breakfest", keys: ["eggs", "bacon", "mimosas"])
        group3.addName("Andres")
        group3.addName("Dan")
        group3.addName("Darius")
        group3.needVote = false
        group3.haveChat = true
        
        var group4: groupManager = groupManager(gName: "Da Boyz")
        group4.addEvent("Thirsty Thursday", desc: "Hit the Bars!", keys: ["beer", "cheap", "girls", "girls", "dancing", "pool"])
        group4.addName("Andres")
        group4.addName("Darius")
        group4.needVote = false
        group4.haveChat = false
        
        var group5: groupManager = groupManager(gName: "College Buds")
        group5.addEvent("Wednesday Night", desc: "bored", keys: ["movies", "concerts", "entertainment", "music"])
        group5.addName("Andres")
        group5.addName("Dan")
        group5.addName("Darius")
        group5.needVote = false
        group5.haveChat = true
        
        var group6: groupManager = groupManager(gName: "Homies")
        group6.addEvent("Tonight", desc: "Let's Rage", keys: ["movies", "concerts", "entertainment", "music"])
        group6.addName("Andres")
        group6.addName("Dan")
        group6.needVote = true
        group6.haveChat = false
        
        groupList.append(group1)
        groupList.append(group2)
        groupList.append(group3)
        groupList.append(group4)
        groupList.append(group5)
        groupList.append(group6)
        
        tableView.backgroundColor = UIColorFromRGB(mediumBlueColor)
        
        var a = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addHit")
        a.tintColor = UIColorFromRGB(white)
        
        self.navigationItem.rightBarButtonItem = a
    }
    
    func addHit() {
        FBRequestConnection.startWithGraphPath("/me/friendlists", parameters: nil, HTTPMethod: "GET", {(connection: FBRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            println(result)
            })
    }
    
    func logOut() {
        println("hello")
        FBSession.activeSession().closeAndClearTokenInformation()
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return groupList.count
    }
    
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 90;
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "\(indexPath.row)")
        
        var g: groupManager = groupList[indexPath.row] as groupManager
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColorFromRGB(lightBlueColor)
        }
        else {
            cell.backgroundColor = UIColorFromRGB(darkBlueColor)
        }
        
        //GROUP NAME
        var title: UILabel = UILabel(frame: CGRectMake(10, 10, 180, 36))
        title.textAlignment = NSTextAlignment.Left
        title.text = g.groupName
        title.textColor = UIColorFromRGB(white)
        title.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        cell.addSubview(title)
        
        //NEXT EVENT ICON
        var nextImage: UIImageView = UIImageView(image: UIImage(named: "nextEvent"))
        nextImage.frame = CGRectMake(10, 55, 20, 20)
        nextImage.contentMode = UIViewContentMode.ScaleAspectFit
        cell.addSubview(nextImage)
        
        //NEXT EVENT DATE
        var nextStep: UILabel = UILabel(frame: CGRectMake(36, 65, 150, 15))
        nextStep.textAlignment = NSTextAlignment.Left
        nextStep.text = "\(g.events[0].dateTime)"
        if indexPath.row % 2 == 0 {
            nextStep.textColor = UIColorFromRGB(darkBlueColor)
        }
        else {
            nextStep.textColor = UIColorFromRGB(lightBlueColor)
        }
        nextStep.font = UIFont(name: "HelveticaNeue", size: 11)
        cell.addSubview(nextStep)
        
        //NEXT EVENT DESCRIPTION
        var desc: UILabel = UILabel(frame: CGRectMake(36, 50, 150, 15))
        desc.textAlignment = NSTextAlignment.Left
        desc.text = "\(g.events[0].description)"
        desc.textColor = UIColorFromRGB(orangeColor)
        desc.font = UIFont(name: "HelveticaNeue", size: 12)
        cell.addSubview(desc)
        
        //CHAT ICON
        if g.haveChat == true {
            var chatImage: UIImageView = UIImageView(image: UIImage(named: "Chat"))
            chatImage.frame = CGRectMake(275, 10, 20, 20)
            chatImage.contentMode = UIViewContentMode.ScaleAspectFit
            cell.addSubview(chatImage)
        }
        
        //VOTE ICON
        if g.needVote == true {
            var voteImage: UIImageView = UIImageView(image: UIImage(named: "Vote"))
            voteImage.frame = CGRectMake(215, 10, 20, 20)
            voteImage.contentMode = UIViewContentMode.ScaleAspectFit
            cell.addSubview(voteImage)
        }

        
        //FRIENDS ICON
        var peepsImage: UIImageView = UIImageView(image: UIImage(named: "Friends"))
        peepsImage.frame = CGRectMake(270, 40, 30, 30)
        peepsImage.contentMode = UIViewContentMode.ScaleAspectFit
        cell.addSubview(peepsImage)
        
        //NUM FRIENDS
        var peeps: UILabel = UILabel(frame: CGRectMake(260, 70, 50, 20))
        peeps.textAlignment = NSTextAlignment.Center
        peeps.text = "\(g.names.count) Friends"
        if g.names.count == 1 {
            peeps.text = "\(g.names.count) Friend"
        }
        else {
            peeps.text = "\(g.names.count) Friends"
        }
        peeps.textColor = UIColorFromRGB(white)
        peeps.font = UIFont(name: "HelveticaNeue", size: 11)
        cell.addSubview(peeps)
        
        //EVENTS ICON
        var evsImage: UIImageView = UIImageView(image: UIImage(named: "Events"))
        evsImage.frame = CGRectMake(210, 40, 30, 30)
        evsImage.contentMode = UIViewContentMode.ScaleAspectFit
        cell.addSubview(evsImage)
        
        //NUM EVENTS
        var evs: UILabel = UILabel(frame: CGRectMake(200, 70, 50, 20))
        evs.textAlignment = NSTextAlignment.Center
        if g.events.count == 1 {
            evs.text = "\(g.events.count) Event"
        }
        else {
            evs.text = "\(g.events.count) Events"
        }
        evs.textColor = UIColorFromRGB(white)
        evs.font = UIFont(name: "HelveticaNeue", size: 11)
        cell.addSubview(evs)
        
        return cell
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var newView:IndivGroup = IndivGroup()
        self.navigationController.pushViewController(newView, animated: true)
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
