//
//  RecommendViewModel.swift
//  DouYuTest
//
//  Created by jack_tang on 17/1/11.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

 let params = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrenTime()]




class RecommendViewModel{
    // MARK : 请求推荐的数据
    let dGroup = DispatchGroup()
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
    
}

extension RecommendViewModel{

    func loadData(finishCallBack: @escaping () -> ()){
        //加载房间
//        loadRecommonData()
        loadYanZhi()
        loadBigData()
        loadGame()
        dGroup.notify(queue: .main){
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            
            finishCallBack()
      }
    }

}


extension RecommendViewModel{
    
    func loadYanZhi(){
        dGroup.enter()
        NetworkTools.requestHttp(type: .get, params: params, "http://capi.douyucdn.cn/api/v1/getVerticalRoom"){(result : Any) in
            guard let dict = result as? [String:Any] else {
                return
            }
            
            guard let diceArray = dict["data"] as? [[String:Any]] else {
                return
            }
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_url = "home_header_phone"
            
            for dict in diceArray{
                self.prettyGroup.anchors.append(AnchorModel.init(dict: dict))
            }
            self.dGroup.leave()
        }
    }
    
    func loadBigData(){
        dGroup.enter()
        NetworkTools.requestHttp(type: .get, params: params, "http://capi.douyucdn.cn/api/v1/getbigDataRoom"){(result : Any) in
            guard let dict = result as? [String:Any] else {
                return
            }
            
            guard let diceArray = dict["data"] as? [[String:Any]] else {
                return
            }
            
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_url = "home_header_hot"
            
            for dict in diceArray{
                self.bigDataGroup.anchors.append(AnchorModel.init(dict: dict))
            }
            self.dGroup.leave()
        }
    
    }
    
    
    func loadGame(){
        dGroup.enter()
        NetworkTools.requestHttp(type: .get, params: params, "http://capi.douyucdn.cn/api/v1/getHotCate"){(result : Any) in
            guard let dict = result as? [String:Any] else {
                return
            }
            
            guard let diceArray = dict["data"] as? [[String:Any]] else {
                return
            }
            
            for d in diceArray{
               let m = AnchorGroup.init(dict: d)
                if m.anchors.count > 0 {
                    self.anchorGroups.append(m)
                }
              
            }
          
            self.dGroup.leave()
        }
    
    
    }
    
    
    
}
