//
//  ETTimePickerDatePickerView.swift
//  HaierListen
//
//  Created by Elliot on 2020/4/21.
//  Copyright © 2020 Elliot. All rights reserved.
//

import UIKit
import RxSwift
class ETTimePickerDatePickerView: UIView {

    let disposeBag = DisposeBag()
    let datePickerObject = PublishSubject<(hour : Int , minute : Int)>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews([bgView,contentView])
        self.contentView.addSubviews([timePicker,closeBtn,submitBtn])
    }
    
    lazy var bgView : UIView = {
        let bgView = UIView.init(frame: self.bounds)
        bgView.backgroundColor = UIColor.black
        bgView.alpha = 0.5
        return bgView
    }()
    
    lazy var contentView : UIView = {
        let contentView = UIView.init(frame: CGRect(x: 40, y: self.height / 2.0 - 110, width: SCREEN_WIDTH - 80, height: 150 + 70))
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        return contentView
    }()
    
    lazy var timePicker : UIDatePicker = {
        let timePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: self.contentView.width, height: 150))
        timePicker.backgroundColor = UIColor.white
        timePicker.locale = Locale(identifier: "zh_CN")
        timePicker.datePickerMode = .time
        return timePicker
    }()
    
    
    
    lazy var closeBtn : UIButton = {
        let closeBtn = UIButton.init(type: .custom)
        closeBtn.frame = CGRect(x: 10, y: self.timePicker.bottom + 20, width: (self.contentView.width - 30) / 2, height: 40)
        closeBtn.setTitle("取消", for: .normal)
        closeBtn.setTitleColor(UIColor.init(hexString: "FF4500"), for: .normal)
        closeBtn.layer.cornerRadius = 5
        closeBtn.clipsToBounds = true
        closeBtn.backgroundColor = COLOR200
        closeBtn.rx.tap.subscribe(onNext:{[weak self] _ in
            self!.isHidden = true
            self!.datePickerObject.onNext((hour : 0 , minute : 0))
        }).disposed(by: disposeBag)
        return closeBtn
    }()
    
    
    
    lazy var submitBtn : UIButton = {
        let submitBtn = UIButton.init(type: .custom)
        submitBtn.frame = CGRect(x: self.closeBtn.right + 10, y: self.closeBtn.top, width: self.closeBtn.width , height: self.closeBtn.height)
        submitBtn.setTitle("确认", for: .normal)
        submitBtn.layer.cornerRadius = 5
        submitBtn.clipsToBounds = true
        submitBtn.backgroundColor = COLOR_SCREEN
        submitBtn.rx.tap.subscribe(onNext:{[weak self] _ in
            self!.isHidden = true
            self!.datePickerObject.onNext((hour : self!.timePicker.date.hour , minute : self!.timePicker.date.minute))
        }).disposed(by: disposeBag)
        return submitBtn
    }()

    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
