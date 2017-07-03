//
//  ChatLogController.swift
//  Messenger
//
//  Created by CHENG-SYUANYU on 2017/7/3.
//  Copyright © 2017年 CHENG-SYUANYU. All rights reserved.
//

import UIKit
class ChatLogController: UICollectionViewController,UICollectionViewDelegateFlowLayout{
    private let cellId = "cellId"
    var messages = [Message]()
    var friend: Friend?{
        didSet{
            navigationItem.title = friend?.name//顯示navigation標題，對應friend.name
            messages = friend?.message?.allObjects as! [Message]
            messages = messages.sorted(by: {$0.date!.compare($1.date! as Date) == .orderedAscending})
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ChatLogMessageCell.self, forCellWithReuseIdentifier: cellId)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count:Int?=nil
        count = messages.count
        return count!
//        if let count = messages.count{
//            return count
//        }
//        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath as IndexPath)as! ChatLogMessageCell
        cell.messageTextView.text = messages[indexPath.item].text
        return cell
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:view.frame.width,height:100)
        }
}
class ChatLogMessageCell: BaseCell{
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.text = "test"
        return textView
    }()
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIColor.darkGray
            addSubview(messageTextView)
            addConstraintsWithFormat(format: "H:|[v0]|", views: messageTextView)
            addConstraintsWithFormat(format: "V:|[v0]|", views: messageTextView)
    }
}
