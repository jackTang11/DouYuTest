//
//  NSDate-Extension.swift
//  DouYuTest
//
//  Created by jack_tang on 17/1/10.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import Foundation

extension NSDate{

    static func getCurrenTime() ->String {
        let nowdate = Date()
        
        let interval = Int(nowdate.timeIntervalSince1970)
    
        return "\(interval)"
    }
}
