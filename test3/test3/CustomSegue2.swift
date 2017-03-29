//
//  CustomSegue2.swift
//  test3
//
//  Created by 呂明峻 on 2017/2/27.
//  Copyright © 2017年 呂明峻. All rights reserved.
//

import UIKit

class CustomSegue2: UIStoryboardSegue {
    override func perform() {
        // 指定來源與目標視圖給區域變數
        var firstVCView = self.source.view as UIView!
        var secondVCView = self.destination.view as UIView!
        
        // 取得畫面寬度及高度
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        // 指定目標視圖的初始位置
        secondVCView?.frame = CGRect(x: screenWidth, y: 0.0, width: screenWidth, height: screenHeight)
        
        // 存取App的 key window 並插入目標視圖至目前視圖（來源視圖）上
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(secondVCView!, aboveSubview: firstVCView!)
        
        // 轉換動畫
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            firstVCView?.frame = (firstVCView?.frame.offsetBy(dx: -screenWidth, dy: 0.0))!
            secondVCView?.frame = (secondVCView?.frame.offsetBy(dx: -screenWidth, dy: 0.0))!
            
        }) { (Finished) -> Void in
            self.source.present(self.destination as UIViewController,
                                animated: false,
                                completion: nil)
        }
        
    }

}
