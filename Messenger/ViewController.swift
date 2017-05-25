//
//  ViewController.swift
//  Messenger
//
//  Created by CHENG-SYUANYU on 2017/5/18.
//  Copyright © 2017年 CHENG-SYUANYU. All rights reserved.
//

import UIKit
import CoreData


class FriendsController: UICollectionViewController,UICollectionViewDelegateFlowLayout{

    private let cellId = "cellId"
    var messages = [Message]()   //[Message]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "最近"
        collectionView?.backgroundColor = UIColor.white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(MessageCell.self, forCellWithReuseIdentifier: cellId)
        
        setupData()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count:Int?=nil
         count = messages.count
            return count!
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let cellId = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath as IndexPath) as UICollectionViewCell
        
        //return cellId
        //swift3
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath as IndexPath)as! MessageCell
        let message = messages[indexPath.item]
            cell.message = message
            return cell
//        if let message = messages[indexPath.item]{
//        cell.message = message
//    }
//    return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:view.frame.width,height:100)  //swift3
    }
 


}
class MessageCell: BaseCell {
    var message: Message?{
        didSet{
            nameLabel.text = message?.friend?.name
            if let profileImageName = message?.friend?.profileImageName{
                profileImageView.image = UIImage(named:profileImageName)
                hasReadImageView.image = UIImage(named:profileImageName)
            }
            messageLabel.text = message?.text
            
            if let date = message?.date{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                timeLabel.text = dateFormatter.string(from: date as Date)
            }
            
        }
    }
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        return imageView
    }()
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white:0.5,alpha:0.5)
        return view
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Trunks"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Your friend's message & something else..."
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        return label
    }()
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "1:15pm"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    let hasReadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    override func setupViews(){
        
        addSubview(profileImageView)
        addSubview(dividerLineView)
        setupContainerView()
        profileImageView.image = UIImage(named:"baby")
        hasReadImageView.image = UIImage(named:"baby")
        /*
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        dividerLineView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[v0(68)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":profileImageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[v0(68)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":profileImageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-82-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":dividerLineView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":dividerLineView]))
        //加入約束
         */
        
        addConstraintsWithFormat(format: "H:|-12-[v0(68)]", views: profileImageView)
        addConstraintsWithFormat(format: "V:[v0(68)]", views: profileImageView)
        addConstraints([NSLayoutConstraint(item: profileImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        addConstraintsWithFormat(format: "H:|-82-[v0]|", views: dividerLineView)
        addConstraintsWithFormat(format: "V:[v0(1)]|", views: dividerLineView)
        
    }
    private func setupContainerView(){
        let containerView = UIView()
        addSubview(containerView)
        
        addConstraintsWithFormat(format: "H:|-90-[v0]|", views: containerView)
        addConstraintsWithFormat(format: "V:[v0(50)]", views: containerView)
        addConstraints([NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        
        containerView.addSubview(nameLabel) //在containerView裡的
        containerView.addSubview(messageLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(hasReadImageView)
        
        addConstraintsWithFormat(format: "H:|[v0][v1(80)]-12-|", views: nameLabel,timeLabel)
        
        addConstraintsWithFormat(format: "V:|[v0][v1(24)]|", views: nameLabel,messageLabel)//共用高
        
        addConstraintsWithFormat(format: "H:|[v0]-8-[v1(20)]-12-|", views: messageLabel,hasReadImageView)
        
        addConstraintsWithFormat(format: "V:|[v0(24)]", views: timeLabel)
        
        addConstraintsWithFormat(format: "V:[v0(20)]|", views: hasReadImageView)
        
    }
}

extension UIView{
    func addConstraintsWithFormat(format:String,views:UIView...){
        var viewsDictionary = [String:UIView]()
        for(index,view) in views.enumerated(){
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat:format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

class BaseCell: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        backgroundColor = UIColor.gray
    }
}

