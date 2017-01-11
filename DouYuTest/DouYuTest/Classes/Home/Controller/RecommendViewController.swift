//
//  RecommendViewController.swift
//  DouYuTest
//
//  Created by jack_tang on 17/1/9.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit

//private let kItemMargin : CGFloat = 10
//private let kItemW :CGFloat = (kScreenW - kItemMargin * 3 )/2
//private let kNormalItemH : CGFloat = kItemW * 3 / 4
//private let kPrettyItemH : CGFloat = kItemW * 4 / 3
//private let kHeaderViewH : CGFloat = 50


private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

private let kPrettyCellID = "kPrettyCellID"
private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH : CGFloat = kItemW * 3 / 4
private let kPrettyItemH : CGFloat = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 40

class RecommendViewController: UIViewController {
    
    
    fileprivate lazy var recommonVM = RecommendViewModel()
    
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = kItemMargin
        layout.minimumInteritemSpacing = kItemMargin
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 10, left: kItemMargin, bottom: 10, right: kItemMargin)
        layout.scrollDirection = .vertical
    
        let collection = UICollectionView(frame:self.view.bounds, collectionViewLayout: layout)
       
        collection.dataSource = self
        collection.delegate = self
        collection.autoresizingMask = [.flexibleHeight , .flexibleHeight]
        
        //注册普通的cell
       // collection.register(CollectionNormalCell.self, forCellWithReuseIdentifier: kNormalCellID)
        collection.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        //注册特殊cell
       //collection.register(CollectionPrettyCell.self, forCellWithReuseIdentifier: kPrettyCellID)
        collection.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        
        collection.backgroundColor = UIColor.white
        //注册头部
        collection.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                                                                                                withReuseIdentifier: kHeaderViewID)
        
        return collection
    
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        loadData()
    }

    
}


extension RecommendViewController : UICollectionViewDataSource  {

  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
    
        let anch = recommonVM.anchorGroups[section]
        
        return anch.anchors.count
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return recommonVM.anchorGroups.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
       let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
         let anch = recommonVM.anchorGroups[indexPath.section]
        
        header.anch = anch
        return header
    }
    
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
       let anch =  recommonVM.anchorGroups[indexPath.section]
        let item =  anch.anchors[indexPath.item]
        
        
          if(indexPath.section == 0){
          let  cell =  collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
            cell.item = item
            return cell
        }else{
          let  cell =  collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
             cell.item = item
            return cell
        }
       
    }
    
}


extension RecommendViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if(indexPath.section == 1){
          return CGSize(width: kItemW, height: kPrettyItemH)
        }else{
          return CGSize(width: kItemW, height: kNormalItemH)
        }
    }

}


 // MARK : 网络加载
extension RecommendViewController {
   
    func loadData(){
        recommonVM.loadData {
            self.collectionView.reloadData()
                print("数据加载完成")
        }
    }

}

