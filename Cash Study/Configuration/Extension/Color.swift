//
//  Color.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/24.
//

import UIKit

extension UIColor {
    convenience init (hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    
    
    class var mainNavy: UIColor { UIColor(hex: 0x050626) }
    class var disabledColor: UIColor { UIColor(hex: 0x090A35) }
    class var placeHolderColor: UIColor { UIColor(hex: 0x6B6C85) }
    class var homeBorderColor: UIColor { UIColor(hex: 0x171853) }
    class var myGray: UIColor { UIColor(hex: 0xD9D9D9) }
    class var studyCellBgColor : UIColor { UIColor(hex: 0x11123D)}
}
