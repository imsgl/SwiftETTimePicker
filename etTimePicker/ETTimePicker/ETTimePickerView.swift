//
//  ETTimePickerView.swift
//  HaierListen
//
//  Created by Elliot on 2020/4/15.
//  Copyright © 2020 Elliot. All rights reserved.
//

import UIKit
import RxSwift


class ETTimePickerView: UIView {
    
    let disposeBag = DisposeBag()
    //MARK:单利数据
    static let ET : ETTimePickerView = {
        let ET = ETTimePickerView.init()
        return ET
    }()
    //MARK:显示
    static func show(){
        ETTimePickerView.ET.isHidden = false
    }
//    //MARK:隐藏
//    static func dismiss(){
//        ETTimePickerView.ET.removeFromSuperview()
//    }
    
    //MARK:初始化
    init() {
        super.init(frame: UIScreen.main.bounds)
        self.addSubview(self.bgView)
        self.addSubview(self.contentView)
        UIApplication.shared.windows.first?.addSubview(self)
        self.Bind()
    }
    
    
    func Bind(){
        self.contentView.finishObject.subscribe{_ in
            ETTimeSelectFinishObject.onNext("")
            ETHidden()
        }.disposed(by: disposeBag)
    }
    
    override var isHidden: Bool{
        didSet{
            if isHidden == false {
                UIView.animate(withDuration: 0.3, animations: {
                    self.contentView.top = SCREEN_HEIGHT - self.contentView.height
                })
                self.contentView.monthCollectionView.reloadData()
                if ETTimePickerFirst.year == 0 {
                    self.contentView.headerView.startTimeLabel.isHidden = true
                }
                if ETTimePickerSecond.year == 0 {
                    self.contentView.headerView.endTimeLabel.isHidden = true
                }
            }
        }
    }
    
    
    //MARK:背景颜色
    lazy var bgView : UIView = {
        let bgView = UIView.init(frame: self.bounds)
        bgView.backgroundColor = UIColor.black
        bgView.alpha = 0.5
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(hidden))
        bgView.addGestureRecognizer(tap)
        return bgView
    }()
    
    lazy var contentView : ETTimePickerContentView = {
        let contenView = ETTimePickerContentView.init()
        return contenView
    }()
    
    
    @objc func hidden(){
        ETHidden()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
