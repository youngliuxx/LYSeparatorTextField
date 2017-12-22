//
//  LYSeparatorTextField.swift
//  SeparatorTextField_Swift
//
//  Created by youngliuxx on 20/12/2017.
//  Copyright © 2017 youngliuxx. All rights reserved.
//

import UIKit

enum LYSeparatorTextFieldFormat {
    case regular
    case flexible
}

enum LYSeparatorTextFieldSequence {
    case reverse
    case foward
}

let kPlaceHolderChar = "^"

open class LYSeparatorTextField: UITextField {
    public var limitCount: Int = 0
    var gapNumber: Int = 0
    var formatType: LYSeparatorTextFieldFormat = .regular
    var separator: String = ""
    var formatString: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init(frame: CGRect, gapNumber: Int, separator: String) {
        self.init(frame: frame, gapNumber: gapNumber, separator: separator, formatString: "")
    }
    
    public convenience init(frame: CGRect, formatStr: String) {
        self.init(frame: frame, gapNumber: 0, separator: "", formatString: formatStr)
    }
    
    private convenience init(frame: CGRect, gapNumber: Int, separator: String, formatString: String) {
//        super.init
        self.init(frame: frame)
        self.delegate = self
        self.formatType = formatString.count > 0 ? .flexible: .regular
        self.gapNumber = gapNumber
        self.separator = separator
        self.formatString = formatString
    }
    
    func getSeparatorLength(with preOperationIndex: Int, sequence: LYSeparatorTextFieldSequence) -> Int{
        var finalSeparatorLength = 0
        switch sequence {
        case .reverse:
            for i in 1...preOperationIndex {
                guard let range = Range(NSMakeRange(preOperationIndex - i, 1), in: formatString) else {
                    return 0
                }
                let preDeleteFormatStr = formatString[range]
                // Separator
                if !preDeleteFormatStr.elementsEqual(kPlaceHolderChar) {
                    finalSeparatorLength = i
                }
                // Not a separator
                else {
                    return finalSeparatorLength
                }
            }
        case .foward:
            print("")
            let formatStringLength = formatString.count
            for i in preOperationIndex..<formatStringLength {
                guard let range = Range(NSMakeRange(i + 1, 1), in: formatString) else {
                    return 0
                }
                let preAddFormatStr = formatString[range]
                // Separator
                if !preAddFormatStr.elementsEqual(kPlaceHolderChar) {
                    finalSeparatorLength = i - preOperationIndex + 1
                }
                // Not a separator
                else {
                    return finalSeparatorLength
                }
            }
        }
        return finalSeparatorLength
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.delegate = nil;
    }
    
    public func getInputText() -> String {
        guard let text = super.text else {
            return ""
        }
        return text.replacingOccurrences(of: separator, with: "")
    }
}

extension LYSeparatorTextField: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = textField.text!.count - range.length + string.count
        let preDeleteIndex = textField.text!.count - range.length
        let preAddIndex = textField.text!.count + string.count
        var finalString = textField.text!
        
        switch self.formatType {
        case .regular:
            // Limit
            if (limitCount > 0 && newLength >= limitCount + newLength / gapNumber) {
                return false
            }
            
            // Delete
            if string.elementsEqual("") {
                if (preDeleteIndex%(gapNumber + 1) == 0) {
                    let endIndex = finalString.index(finalString.startIndex, offsetBy: preDeleteIndex)
                    finalString = String(finalString[finalString.startIndex..<endIndex])
                }
            }
            // Add
            else if (preAddIndex >= gapNumber && preAddIndex % (gapNumber + 1) == 0) {
                finalString = "\(textField.text!)\(separator)"
            }
        case .flexible:
            // Delete
            if string.elementsEqual("") {
                if (range.location - 1) > 0 {
                    let separatorLength = self.getSeparatorLength(with: preDeleteIndex, sequence: .reverse)
                    let endIndex = finalString.index(finalString.startIndex, offsetBy: preDeleteIndex - separatorLength)
                    finalString = String(finalString[finalString.startIndex..<endIndex])
                    textField.text = finalString
                    return false
                }
            }
            // Add
            else {
                let currentIndex = textField.text!.count
                // Limit
                if currentIndex >= formatString.count {
                    return false
                }
                let preAddChar = string
                
                guard let range = Range(NSMakeRange(currentIndex, 1), in: formatString) else {
                    return true
                }
                let formatChar = formatString[range]
                if formatChar.elementsEqual(kPlaceHolderChar) {
                    finalString = finalString + preAddChar
                }
                else {
                    let preCurrentIndex = currentIndex - 1
                    let separatorLength = self.getSeparatorLength(with: preCurrentIndex, sequence: .foward)
                    for i in 0..<separatorLength {
                        guard let range = Range(NSMakeRange(currentIndex + i, 1), in: formatString) else {
                            return true
                        }
                        let formatChar = formatString[range]
                        finalString = finalString + formatChar
                    }
                    finalString = finalString + preAddChar
                }
                textField.text = finalString
                return false
            }
        }
        textField.text = finalString
        return true
    }
}


