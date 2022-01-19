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


extension String {
    func hasCharacters() -> Bool{
        do{
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣ]$", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)){
                return true
            }
        }catch{
            print(error.localizedDescription)
            return false
        }
        return false
    }
}
