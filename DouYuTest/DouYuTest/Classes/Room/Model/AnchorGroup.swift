//
//  AnchorGroup.swift
//  DouYuTest
//
//  Created by jack_tang on 17/1/11.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

class AnchorGroup: BaseModel {

     var  tag_name :String = ""
    var  icon_url :String = "home_header_normal"
    var  tag_id :String = ""
    
    
    
    lazy var anchors = [AnchorModel]()
    var  room_list : [[String:NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for model in room_list{
                anchors.append(AnchorModel.init(dict:model))
            }

        }
    }

}
