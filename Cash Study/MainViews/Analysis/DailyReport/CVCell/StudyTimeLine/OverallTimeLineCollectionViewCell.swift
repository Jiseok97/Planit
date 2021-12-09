//
//  OverallTimeLineCollectionViewCell.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/09.
//

import UIKit

class OverallTimeLineCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var timelineCV: UICollectionView!
    
    var timeLineLst : DailyReportEntity?
    
    func configure(with dataLst: DailyReportEntity) {
        self.timeLineLst = dataLst
        timelineCV.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        timelineCV.delegate = self
        timelineCV.dataSource = self
        timelineCV.register(UINib(nibName: "StudyTimeLineCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "stlCell")
        timelineCV.layer.cornerRadius = 8
    }

}


extension OverallTimeLineCollectionViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if timeLineLst != nil {
            if timeLineLst?.reports.count != 0 {
                return (timeLineLst?.reports.count)!
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stlCell", for: indexPath) as? StudyTimeLineCollectionViewCell else { return UICollectionViewCell() }
        
        if timeLineLst != nil {
            
            if timeLineLst?.reports.count != 0 {
                
                if indexPath.row == 0 {
                    
                    cell.topView.isHidden = true

                    if self.timeLineLst?.reports.count == 1 {
                        cell.bottomView.isHidden = true
                    }
                }
                
                if indexPath.row == (self.timeLineLst?.reports.count)! - 1 {
                    cell.bottomView.isHidden = true
                }
                
                cell.studyNameLbl.text = timeLineLst?.reports[indexPath.row].title
                
                let time = timeLineLst?.reports[indexPath.row].recordedTime
                let sec = String(describing: time! % 60 )
                let min = String(describing: (time! / 60) % 60 )
                let hour = String(describing: time! / 3600)
                
                if time! < 60 {
                    cell.recordTimeLbl.text = "\(sec)초"
                } else if time! >= 60 && time! < 3600 {
                    cell.recordTimeLbl.text = "\(min)분 \(sec)초"
                } else {
                    cell.recordTimeLbl.text = "\(hour)시간 \(min)분 \(sec)초"
                }
                
                return cell
            } else {
                return UICollectionViewCell()
            }
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.timelineCV.frame.width
        let height = self.timelineCV.frame.height
        
        return CGSize(width: width, height: height)
    }
    
}
