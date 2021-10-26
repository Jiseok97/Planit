//
//  UITextField.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/26.
//

import UIKit

extension UITextField {
    func setPlaceHolderColor(_ color: UIColor) {
        guard let string = self.placeholder else { return }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
}
