//
//  CollectionBaseCell.swift
//  DouYuTest
//
//  Created by jack_tang on 17/1/11.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var bigImage: UIImageView!
    
    @IBOutlet weak var onlineLable: UIButton!
    
    @IBOutlet weak var nameLable: UILabel!
    
    var item : AnchorModel?{
        didSet{
            nameLable.text = item?.nickname
            let number = Int((item?.online)!)
            
            onlineLable.setTitle("\(number)在线", for: .normal)
            let url = URL(string: item?.vertical_src ?? "")
            bigImage.kf.setImage(with: url, placeholder: UIImage(named: "Img_default"))
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bigImage.layer.cornerRadius = 5
        bigImage.layer.masksToBounds = true
        
    }
    
}
