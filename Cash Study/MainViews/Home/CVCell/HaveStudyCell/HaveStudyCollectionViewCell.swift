//
//  HaveStudyCollectionViewCell.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/06.
//

import UIKit

class HaveStudyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var subLbl: UILabel!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    // MARK: - Custom Method
    public func configure(recordedTime: Int, restCnt: Int) {
        if recordedTime != 0 {
            let time = recordedTime
            let hour = time / 3600
            let min = (time / 60) % 60
            let sec = time % 60
            
            if time < 60 {
                let timeTxt = "\(sec)초"
                let rCnt = restCnt
                let changeText = "측정시간 \(timeTxt) • 휴식횟수 \(String(describing: rCnt))회"
                self.subLbl.text = changeText
                
            } else if time >= 60 && time < 3600 {
                let timeTxt = "\(min)분 \(sec)초"
                let rCnt = restCnt
                let changeText = "측정시간 \(timeTxt) • 휴식횟수 \(String(describing: rCnt))회"
                self.subLbl.text = changeText
                
            } else {
                let timeTxt = "\(hour)시간 \(min)분 \(sec)초"
                let rCnt = restCnt
                let changeText = "측정시간 \(timeTxt) • 휴식횟수 \(String(describing: rCnt))회"
                self.subLbl.text = changeText
            }
            
            self.subLbl.textColor = UIColor.link
        } else {
            self.subLbl.textColor = UIColor.cancleAlertColor
            self.subLbl.text = "측정된 공부시간이 없습니다"
        }
    }
}
