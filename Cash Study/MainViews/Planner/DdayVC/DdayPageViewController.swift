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
    
    var DdayDataLst : ShowDdayEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        dDayCV.contentInset.bottom = 60
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ShowDdayDataManager().showDday(viewController: self)
        dDayCV.reloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCV(_:)), name: NSNotification.Name("reload"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("reload"), object: nil)
    }
    
    
    // MARK: Funcitons
    @objc func reloadCV(_ noti: Notification) {
        ShowDdayDataManager().showDday(viewController: self)
    }
}


// MARK: Extension
extension DdayPageViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
                
                switch DdayDataLst?.ddays[indexPath.row].icon {
                case "PLANET" :
                    cell.iconImgView.image = UIImage(named: "Planet")
                    
                case "PLANET_WITH_RINGS":
                    cell.iconImgView.image = UIImage(named: "PlanetRing")
                    
                case "STAR":
                    cell.iconImgView.image = UIImage(named: "Star")
                    
                case "FLAME":
                    cell.iconImgView.image = UIImage(named: "Flame")
                    
                default:
                    cell.iconImgView.image = UIImage(named: "Ufo")
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
                
                switch DdayDataLst?.ddays[indexPath.row].icon {
                    
                case "PLANET" :
                    cell.iconImgView.image = UIImage(named: "Planet")
                    
                case "PLANET_WITH_RINGS":
                    cell.iconImgView.image = UIImage(named: "PlanetRing")
                    
                case "STAR":
                    cell.iconImgView.image = UIImage(named: "Star")
                    
                case "FLAME":
                    cell.iconImgView.image = UIImage(named: "Flame")
                    
                default:
                    cell.iconImgView.image = UIImage(named: "Ufo")
                }
                
                cell.dDayName.text = DdayDataLst?.ddays[indexPath.row].title
                cell.timeLbl.text = DdayDataLst?.ddays[indexPath.row].endAt
                
                return cell
            }
            
        } else {
            // 디데이가 없다는 cell 출력
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoDdayCell", for: indexPath) as? NoDdayCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Dday 편집하기 기능
        guard let id = DdayDataLst?.ddays[indexPath.row].id else { return }
        guard let title = DdayDataLst?.ddays[indexPath.row].title else { return }
        guard let isRepresent = DdayDataLst?.ddays[indexPath.row].isRepresentative else { return }
        
        let vc = AddDdayViewController(id: id, title: title, isEdit: true, isRepresentative: isRepresent)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.bounds.width * 0.872
        
        if DdayDataLst != nil {
            if  DdayDataLst?.ddays[indexPath.row].isRepresentative == true {
                
                let height = self.view.bounds.height * 0.23510971786
                return CGSize(width: width, height: height)
                
            } else {
                
                let height = self.view.bounds.height * 0.15673981191
                return CGSize(width: width, height: height)
            }
        } else {
            // 디데이가 없을 때
            
            return CGSize(width: self.view.bounds.width / 2 + 30, height: view.bounds.height / 2 + 50)
        }
    }
    
}

extension DdayPageViewController {
    func showDday(result : ShowDdayEntity) {
        self.DdayDataLst = result
        self.dDayCV.reloadData()
        DdayDataLst?.ddays.sort{ $0.endAt < $1.endAt}
        
        if DdayDataLst != nil {
            var idx : Int = 0
            for i in 0..<DdayDataLst!.ddays.count {
                if DdayDataLst?.ddays[i].isRepresentative == true {
                     idx = i
                }
            }
            guard let data = DdayDataLst?.ddays[idx] as? dday else { return }
            DdayDataLst?.ddays.insert(data, at: 0)
            DdayDataLst?.ddays.remove(at: idx + 1)
        }
    }
}

