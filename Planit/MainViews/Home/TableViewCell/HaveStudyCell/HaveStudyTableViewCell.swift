//
//  HaveStudyTableViewCell.swift
//  Planit
//
//  Created by 이지석 on 2021/11/04.
//

import UIKit

class HaveStudyTableViewCell: UITableViewCell {

    @IBOutlet weak var studyTitleLbl: UILabel!
    @IBOutlet weak var studySubTitleLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
