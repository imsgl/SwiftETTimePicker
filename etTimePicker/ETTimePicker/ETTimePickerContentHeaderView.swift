//
//  ETTimeContentHeaderView.swift
//  HaierListen
//
//  Created by Elliot on 2020/4/17.
//  Copyright © 2020 Elliot. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
enum ETTimeEnum {
    case style
    case today
    case submit
}
class ETTimePickerContentHeaderView: UIView {
    var disposeBag = DisposeBag()
    let subject = PublishSubject<ETTimeEnum>()//点击了哪一个按钮
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 60))
        self.drawLine(strokeColor: UIColor.init(hexString: "AAAAAA")!, lineWidth: 0.5, corners: [.bottom])
        self.addSubviews([yearOrMonthBtn,submitBtn,todayBtn,startTimeLabel,endTimeLabel])
    }
    
    lazy var yearOrMonthBtn : UIButton = {
        let yearOrMonthBtn = UIButton.init(type: .custom)
        yearOrMonthBtn.frame = CGRect(x: 15, y: 15, width: 70, height: 30)
        yearOrMonthBtn.setTitle(String.init(format: "%d月", CURRENTMONTH), for: .normal)
        yearOrMonthBtn.backgroundColor =  UIColor.init(hexString: "58C2F3")
        yearOrMonthBtn.layer.cornerRadius = 5
        yearOrMonthBtn.clipsToBounds = true
        yearOrMonthBtn.rx.tap.subscribe(onNext:{[weak self] _ in
            self?.subject.onNext(.style)
            }).disposed(by: disposeBag)
        return yearOrMonthBtn
    }()
    
    lazy var submitBtn : UIButton = {
        let submitBtn = UIButton.init(type: .custom)
        submitBtn.frame = CGRect(x: SCREEN_WIDTH - 55, y: 15, width: 50, height: 30)
        submitBtn.setTitle("确认", for: .normal)
        submitBtn.backgroundColor = .blue
        submitBtn.layer.cornerRadius = 5
        submitBtn.clipsToBounds = true
        submitBtn.rx.tap.subscribe{[weak self] _ in
            self!.subject.onNext(.submit)
        }.disposed(by: disposeBag)
        return submitBtn
    }()
    
    lazy var todayBtn : UIButton = {
        let todayBtn = UIButton.init(type: .custom)
        todayBtn.frame = CGRect(x: submitBtn.left - 60, y: 15, width: 50, height: 30)
        todayBtn.setTitle("今天", for: .normal)
        todayBtn.backgroundColor = UIColor.init(hexString: "52CECF")
        todayBtn.layer.cornerRadius = 5
        todayBtn.clipsToBounds = true
        todayBtn.rx.tap.subscribe{[weak self] _ in
            self!.subject.onNext(.today)
        }.disposed(by: disposeBag)
        return todayBtn
    }()
    
    
    lazy var startTimeLabel  : UILabel = {
        let startTimeLabel = UILabel.init(frame: CGRect(x: self.yearOrMonthBtn.right, y: 10, width: self.todayBtn.left - self.yearOrMonthBtn.right, height: 20))
        startTimeLabel.text = "开始时间:9999-99-99 99:99"
        startTimeLabel.font = UIFont.systemFont(ofSize: 12)
        startTimeLabel.textAlignment = .center
        startTimeLabel.isHidden = true
        return startTimeLabel
    }()
    
    lazy var endTimeLabel  : UILabel = {
        let endTimeLabel = UILabel.init(frame: CGRect(x: self.yearOrMonthBtn.right, y: 30, width: self.todayBtn.left - self.yearOrMonthBtn.right, height: 20))
        endTimeLabel.text = "结束时间:9999-99-99 99:99"
        endTimeLabel.font = UIFont.systemFont(ofSize: 12)
        endTimeLabel.textAlignment = .center
        endTimeLabel.isHidden = true
        return endTimeLabel
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
