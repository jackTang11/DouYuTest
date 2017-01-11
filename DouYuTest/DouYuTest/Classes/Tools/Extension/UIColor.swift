//
//  UIColor.swift
//  DouYuTest
//
//  Created by jack_tang on 17/1/6.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

extension UIColor{

    convenience init(r : CGFloat ,g :CGFloat ,b : CGFloat ) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        
    }
    
    class func randomColor() -> UIColor{
        
       return UIColor(r: CGFloat(arc4random_uniform(256)), g:  CGFloat(arc4random_uniform(256)), b:  CGFloat(arc4random_uniform(256)))
    }

}
