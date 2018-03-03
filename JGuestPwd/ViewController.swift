//
//  ViewController.swift
//  JGuestPwd
//
//  Created by 蒋梓涵 on 18/3/3.
//  Copyright © 2018年 蒋梓涵. All rights reserved.
//

import UIKit

class ViewController: UIViewController,GesturePasswordDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let xy = CGRect(x: 0, y: 70, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let pw = JGuestPwd_UI(frame: xy)
        pw.allBm.gesturePasswordDelegate = self;
        self.view.addSubview(pw)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPwd(str: String) {
        let alertController = UIAlertController(title:"密码",message:str, preferredStyle: .alert);
        let cancelAction = UIAlertAction(title:"确定", style: .cancel, handler: nil);
        alertController.addAction(cancelAction);
        self.present(alertController, animated: true, completion: nil);
    }


}

