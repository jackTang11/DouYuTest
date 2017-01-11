//
//  HomeViewController.swift
//  DouYuTest
//
//  Created by jack_tang on 17/1/5.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {

    
    
    fileprivate lazy var pageTitleView : PageTitleView = {
        
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let frame = CGRect(x: 0, y: kStatusBarH + kNavgationBarH , width: kScreenW, height: kTitleViewH)
        let pageTileView = PageTitleView(frame: frame, isScrollEndable: false, titles: titles)
        pageTileView.delete = self
        return pageTileView
    }()
    
    
    fileprivate lazy var pageContetView : PageCotentView = { [weak self] in
        
        // 1.确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavgationBarH - kTabbarH - kTitleViewH 
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavgationBarH + kTitleViewH, width: kScreenW, height: contentH)
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(UIViewController())
        childVcs.append(UIViewController())
        childVcs.append(UIViewController())

        let pageContetView = PageCotentView(frame: contentFrame, childvs: childVcs, self!)
         pageContetView.delegate = self
        return pageContetView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavgationUI()
    }


}



extension HomeViewController{

    fileprivate func setupNavgationUI(){
        automaticallyAdjustsScrollViewInsets = false
        setLeftBtn()
        setRightUI()
        view.addSubview(self.pageTitleView)
        view.addSubview(self.pageContetView)
     }
    
    
    
    fileprivate func setLeftBtn(){
        let btn = UIButton()
        btn.setImage(UIImage(named:"logo"), for: .normal)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(logoClick), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)

    }
    
    
    fileprivate func setRightUI(){
        
        let size = CGSize(width: 40, height: 40)
        
        
        let historytn =  UIBarButtonItem(imageNamed: "image_my_history", heightImage: "image_my_history_click", self, action: #selector(logoClick), size: size)
        
         let searchtn =  UIBarButtonItem(imageNamed: "btn_search", heightImage: "btn_search_clicked", self, action: #selector(searchClick), size: size)
        
         let qrbtn =  UIBarButtonItem(imageNamed: "Image_scan", heightImage: "Image_scan_click", self, action: #selector(qrCodeClick), size: size)
        

       self.navigationItem.rightBarButtonItems = [qrbtn,searchtn,historytn]
        
    }


}



extension HomeViewController{

   @objc fileprivate func logoClick(){
    
    }
    
    @objc fileprivate func qrClick(){
        
    }
    
    @objc fileprivate func searchClick(){
        
    }
    
    @objc fileprivate func qrCodeClick(){
        
    }

}


extension HomeViewController : PageTitleViewDelete{

    func pageTitleView(_ contentview: PageTitleView, selectIndex intdex: Int) {
        pageContetView.setCurrentIndex(intdex)
    }
}

extension HomeViewController : PageCotentViewdelegate{
    
    func pageCotentView(_ contentview: PageCotentView, progress: CGFloat, sourceIndex: Int, tagetIndex: Int) {
        
        pageTitleView.setTitleProgress(progress, sourceIndex: sourceIndex, tagIndex: tagetIndex)
    }
    
}

