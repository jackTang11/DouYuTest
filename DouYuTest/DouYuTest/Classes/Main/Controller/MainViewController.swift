//
//  MainViewController.swift
//  DouYuTest
//
//  Created by jack_tang on 17/1/5.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
   var arrayController = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

}

extension MainViewController{

    fileprivate func setUI(){
        
        
        let homeVc = HomeViewController()
        homeVc.tabBarItem.title = "首页"
        homeVc.tabBarItem.image = UIImage(named: "btn_home_normal");
        homeVc.tabBarItem.selectedImage = UIImage(named: "btn_home_selected");
        arrayController.append( UINavigationController(rootViewController:homeVc))
        
        
        let liveVc = LiveViewController()
        liveVc.tabBarItem.title = "直播"
        liveVc.tabBarItem.image = UIImage(named: "btn_column_normal");
        liveVc.tabBarItem.selectedImage = UIImage(named: "btn_column_selected");
        arrayController.append( UINavigationController(rootViewController:liveVc))
        
        let followVc = FollowViewController()
        followVc.tabBarItem.title = "关注"
        followVc.tabBarItem.image = UIImage(named: "btn_live_normal");
        followVc.tabBarItem.selectedImage = UIImage(named: "btn_live_selected");
        arrayController.append( UINavigationController(rootViewController:followVc))
        
        let profileVc = ProfileViewController()
        profileVc.tabBarItem.title = "我的"
        profileVc.tabBarItem.image = UIImage(named: "btn_user_normal");
        profileVc.tabBarItem.selectedImage = UIImage(named: "btn_user_selected");
        arrayController.append( UINavigationController(rootViewController:profileVc))
        self.viewControllers = arrayController
        
    }
}
