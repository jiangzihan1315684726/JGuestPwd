//
//  JGuestPwdInfo.swift
//  JGuestPwd
//
//  Created by 蒋梓涵 on 18/3/3.
//  Copyright © 2018年 蒋梓涵. All rights reserved.
//

import UIKit


//接口回调
protocol GesturePasswordDelegate
{
    func getPwd(str:String)
}

class JGuestPwdInfo: UIView {
    
    var gesturePasswordDelegate:GesturePasswordDelegate?
    
    var bigArray = [UIButton]();//全部大圆
    var selectArray = [UIButton]()//选中圆
    var penColor:UIColor!;//线色
    var lineW:Int!;//线宽
    let time: TimeInterval = 1//完成后清空等待时间

    override init(frame: CGRect) {
        super.init(frame: frame)
         self.backgroundColor = UIColor(colorLiteralRed: 70/255, green: 66/255, blue: 60/255, alpha: 1);
        //大圆
        let  btnWH = (frame.width-90)/3;
        //设置大圆
        for i in 0...8 {
            //第几行
            let row = i / 3
            let loc = i % 3
            //两个button的间距
            let btnSpace = (frame.width - 3*btnWH)/4
            let btnX = btnSpace + (btnWH + btnSpace) * CGFloat(loc)
            let btnY =  btnSpace + (btnWH + btnSpace) * CGFloat(row)
            let gestureNodeBtn = UIButton(frame:CGRect(x: btnX, y: btnY, width: btnWH, height: btnWH))
            gestureNodeBtn.tag = i
            gestureNodeBtn.isUserInteractionEnabled = false   //不响应用户的交互。一定要加上这句
            gestureNodeBtn.setImage(UIImage(named: "gesture_node_normal"), for: UIControlState())
            self.addSubview(gestureNodeBtn)
            bigArray.append(gestureNodeBtn)
        }

    }
    
    override func draw(_ rect: CGRect) {
        var path = UIBezierPath();
        path.lineWidth =  CGFloat(lineW==nil ? 10:lineW!);
        for (index,bt) in self.selectArray.enumerated(){
            if(index == 0){
                path.move(to: bt.center);
            }else{
                path.addLine(to: bt.center)
            }
        }
        /*
         //        线条颜色
         if(iserro){
         UIColor.red.setStroke()
         }else{
         UIColor(colorLiteralRed: 243/255, green: 141/255, blue: 29/255, alpha: 1).setStroke();
         }
         path.stroke();
         
         */
        UIColor(colorLiteralRed: 243/255, green: 141/255, blue: 29/255, alpha: 1).setStroke();
        path.stroke();
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectArray.removeAll();
        touchChanged(touch: touches.first!);
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchChanged(touch: touches.first!);
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.setNeedsDisplay();
        var pwd = "";
        for item in selectArray {
            pwd.append("\(item.tag)");
        }
        //        长度不足时
   /*     if(selectArray.count<4){
            for item in selectArray {
                item.setImage(UIImage(named:"gesture_node_normal"), for: .normal);
            }
            selectArray.removeAll();
            self.setNeedsDisplay()
        }
 */
        self.gesturePasswordDelegate?.getPwd(str: pwd);
        //        倒计时后清空线条圆圈
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            //code
            for item in self.selectArray {
                item.setImage(UIImage(named:"gesture_node_normal"), for: .normal);
            }
            self.selectArray.removeAll();
            self.setNeedsDisplay()
        }

        
    }
    
    
    
    
    
    func touchChanged(touch:UITouch){
        let point = touch.location(in: self);
        //遍历大圆，观察是否在选中，将选中的圆加入数组并且替换图片
        for item in bigArray {
            if(item.frame.contains(point) && !selectArray.contains(item)){
                selectArray.append(item);
                item.setImage(UIImage(named:"gesture_node_pressed"), for: .normal);
            }
            //防止跳着选中
            if(selectArray.count>=1){
                let centerP = CGPoint(x: (selectArray.last!.center.x+point.x)/2, y: (selectArray.last!.center.y+point.y)/2);
                if(item.frame.contains(centerP) && !selectArray.contains(item)){
                    selectArray.append(item);
                    item.setImage(UIImage(named:"gesture_node_pressed"), for: .normal);
                }
                
            }
        }
    
        if(selectArray.count > 0){
            self.setNeedsDisplay()
        }
        
    }

    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
