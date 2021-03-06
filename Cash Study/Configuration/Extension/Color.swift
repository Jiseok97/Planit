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
    class var enableBtnColor: UIColor { UIColor(hex: 0x252641) }
    class var disabledColor: UIColor { UIColor(hex: 0x090A35) }
    class var placeHolderColor: UIColor { UIColor(hex: 0x6B6C85) }
    class var homeBorderColor: UIColor { UIColor(hex: 0x171853) }
    class var myGray: UIColor { UIColor(hex: 0xD9D9D9) }
    class var studyCellBgColor : UIColor { UIColor(hex: 0x11123D) }
    class var gradationStartColor: UIColor { UIColor(hex: 0x0D0E34) }
    class var sgNomalColor : UIColor { UIColor(hex: 0x3A3B53) }
    class var circleBgColor : UIColor { UIColor(hex: 0x04041D) }
    class var cancleAlertColor : UIColor { UIColor(hex: 0x888888)}
    class var topDdayGrColor : UIColor { UIColor(hex: 0x00D8FF) }
    class var bottomDdayGrColor : UIColor { UIColor(hex: 0xDCB92C) }
    class var remainDdayColor: UIColor { UIColor(hex: 0x1C6EE7) }
    class var homeTimeTxtColor: UIColor { UIColor(hex: 0xDCB92D) }
}
