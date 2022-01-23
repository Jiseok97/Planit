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
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
    // MARK: - Custom Method
    override func prepareForReuse() {
        dDayLbl.text = nil
        dDayName.text = nil
        timeLbl.text = nil
        iconImgView.image = nil
    }
    
    private func setUI() {
        self.bgView.backgroundColor = UIColor.homeBorderColor
        self.bgView.layer.cornerRadius = 8
    }

    
    public func configure(with dataLst: ShowDdayEntity, idx: Int) {
        let endAt = dataLst.ddays[idx].endAt
        let icon = dataLst.ddays[idx].icon
        let title = dataLst.ddays[idx].title
        
        let formmat = DateFormatter()
        formmat.dateFormat = "yyyy-MM-dd"
        
        let endStr = formmat.date(from: endAt)
        let dDay = (endStr?.timeIntervalSince(Date()))!
        var intDay : Int = 0
        
        if dDay >= 0 {
            intDay = Int(ceil((dDay + 32400) / 86400))
        } else {
            intDay = Int((dDay + 32400) / 86400)
        }
        
        if intDay > 0 {
            self.dDayLbl.text = "D-" + String(describing: (intDay))
        } else {
            self.dDayLbl.text = "D+" + String(describing: (intDay * -1))
        }
        
        switch icon {
        case "PLANET" :
            self.iconImgView.image = UIImage(named: "Planet")
            
        case "PLANET_WITH_RINGS":
            self.iconImgView.image = UIImage(named: "PlanetRing")
            
        case "STAR":
            self.iconImgView.image = UIImage(named: "Star")
            
        case "FLAME":
            self.iconImgView.image = UIImage(named: "Flame")
            
        default:
            self.iconImgView.image = UIImage(named: "Ufo")
        }
        
        self.dDayName.text = title
        self.timeLbl.text = endAt
    }

}
