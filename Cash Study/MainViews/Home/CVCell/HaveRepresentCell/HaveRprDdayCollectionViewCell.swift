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
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUICell()
    }
    
    // MARK: - Custom Method
    private func setUICell() {
        displayDdayView.layer.cornerRadius = 8
        representImgView.isHidden = true
        dDayLbl.layer.zPosition = 999
        representImgView.layer.zPosition = 1
    }
    
    
    /// Custom Cell
    public func configure(with date : String) {
        let formmat = DateFormatter()
        formmat.dateFormat = "yyyy-MM-dd"

        let endAt = formmat.date(from: date)
        let dDay = (endAt?.timeIntervalSince(Date()))!

        var intDay: Int = 0

        if dDay >= 0 {
            intDay = Int(ceil((dDay + 32400) / 86400))
        } else {
            intDay = Int((dDay + 32400) / 86400)
        }

        if intDay > 0 {
            self.dDayLbl.text = "D-" + String(describing: (intDay))
            self.representImgView.isHidden = true
            self.dDayLbl.isHidden = false
        } else if intDay == 0 {
            self.dDayLbl.isHidden = true
            self.representImgView.isHidden = false
        } else {
            self.dDayLbl.text = "D+" + String(describing: (intDay * -1))
            self.representImgView.isHidden = true
            self.dDayLbl.isHidden = false
        }
    }
    
}
