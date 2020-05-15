//
//  ViewController.swift
//  etTimePicker
//
//  Created by Elliot on 2020/5/14.
//  Copyright © 2020 ET. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        view.backgroundColor = .black
        self.view.addSubview(view)
        ETTimeSelectFinishObject.subscribe(onNext:{_ in
            print(String.init(format: "%@ - %@", ETGetStartDate().toFormat("yyyy-MM-dd HH:mm"),ETGetEndDate().toFormat("yyyy-MM-dd HH:mm")))
        })
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            ETTimePickerView.show()
        }
        
        
    }


}

