//
//  CollectionPrettyCell.swift
//  DouYuTest
//
//  Created by jack_tang on 17/1/10.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

class CollectionPrettyCell: CollectionBaseCell {
    
    @IBOutlet weak var locationLable: UIButton!
    
   override var item : AnchorModel?{
        didSet{
          super.item = item
            locationLable.setTitle(item?.anchor_city, for: .normal)
        
        }
    }
    
}
