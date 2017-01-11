//
//  PageCotentView.swift
//  DouYuTest
//
//  Created by jack_tang on 17/1/6.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

private let COLLECTION_CELL = "COLLECTION_CELL"

protocol PageCotentViewdelegate : class{
    func pageCotentView(_ contentview : PageCotentView, progress : CGFloat,sourceIndex : Int,tagetIndex : Int)
}


class PageCotentView: UIView {

    
   fileprivate var childvs : [UIViewController]
   fileprivate var paramentViewControlller : UIViewController
   fileprivate var startOffsetX : CGFloat = 0
   fileprivate var isForbidScrollDelegate : Bool = false
   weak var delegate : PageCotentViewdelegate?
   
    
    
    fileprivate lazy var collection : UICollectionView = { [weak self] in
        
        var layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = (self?.bounds.size)!
        layout.scrollDirection = .horizontal
    
        var collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.bounces = false
        collection.dataSource = self
        collection.delegate = self
        collection.scrollsToTop = false
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: COLLECTION_CELL)
        
        return collection
    }()
    
    
    init(frame :CGRect , childvs : [UIViewController] ,_ paramentViewControlller : UIViewController){
        self.childvs = childvs
        self.paramentViewControlller = paramentViewControlller
     
        super.init(frame: frame)
        
        setUI()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}



extension PageCotentView {

    func setUI(){
        for child in childvs{
          paramentViewControlller.addChildViewController(child)
        }
        
        addSubview(collection)
        collection.frame = bounds
    }


}

extension PageCotentView : UICollectionViewDataSource{
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return  childvs.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
     let collectionCell =  collectionView.dequeueReusableCell(withReuseIdentifier: COLLECTION_CELL, for: indexPath)
       
        
        for view in collectionCell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let childview = childvs[indexPath.item]
        childview.view.frame = collectionCell.contentView.bounds
        collectionCell.addSubview(childview.view)
        return collectionCell
        
    }

}


extension PageCotentView : UICollectionViewDelegate{

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 0.判断是否是点击事件
        if isForbidScrollDelegate { return }
        
        // 1.定义获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        // 2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { // 左滑
            // 1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childvs.count {
                targetIndex = childvs.count - 1
            }
            
            // 4.如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        } else { // 右滑
            // 1.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childvs.count {
                sourceIndex = childvs.count - 1
            }
        }
        
         // 3.将progress/sourceIndex/targetIndex传递给titleView
        delegate?.pageCotentView(self, progress: progress, sourceIndex: sourceIndex, tagetIndex: targetIndex)
        
    }
}


extension PageCotentView{

    func setCurrentIndex(_ current : Int) {
        isForbidScrollDelegate = true
        
      let offsetX =  CGFloat(current) * collection.frame.width
     collection.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
    
    }

}




