//
//  NetworkTools.swift
//  DouYuTest
//
//  Created by jack_tang on 17/1/10.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType{
    case get
    case post
}


class NetworkTools{


}

extension NetworkTools{
    
    // MARK : 封装的请求方式
    class func requestHttp(type : MethodType ,params : [String : Any]? = nil ,_ url : String ,finishCallBack : @escaping (_ result : Any)->()){
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        
        Alamofire.request(url, method: method, parameters: params).responseJSON { (response) in
            
            guard let result = response.result.value else{
            
                print(response.result.error ?? "网络请求错误")
                return
            }
            
            finishCallBack(result)
        }
    }

}
