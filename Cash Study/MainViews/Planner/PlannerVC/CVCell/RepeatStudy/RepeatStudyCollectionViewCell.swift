//
//  RepeatStudyCollectionViewCell.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/27.
//

import UIKit


class RepeatStudyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var checkBoxBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var repeatLbl: UILabel!
    
    var cellDelegate : UserCheckisDoneDelegate?
    var studyId: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func tappedCheckBox(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.cellDelegate?.checkBoxFalse(stId: studyId)
        } else {
            sender.isSelected = true
            self.cellDelegate?.checkBoxTrue(stId: studyId)
        }
    }
    
    
}
