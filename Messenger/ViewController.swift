//
//  ViewController.swift
//  Messenger
//
//  Created by CHENG-SYUANYU on 2017/5/18.
//  Copyright © 2017年 CHENG-SYUANYU. All rights reserved.
//

import UIKit

class FriendsController: UICollectionViewController{

    private let cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(FriendsCell.self, forCellWithReuseIdentifier: cellId)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifier", for: indexPath as IndexPath) as UICollectionViewCell
        
        return cellId
    }
 


}
class FriendsCell: UICollectionViewCell {
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

