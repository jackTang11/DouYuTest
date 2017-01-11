//
//  PageTitleView.swift
//  DouYuTest
//
//  Created by jack_tang on 17/1/6.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

import UIKit


private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
private let kScrollLineH : CGFloat = 2



protocol PageTitleViewDelete : class {
    
    func pageTitleView(_ contentview : PageTitleView,selectIndex intdex: Int)
    
}

class PageTitleView: UIView {

    fileprivate var isScrollEndable : Bool = false
    fileprivate var titles : [String]
    fileprivate var currentIndex = 0;
    fileprivate lazy var titleLabelView  = [UILabel]()
    
    weak var delete : PageTitleViewDelete?
    
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    
    }()
    
    
    fileprivate lazy var scrollLine :UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor(r: 255, g: 128, b: 0)
        return scrollLine
    }()
    
    
    
    
    //MARK 构造函数
    init(frame : CGRect , isScrollEndable : Bool ,titles : [String]){
        self.isScrollEndable = isScrollEndable
        self.titles = titles
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension PageTitleView{

    fileprivate func setUI(){
        addSubview(self.scrollView)
        scrollView.frame = bounds
        scrollView.backgroundColor = UIColor.white
        setUpTitles()
        setupBottomLineAndScrollLine()
        
    }
    
    
    fileprivate func setUpTitles(){
        
        // 0.确定label的一些frame的值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            // 1.创建UILabel
            let label = UILabel()
            
            // 2.设置Label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            // 3.设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 4.将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabelView.append(label)
            
            // 5.给Label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleClick(_:)))
            label.addGestureRecognizer(tapGes)
        }
    
    }
    
    
    
    func setupBottomLineAndScrollLine(){
        // 1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 2.添加scrollLine
        // 2.1.获取第一个Label
        guard let firstLabel = titleLabelView.first else { return }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        // 2.2.设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
    
}

extension PageTitleView{

   @objc fileprivate func titleClick(_ tapges : UITapGestureRecognizer){
    
    guard let currentLable = tapges.view as? UILabel else {  return }
    
    //如果重复点击同一个label  那么直接返回
    if currentLable.tag == currentIndex { return }
    
    //2.获取之前的lable
    let oldLable : UILabel = titleLabelView[currentIndex]
    
    //3切换文字的颜色
    currentLable.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
    oldLable.textColor =   UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
    
    //保存最新lale 的下标
    currentIndex = currentLable.tag
    
    //滚动条发生变化
    
    let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
    UIView.animate(withDuration: 0.5, animations: {
        self.scrollLine.frame.origin.x = scrollLineX
    
    })
    
    delete?.pageTitleView(self, selectIndex: currentIndex)
    
    }
}



extension PageTitleView{

    func setTitleProgress(_ progress : CGFloat,sourceIndex : Int,tagIndex : Int){
        // 1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabelView[sourceIndex]
        let targetLabel = titleLabelView[tagIndex]
        
        // 2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        // 3.2.变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        // 3.2.变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 4.记录最新的index
        currentIndex = tagIndex
    
    }

}


















