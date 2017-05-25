//
//  Message+CoreDataProperties.swift
//  Messenger
//
//  Created by CHENG-SYUANYU on 2017/5/25.
//  Copyright © 2017年 CHENG-SYUANYU. All rights reserved.
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var text: String?
    @NSManaged public var friend: Friend?

}
