//
//  RepresentativeCollectionViewCell.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/10.
//

import UIKit

class RepresentativeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var dDayNameLbl: UILabel!
    @IBOutlet weak var dDayLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
