//
//  FriendsControllerHelper.swift
//  Messenger
//
//  Created by CHENG-SYUANYU on 2017/5/24.
//  Copyright © 2017年 CHENG-SYUANYU. All rights reserved.
//

import UIKit
import CoreData
//class Message: NSManagedObject{
//    var text:String?
//    var date:NSDate?
//    var friend:Friend?
//}
//class Friend: NSManagedObject{
//    var name:String?
//    var profileImageName:String?
//}

extension FriendsController{
    func setupData(){
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.managedObjectContext{
            let Trunks = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context)as! Friend
            
            Trunks.name = "Trunks"
            Trunks.profileImageName = "baby"
        
            let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context)as! Message
            message.friend = Trunks
            message.text = "Hello! i'm a Super Saiyan."
            message.date = NSDate()
        
            let Wutian = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context)as! Friend
            
            Wutian.name = "Wutian"
            Wutian.profileImageName = "wutian"
        
            let messageWutian = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context)as! Message
            messageWutian.friend = Wutian
            messageWutian.text = "Hello! i'm a Super Saiyan,too."
            messageWutian.date = NSDate()
        
            messages = [message,messageWutian]
            }
    }
}
