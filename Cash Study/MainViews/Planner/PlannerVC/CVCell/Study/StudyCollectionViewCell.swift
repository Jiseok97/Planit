//
//  StudyCollectionViewCell.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/18.
//

import UIKit

protocol UserCheckisDoneDelegate: AnyObject {
    func checkBoxTrue(stId: Int)
    func checkBoxFalse(stId: Int)
}

class StudyCollectionViewCell: UICollectionViewCell {

    @IBOutlet var titleLbl: UILabel!
    @IBOutlet weak var checkBox: UIButton!
    
    var cellDelegate : UserCheckisDoneDelegate?
    var studyId: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func testCheckTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.cellDelegate?.checkBoxFalse(stId: studyId)
        } else {
            sender.isSelected = true
            self.cellDelegate?.checkBoxTrue(stId: studyId)
            
        }
    }
}
