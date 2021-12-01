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
    @IBOutlet weak var iconImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
    override func prepareForReuse() {
        dDayLbl.text = nil
        dDayName.text = nil
        timeLbl.text = nil
        iconImgView.image = nil
    }
    
    func setUI() {
        self.bgView.backgroundColor = UIColor.homeBorderColor
        self.bgView.layer.cornerRadius = 8
    }

}
