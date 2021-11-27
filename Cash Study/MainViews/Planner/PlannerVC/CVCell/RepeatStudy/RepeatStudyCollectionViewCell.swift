//
//  RepeatStudyCollectionViewCell.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/27.
//

import UIKit

class RepeatStudyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var repeatLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    

    @IBAction func checkBoxTapped(_ sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = true
            
        } else {
            sender.isSelected = false
            
        }
    }
    
}
