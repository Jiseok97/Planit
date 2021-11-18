//
//  DdayPageViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/09.
//

import UIKit

class DdayPageViewController: UIViewController {

    @IBOutlet weak var dDayCV: UICollectionView!
    @IBOutlet weak var cvHeight: NSLayoutConstraint!
    
    var dDayLst : [String] = ["Test", "Test02", "Test03", "Test04", "Test05"]
    var DdayDataLst : ShowDdayEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        ShowDdayDataManager().addDday(viewController: self)
//        print("DdayPage(viewDidLoad) → \(DdayDataLst)")
        
        setGradation()
        dDayCV.delegate = self
        dDayCV.dataSource = self
        
        dDayCV.backgroundColor = UIColor.mainNavy.withAlphaComponent(0.0)
        dDayCV.register(UINib(nibName: "DdayListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DdayCell")
        dDayCV.register(UINib(nibName: "RepresentativeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RepresentativeCell")
        dDayCV.register(UINib(nibName: "NoDdayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NoDdayCell")
        
        if let collectionViewLayout = dDayCV.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ShowDdayDataManager().addDday(viewController: self)
        self.dDayCV.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        self.changeHeight()
    }
    
}


// MARK: Extension
extension DdayPageViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func changeHeight() {
        self.cvHeight.constant = self.dDayCV.collectionViewLayout.collectionViewContentSize.height
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if DdayDataLst != nil {
            return DdayDataLst!.ddays.count
        } else {
            // 디데이가 없을 때
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if DdayDataLst != nil {
            if DdayDataLst?.ddays[indexPath.row].isRepresentative == true {
                // 대표 디데이
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RepresentativeCell", for: indexPath) as? RepresentativeCollectionViewCell else { return UICollectionViewCell() }
                
                cell.layer.cornerRadius = 8
                
                let formmat = DateFormatter()
                formmat.dateFormat = "yyyy-MM-dd"
                
                let endAt = formmat.date(from: (DdayDataLst?.ddays[indexPath.row].endAt)!)
                let dDay = (endAt?.timeIntervalSince(Date()))!
                let intDay = Int(dDay / 86400)
                
                if intDay > 0 {
                    cell.dDayLbl.text = "D-" + String(describing: (intDay + 1))
                } else {
                    cell.dDayLbl.text = "D+" + String(describing: (intDay * -1))
                }
                
                switch DdayDataLst?.ddays[indexPath.row].color {
                case "GREEN" :
                    cell.iconImgView.image = UIImage(named: "exDday1")
                    
                case "YELLOW":
                    cell.iconImgView.image = UIImage(named: "exDday2")
                    
                case "PINK":
                    cell.iconImgView.image = UIImage(named: "exDday3")
                    
                case "DARK_BLUE":
                    cell.iconImgView.image = UIImage(named: "exDday4")
                    
                default:
                    cell.iconImgView.image = UIImage(named: "exDday5")
                }
                
                cell.dDayNameLbl.text = DdayDataLst?.ddays[indexPath.row].title
                cell.timeLbl.text = DdayDataLst?.ddays[indexPath.row].endAt
                
            
                
                return cell
                
            } else {
                // 일반 디데이
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DdayCell", for: indexPath) as? DdayListCollectionViewCell else { return UICollectionViewCell() }
                
                let formmat = DateFormatter()
                formmat.dateFormat = "yyyy-MM-dd"
                
                let endAt = formmat.date(from: (DdayDataLst?.ddays[indexPath.row].endAt)!)
                let dDay = (endAt?.timeIntervalSince(Date()))!
                let intDay = Int(dDay / 86400)
                
                if intDay > 0 {
                    cell.dDayLbl.text = "D-" + String(describing: (intDay + 1))
                } else {
                    cell.dDayLbl.text = "D+" + String(describing: (intDay * -1))
                }
                
                cell.layer.cornerRadius = 8
                cell.backgroundColor = UIColor.studyCellBgColor
                
                switch DdayDataLst?.ddays[indexPath.row].color {
                case "GREEN" :
                    cell.iconImgView.image = UIImage(named: "exDday1")
                    
                case "YELLOW":
                    cell.iconImgView.image = UIImage(named: "exDday2")
                    
                case "PINK":
                    cell.iconImgView.image = UIImage(named: "exDday3")
                    
                case "DARK_BLUE":
                    cell.iconImgView.image = UIImage(named: "exDday4")
                    
                default:
                    cell.iconImgView.image = UIImage(named: "exDday5")
                }
                
                cell.dDayName.text = DdayDataLst?.ddays[indexPath.row].title
                cell.timeLbl.text = DdayDataLst?.ddays[indexPath.row].endAt
                
                return cell
            }
            
        } else {
            // 디데이가 없다는 cell 출력
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoDdayCell", for: indexPath) as? NoDdayCollectionViewCell else { return UICollectionViewCell() }
            
            cell.backgroundColor = UIColor.yellow
            
            return cell
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Dday 편집하기 기능
        
       
        // 해당 디데이 ID 저장
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.bounds.width * 0.872
        
        if DdayDataLst != nil {
            if indexPath.row == 0 {
                
                let height = self.view.bounds.height * 0.23510971786
                return CGSize(width: width, height: height)
                
            } else {
                
                let height = self.view.bounds.height * 0.15673981191
                return CGSize(width: width, height: height)
            }
        } else {
            // 디데이가 없을 때
            
            return CGSize(width: self.view.bounds.width * 0.872, height: 400)
        }
    }
    
}


extension DdayPageViewController {
    func showDday(result : ShowDdayEntity) {
        self.DdayDataLst = result
        self.dDayCV.reloadData()
    }
}
