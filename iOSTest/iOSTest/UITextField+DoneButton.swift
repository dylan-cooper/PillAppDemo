//
//  UITextField+DoneButton.swift
//  iOSTest
//
//  Created by Brandon Chester on 2017-10-23.
//  Copyright © 2017 Brandon Chester. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func addDoneButton() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(resignFirstResponder))
        toolbar.items = [flexBarButton, doneBarButton]
        inputAccessoryView = toolbar
    }
}
