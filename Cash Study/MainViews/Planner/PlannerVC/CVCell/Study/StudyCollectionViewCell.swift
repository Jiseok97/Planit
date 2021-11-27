//
//  StudyCollectionViewCell.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/18.
//

import UIKit

class StudyCollectionViewCell: UICollectionViewCell {

    @IBOutlet var checkBox: UIButton!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var repeatLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    // MARK: Functions
    @IBAction func checkBtnTapped(_ sender: Any) {
        if !self.checkBox.isSelected {
            self.checkBox.isSelected = true
        } else {
            self.checkBox.isSelected = false
        }
    }
    
    
    @IBAction func editStudy(_ sender: Any) {
        print("Edit btn Tapped")
    }
    

}
