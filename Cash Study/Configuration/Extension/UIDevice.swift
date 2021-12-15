//
//  UIDevice.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/16.
//


import UIKit

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
