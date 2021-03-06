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
        
        dDayCV.delegate = self
        dDayCV.dataSource = self
        
        dDayCV.backgroundColor = UIColor.mainNavy.withAlphaComponent(0.0)
        dDayCV.register(UINib(nibName: "DdayListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DdayCell")
        dDayCV.register(UINib(nibName: "RepresentativeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RepresentativeCell")
        dDayCV.register(UINib(nibName: "NoDdayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NoDdayCell")
        dDayCV.contentInset.bottom = 60
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showIndicator()
        ShowDdayDataManager().showDday(viewController: self)
        dDayCV.reloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCV(_:)), name: NSNotification.Name("reload"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("reload"), object: nil)
    }
    
    
    // MARK: Funcitons
    @objc func reloadCV(_ noti: Notification) {
        showIndicator()
        ShowDdayDataManager().showDday(viewController: self)
    }
}


// MARK: Extension
extension DdayPageViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if DdayDataLst != nil {
            return DdayDataLst!.ddays.count
        } else {
            /// 디데이가 없을 때
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if DdayDataLst != nil && DdayDataLst!.ddays.count != 0 {
            /// 레이아웃(컬렉션 뷰)
            /// estimatedItemSize → Index 오류, 왜 오류가 나는지 알아보기
//            if let collectionViewLayout = dDayCV.collectionViewLayout as? UICollectionViewFlowLayout {
//                collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//            }
            
            if DdayDataLst?.ddays[indexPath.row].isRepresentative == true {
                // 대표 디데이
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RepresentativeCell", for: indexPath) as? RepresentativeCollectionViewCell else { return UICollectionViewCell() }
                
                cell.layer.cornerRadius = 8
                cell.configure(with: DdayDataLst!, idx: indexPath.row)
                
                return cell
                
            } else {
                // 일반 디데이
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DdayCell", for: indexPath) as? DdayListCollectionViewCell else { return UICollectionViewCell() }

                cell.layer.cornerRadius = 8
                cell.backgroundColor = UIColor.studyCellBgColor
                cell.configure(with: DdayDataLst!, idx: indexPath.row)
                
                return cell
            }
            
        } else {
            // 디데이가 없다는 cell 출력
            collectionView.isScrollEnabled = false
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoDdayCell", for: indexPath) as? NoDdayCollectionViewCell else { return UICollectionViewCell() }
            return cell
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Dday 편집하기 기능
        if DdayDataLst != nil && DdayDataLst!.ddays.count != 0 {
            guard let id = DdayDataLst?.ddays[indexPath.row].id else { return }
            guard let title = DdayDataLst?.ddays[indexPath.row].title else { return }
            guard let isRepresent = DdayDataLst?.ddays[indexPath.row].isRepresentative else { return }
            guard let endAtTxt = DdayDataLst?.ddays[indexPath.row].endAt else { return }
            guard let icon = DdayDataLst?.ddays[indexPath.row].icon else { return }
            
            let date = DateFormatter()
            date.locale = Locale(identifier: "ko_KR")
            date.dateFormat = "yyyy-MM-dd"
            
            guard let endDateText = date.date(from: endAtTxt) else { return }
            
            let df = DateFormatter()
            df.locale = Locale(identifier: "ko_KR")
            df.dateFormat = "yyyy년 MM월 dd일 (E)"
            
            let vc = AddDdayViewController(id: id, title: title, editEndTxt: endAtTxt ,endTxt: df.string(from: endDateText), iconTxt: icon, isEdit: true, isRepresentative: isRepresent, homeAddDday: false)
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.bounds.width * 0.872
        
        if DdayDataLst != nil && DdayDataLst!.ddays.count != 0 {
            if  DdayDataLst?.ddays[indexPath.row].isRepresentative == true {
                /// 대표 디데이
                return CGSize(width: width, height: 150)
            } else {
                /// 일반 디데이
                return CGSize(width: width, height: 100)
            }
        } else {
            /// 디데이가 없을 때
            let height = UIScreen.main.bounds.height - collectionView.frame.height / 2
            return CGSize(width: width, height: height)
        }
    }
}

extension DdayPageViewController {
    func showDday(result : ShowDdayEntity) {
        dismissIndicator()
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
            if (DdayDataLst?.ddays.count)! >= 1 {
                let data = DdayDataLst?.ddays[idx]
                DdayDataLst?.ddays.insert(data!, at: 0)
                DdayDataLst?.ddays.remove(at: idx + 1)
            }
        }
    }
}

