//
//  AddViewController.swift
//  SwiftTestProject
//
//  Created by 张留扣 on 2018/3/4.
//  Copyright © 2018年 ___ZLK___. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Item"
        
    }

    @IBOutlet var detailTextField: UITextField!
    @IBOutlet var titleTextField: UITextField!
    @IBAction func tapAction(_ sender: UIButton) {
        print("点我点我")
        var listArr = UserDefaults.standard.array(forKey: "list")
        if listArr == nil {
            listArr = Array()
        }
        
        let dic = ["titletext":titleTextField.text,"detailtext":detailTextField.text]
        
        listArr?.append(dic)
        UserDefaults.standard.set(listArr, forKey: "list")
        UserDefaults.standard.synchronize()
        
        self.navigationController?.popViewController(animated: true)
    }
}
