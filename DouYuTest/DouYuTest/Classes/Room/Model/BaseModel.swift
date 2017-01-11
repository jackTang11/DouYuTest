//
//  BaseModel.swift
//  DouYuTest
//
//  Created by jack_tang on 17/1/11.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

class BaseModel: NSObject {

   public init(dict : [String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override init(){}
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
