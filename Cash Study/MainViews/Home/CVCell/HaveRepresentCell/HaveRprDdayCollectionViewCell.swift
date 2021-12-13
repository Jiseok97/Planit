//
//  HaveRprDdayCollectionViewCell.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/24.
//

import UIKit

class HaveRprDdayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var displayDdayView: UIView!
    @IBOutlet weak var dDayLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var representImgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        displayDdayView.layer.cornerRadius = 8
        representImgView.isHidden = true
        dDayLbl.layer.zPosition = 999
        representImgView.layer.zPosition = 1

    }
    
}
