//
//  UIBarButtonItem.swift
//  DouYuTest
//
//  Created by jack_tang on 17/1/6.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

extension UIBarButtonItem{

    
    convenience init(imageNamed : String , heightImage : String ,_ target: Any?, action: Selector,size : CGSize) {
        let btn = UIButton()
        btn.setImage(UIImage(named:imageNamed), for: .normal)
        btn.setImage(UIImage(named:heightImage), for: .highlighted)
        btn.sizeToFit()
        btn.frame.size = size
        btn.addTarget(target, action: action, for: .touchUpInside)
       self.init(customView: btn)
      
        
    }
}
