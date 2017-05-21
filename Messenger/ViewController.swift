//
//  ViewController.swift
//  Messenger
//
//  Created by CHENG-SYUANYU on 2017/5/18.
//  Copyright © 2017年 CHENG-SYUANYU. All rights reserved.
//

import UIKit

class FriendsController: UICollectionViewController,UICollectionViewDelegateFlowLayout{

    private let cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "最近"
        collectionView?.backgroundColor = UIColor.white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(FriendsCell.self, forCellWithReuseIdentifier: cellId)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath as IndexPath) as UICollectionViewCell
        
        return cellId
        //swift3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:view.frame.width,height:100)  //swift3
    }
 


}
class FriendsCell: BaseCell {
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
    override func setupViews(){
        
        addSubview(profileImageView)
        addSubview(dividerLineView)
        profileImageView.image = UIImage(named:"baby")
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        dividerLineView.translatesAutoresizingMaskIntoConstraints = false
        /*
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[v0(68)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":profileImageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[v0(68)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":profileImageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-82-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":dividerLineView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":dividerLineView]))
        //加入約束
        */
        addConstraintsWithFormat(format: "H:|-12-[v0(68)]|", views: profileImageView)
        addConstraintsWithFormat(format: "V:|-12-[v0(68)]", views: profileImageView)
        addConstraintsWithFormat(format: "H:|-82-[v0]|", views: dividerLineView)
        addConstraintsWithFormat(format: "V:[v0(1)]|", views: dividerLineView)
        
    }
}
extension UIView{
    func addConstraintsWithFormat(format:String,views:UIView...){
        var viewDictionary = [String:UIView]()
        for(index,view) in views.enumerated(){
            let key = "v\(index)"
            viewDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat:format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
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

