//
//  JGuestPwd_UI.swift
//  JGuestPwd
//
//  Created by 蒋梓涵 on 18/3/3.
//  Copyright © 2018年 蒋梓涵. All rights reserved.
//

import UIKit
import SnapKit

class JGuestPwd_UI: UIView {
    var smallArray =  [UIButton]();//全部小圆
    
    
    //设置
    var penColor:UIColor!;//线色
    var lineW:Int!;//线宽
    var allBm:JGuestPwdInfo!;
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(colorLiteralRed: 70/255, green: 66/255, blue: 60/255, alpha: 1);
        
       
        
         allBm = JGuestPwdInfo(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 350))
        self.addSubview(allBm)
        allBm.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0);
            make.top.equalTo(0).offset(20);
            make.centerX.equalTo(self);
        }
        
       
        

    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
