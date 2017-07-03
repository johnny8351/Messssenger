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
    
    func clearData(){
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.managedObjectContext{
            do{
                let entityNames = ["Friend","Message"]
                
                for entityName in entityNames{
                    
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:entityName)
                    let objects = try (context.fetch(fetchRequest) as? [NSManagedObject])
                    
                    for object in objects!{
                        context.delete(object)
                    }
                }
              
                try context.save()
            }catch let err{
                print(err)
            }
        }

    }
    private func createMessageWithText(text:String,friend:Friend,minuteAgo:Double,context:NSManagedObjectContext){
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context)as! Message
        message.friend = friend
        message.text = text
        message.date = NSDate().addingTimeInterval(-minuteAgo * 60)
    }
    func setupData(){
        
        clearData()
        
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
        
//            let messageWutian = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context)as! Message
//            messageWutian.friend = Wutian
//            messageWutian.text = "Hello! i'm a Super Saiyan,too."
//            messageWutian.date = NSDate()
            createMessageWithText(text: "Nice to meet you.", friend: Wutian,minuteAgo: 6, context: context)
            createMessageWithText(text: "Nice to meet you.", friend: Wutian,minuteAgo: 3, context: context)
            createMessageWithText(text: "Nice to meet you.", friend: Wutian,minuteAgo: 1, context: context)
            
            let Frieza = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context)as! Friend
            Frieza.name = "Frieza"
            Frieza.profileImageName = "Frieza"
            createMessageWithText(text: "I wii kill you.", friend: Frieza,minuteAgo: 5, context: context)
            
            do{
                try(context.save())
            }catch let err{
                print(err)
            }
            //messages = [message,messageWutian]
        }
        loadData()
//        print(delegate?.applicationDocumentsDirectory as Any)
//        print(Bundle.main.url(forResource: "fbMessenger", withExtension: "momd")as Any)
//        一個是sql、一個是datamodel存放在不同位置
        
    }
    func loadData(){
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.managedObjectContext{
            
            if let friends = fetchFriends(){
                messages = [Message]()
                
                for friend in friends{
                    print(friend.name as Any)
                    
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Message")
                    fetchRequest.sortDescriptors = [NSSortDescriptor(key:"date",ascending:false)]  //排序：依據時間
                    fetchRequest.predicate = NSPredicate(format:"friend.name = %@",friend.name!)  //斷定只顯示Wutian
                    fetchRequest.fetchLimit = 1                                                //只顯示一行 的最後留言
                    
                    do{
                        let fetchMessages = try(context.fetch(fetchRequest)) as! [Message] //顯示所有的message
                        messages.append(contentsOf: fetchMessages)
                    }catch let err{
                        print(err)
                    }
                }
                
                messages = messages.sorted(by: {$0.date!.compare($1.date! as Date) == .orderedDescending})
                //swift 3.0
            }
        }
    }
    private func fetchFriends()->[Friend]?{
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.managedObjectContext{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Friend")
            do{
                return try context.fetch(request) as? [Friend]
            }catch let err{
                print(err)
            }
        }
        return nil
    }
}
