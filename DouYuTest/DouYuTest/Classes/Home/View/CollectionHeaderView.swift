//
//  CollectionHeaderView.swift
//  DouYuTest
//
//  Created by jack_tang on 17/1/10.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionHeaderView: UICollectionReusableView {


    @IBOutlet weak var moreBnt: UIButton!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    
    var anch : AnchorGroup?{
    
        didSet{
        
            titleLable.text = anch?.tag_name
            let url = URL(string: anch?.icon_url ?? "")
            
        iconImage.kf.setImage(with: url, placeholder: UIImage(named: "home_header_normal"))
        }
    
    }
    
}


extension CollectionHeaderView{

 
}
