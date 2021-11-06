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
        
        contentView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12.0, right: 0))
    }
    
}
