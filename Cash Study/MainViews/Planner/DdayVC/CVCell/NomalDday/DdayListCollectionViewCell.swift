//
//  DdayListCollectionViewCell.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/09.
//

import UIKit

class DdayListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var dDayName: UILabel!
    @IBOutlet weak var dDayLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
    
    func setUI() {
        self.bgView.backgroundColor = UIColor.homeBorderColor
        self.bgView.layer.cornerRadius = 8
    }

}
