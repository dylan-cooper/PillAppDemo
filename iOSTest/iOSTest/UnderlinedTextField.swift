//
//  UnderlinedTextField.swift
//  iOSTest
//
//  Created by Apple on 2017-10-23.
//  Copyright © 2017 Brandon Chester. All rights reserved.
//

import UIKit

@IBDesignable class UnderlinedTextField: UITextField {

    private var underline = UIView()
    @IBInspectable var lineColor:UIColor = UIColor.lightGray
    @IBInspectable var lineHighlightColor:UIColor = UIColor.blue
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawLine()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawLine()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        drawLine()
    }
    
    private func drawLine() {
        /*underline.backgroundColor = lineColor
        underline.frame = CGRect(x: 0, y: bounds.maxY, width: frame.width, height: 1)
        addSubview(underline)*/
        underline.backgroundColor = lineColor
        underline.translatesAutoresizingMaskIntoConstraints = false
        addSubview(underline)
        underline.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        underline.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        underline.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        underline.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    override func becomeFirstResponder() -> Bool {
        underline.backgroundColor = lineHighlightColor
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        underline.backgroundColor = lineColor
        return super.resignFirstResponder()
    }
}
