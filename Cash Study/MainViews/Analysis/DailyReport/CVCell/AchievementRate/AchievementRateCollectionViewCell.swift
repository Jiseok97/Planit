//
//  AchievementRateCollectionViewCell.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/07.
//

import UIKit

class AchievementRateCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var studyCntLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.bgView.layer.cornerRadius = 8
        self.bgView.backgroundColor = .studyCellBgColor
        self.progressBar.clipsToBounds = true
        self.progressBar.subviews[1].clipsToBounds = true
        self.progressBar.layer.cornerRadius = 5
        self.progressBar.layer.sublayers![1].cornerRadius = 5
    }

}
