//
//  ViewController.swift
//  SeparatorTextField_Swift
//
//  Created by youngliuxx on 20/12/2017.
//  Copyright © 2017 youngliuxx. All rights reserved.
//

import UIKit
import LYSeparatorTextField
let space = CGFloat(20.0)
let SCREEN_WIDTH = UIScreen.main.bounds.size.width

class ViewController: UIViewController {
    // 12345-123456
    let textField: LYSeparatorTextField = {
        () -> LYSeparatorTextField in
        let temp = LYSeparatorTextField.init(frame: CGRect.init(x: space, y: 100, width: SCREEN_WIDTH - space*2, height: 30), gapNumber: 4, separator: "-")
        temp.placeholder = "separator: -"
        temp.keyboardType = .numberPad
        temp.limitCount = 12
        return temp
    }()
    
    // 123,234
    let textField2: LYSeparatorTextField = {
        () -> LYSeparatorTextField in
        let temp = LYSeparatorTextField.init(frame: CGRect.init(x: space, y: 160, width: SCREEN_WIDTH - space*2, height: 30), gapNumber: 3, separator: ",")
        temp.placeholder = "separator: ,"
        return temp
    }()
    
    // 2017-12-15
    let textField3: LYSeparatorTextField = {
        () -> LYSeparatorTextField in
        let temp = LYSeparatorTextField.init(frame: CGRect.init(x: space, y: 220, width: SCREEN_WIDTH - space*2, height: 30), formatStr: "^^^^-^^-^^")
        temp.placeholder = "format: 2017-12-15"
        temp.keyboardType = .numberPad
        return temp
    }()
    
    // Day:01 Month:01 Year:2017
    let textField4: LYSeparatorTextField = {
        () -> LYSeparatorTextField in
        let temp = LYSeparatorTextField.init(frame: CGRect.init(x: space, y: 280, width: SCREEN_WIDTH - space*2, height: 30), formatStr: "Day:^^ Month:^^ Year:^^^^")
        temp.placeholder = "format: Day:05 Month:12 Year:2017"
        temp.keyboardType = .numberPad
        return temp
    }()
    
    // format: 185-0000-0001
    let textField5: LYSeparatorTextField = {
        () -> LYSeparatorTextField in
        let temp = LYSeparatorTextField.init(frame: CGRect.init(x: space, y: 340, width: SCREEN_WIDTH - space*2, height: 30), formatStr: "^^^-^^^^-^^^^")
        temp.placeholder = "format: 185-0000-0001"
        temp.keyboardType = .numberPad
        return temp
    }()
    
    let submitBtn: UIButton = {
        () -> UIButton in
        let temp = UIButton.init(frame: CGRect.init(x: space, y: 460, width: SCREEN_WIDTH - space*2, height: 30))
        temp.backgroundColor = UIColor.gray
        temp.setTitle("Print Input Text", for: .normal)
        temp.addTarget(self, action: #selector(tapBtn), for: .touchUpInside)
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(textField)
        self.view.addSubview(textField2)
        self.view.addSubview(textField3)
        self.view.addSubview(textField4)
        self.view.addSubview(textField5)
        self.view.addSubview(submitBtn)
        
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(keyboardHide))
        self.view.addGestureRecognizer(tapGes)
    }
    
    @objc func tapBtn() {
        print("Input text:\(textField.getInputText())")
        print("Input text:\(textField2.getInputText())")
        print("Input text:\(textField3.getInputText())")
        print("Input text:\(textField4.getInputText())")
        print("Input text:\(textField5.getInputText())")
    }
    
    @objc func keyboardHide() {
        textField.resignFirstResponder()
        textField2.resignFirstResponder()
        textField3.resignFirstResponder()
        textField4.resignFirstResponder()
        textField5.resignFirstResponder()
    }
}

