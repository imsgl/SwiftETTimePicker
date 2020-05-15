# SwiftETTimePicker

可以选择开始和结束时间的选择器

使用方法也是很简单
在需要显示的地方调用 ： 

ETTimePickerView.show()


获取返回结果的方法：
ETTimeSelectFinishObject.subscribe(onNext:{_ in
            print(String.init(format: "%@ - %@", ETGetStartDate().toFormat("yyyy-MM-dd HH:mm"),ETGetEndDate().toFormat("yyyy-MM-dd HH:mm")))
        })
        
        
        使用的RxSwift做的回调方法
