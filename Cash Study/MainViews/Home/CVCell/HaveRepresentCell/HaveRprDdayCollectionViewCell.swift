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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        displayDdayView.layer.cornerRadius = 8
    }

}
