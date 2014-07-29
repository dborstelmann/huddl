//
//  groupManager.swift
//  Group Choice
//
//  Created by Daniel Borstelmann on 7/27/14.
//  Copyright (c) 2014 BorstelDiz Enterprises. All rights reserved.
//

import UIKit

struct event {
    var description = "Blank"
    var dateTime = "Date"
    var keywords = ["Blank"]

}
struct name {
    var name = "Unnamed"
}

class groupManager: NSObject {
    var groupName = "blank"
    var needVote = false
    var haveChat = false
    
    init(gName: NSString) {
        self.groupName = gName
    }
    
    var events = [event]()
    var names = [name]()
    
    func addEvent(date: NSString, desc: NSString, keys: NSArray) {
        events.append(event(description: desc, dateTime: date, keywords: keys as Array))
    }
    
    func addName(newName: NSString) {
        names.append(name(name: newName))
    }


}
