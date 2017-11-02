//
//  XibView.swift
//  iOSTest
//
//  Created by Brandon Chester on 2017-10-14.
//  Copyright © 2017 Brandon Chester. All rights reserved.
//

import UIKit

@IBDesignable class XibView: UIView {
    @IBInspectable var nibName:String?
    var contentView:UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
        contentView?.prepareForInterfaceBuilder()
    }
    
    func setup() {
        guard let view = loadContentView() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    func loadContentView() -> UIView? {
        guard let nibName = self.nibName else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
