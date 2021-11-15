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
    var DdayDataLst : [dday] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        ShowDdayDataManager().addDday(viewController: self)
        print("DdayPage → \(DdayDataLst)")
        
        setGradation()
        dDayCV.delegate = self
        dDayCV.dataSource = self
        
        dDayCV.backgroundColor = UIColor.mainNavy.withAlphaComponent(0.0)
        dDayCV.register(UINib(nibName: "DdayListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DdayCell")
        dDayCV.register(UINib(nibName: "RepresentativeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RepresentativeCell")
        
        if let collectionViewLayout = dDayCV.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
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
        return self.DdayDataLst.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let isRepresentative = DdayDataLst[indexPath.row].isRepresentative!
        
        if isRepresentative {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RepresentativeCell", for: indexPath) as? RepresentativeCollectionViewCell else { return UICollectionViewCell() }
            
            let color = DdayDataLst[indexPath.row].color
            let data = DdayDataLst[indexPath.row]
            
            switch color {
            case "YELLOW":
                cell.iconImgView.image = UIImage(named: "exDday1")
                
            case "GREEN":
                cell.iconImgView.image = UIImage(named: "exDday2")
                
            case "PINK":
                cell.iconImgView.image = UIImage(named: "exDday3")
                
            case "LIGHT_BLUE":
                cell.iconImgView.image = UIImage(named: "exDday4")
                
            default:
                cell.iconImgView.image = UIImage(named: "exDday5")
            }
            
            cell.layer.cornerRadius = 8
            cell.dDayNameLbl.text = data.title
            cell.timeLbl.text = data.endAt
            
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DdayCell", for: indexPath) as? DdayListCollectionViewCell else { return UICollectionViewCell() }
            
            let color = DdayDataLst[indexPath.row].color
            let data = DdayDataLst[indexPath.row]
            
            switch color {
            case "YELLOW":
                cell.iconImgView.image = UIImage(named: "exDday1")
                
            case "GREEN":
                cell.iconImgView.image = UIImage(named: "exDday2")
                
            case "PINK":
                cell.iconImgView.image = UIImage(named: "exDday3")
                
            case "LIGHT_BLUE":
                cell.iconImgView.image = UIImage(named: "exDday4")
                
            default:
                cell.iconImgView.image = UIImage(named: "exDday5")
            }
            
            cell.layer.cornerRadius = 8
            cell.backgroundColor = UIColor.studyCellBgColor
            cell.dDayName.text = data.title
            cell.timeLbl.text = data.endAt
            
            
            
            return cell
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Dday 편집하기 기능
        
        let vc = AddDdayViewController()
        
        vc.titleLbl.text = "디데이 편집하기"
        vc.confirmBtn.setTitle("저장하기", for: .normal)
        vc.modalPresentationStyle = .overFullScreen
        // 해당 디데이 ID 저장
        
        present(vc, animated: true)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width * 0.872
        
        if indexPath.row == 0 {
            
            let height = self.view.frame.height * 0.23510971786
            return CGSize(width: width, height: height)
            
        } else {
            
            let height = self.view.frame.height * 0.15673981191
            return CGSize(width: width, height: height)
        }
        
    }
    
}
