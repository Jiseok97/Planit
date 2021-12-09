//
//  MostStudyCollectionViewCell.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/09.
//

import UIKit

class MostStudyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var studyNameLbl: UILabel!
    @IBOutlet weak var recordTimeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.bgView.layer.cornerRadius = 8
    }

}
