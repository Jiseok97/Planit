//
//  UIViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/24.
//

import UIKit

extension UIViewController {
    
    
    // MARK: Show Indicator
    func showIndicator() {
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
    }
    
    // MARK: DisMiss Indicator
    @objc func dismissIndicator() {
        IndicatorView.shared.dismiss()
    }
}
