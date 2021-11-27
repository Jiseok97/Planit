//
//  HomeViewController.swift
//  Planit
//
//  Created by 이지석 on 2021/11/03.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var topLbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addStudyBtn: UIButton!
    @IBOutlet weak var studyLstCV: UICollectionView!
    @IBOutlet weak var studyLstCVHeight: NSLayoutConstraint!
    @IBOutlet weak var rprDdayCV: UICollectionView!
    
    var haveRprDday : Bool = false
    var todayStudyLst : ShowDateStudyEntity?
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setGradation()
        
        rprDdayCV?.delegate = self
        rprDdayCV?.dataSource = self
        studyLstCV?.delegate = self
        studyLstCV?.dataSource = self
        
        rprDdayCV.backgroundColor = UIColor.mainNavy.withAlphaComponent(0.0)
        rprDdayCV.register(UINib(nibName: "RepresentativeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RepresentativeCell")
        rprDdayCV.register(UINib(nibName: "EmptyDdayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "emptyDdayCell")
        
        studyLstCV.backgroundColor = UIColor.mainNavy.withAlphaComponent(0.0)
        studyLstCV.register(UINib(nibName: "HaveStudyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "haveCell")
        studyLstCV.register(UINib(nibName: "EmptyStudyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "emptyCell")
        
        if let collectionViewLayout = studyLstCV.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }

    
    override func viewDidLayoutSubviews() {
        self.changeHeight()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        let td = DateFormatter()
        td.dateFormat = "yyyy-MM-dd"
        ShowDateStudyDataManager().homeStudy(date: td.string(from: Date()), viewController: self)
        studyLstCV.reloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(addStudy(_:)), name: NSNotification.Name("reloadHome"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("reloadHome"), object: nil)
    }
    
    // MARK: Functions
    func setUI() {
        
        addStudyBtn.layer.borderColor = UIColor.myGray.cgColor
        addStudyBtn.layer.borderWidth = 1
        addStudyBtn.layer.cornerRadius = addStudyBtn.frame.height / 2
    }
    
    @IBAction func moveAddStudyBtn(_ sender: Any) {
        let vc = AddStudyViewController(stGrId: 0, stSchId: 0, title: "", isEdit: false)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    @objc func addStudy(_ noti: Notification) {
        changeRootVC(BaseTabBarController())
    }
    
    
}


extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func changeHeight() {
        self.studyLstCVHeight.constant = self.studyLstCV.collectionViewLayout.collectionViewContentSize.height
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == studyLstCV {
            if todayStudyLst?.studies != nil {
                // 타이머 뷰
                guard let titleTxt = todayStudyLst?.studies[indexPath.row].title else { return }
                        
                let vc = TimerStopViewController(title: titleTxt)
                vc.modalPresentationStyle = .overFullScreen
                present(vc, animated: true, completion: nil)
            }
        } else {
            print("Tapped")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == studyLstCV {
            if todayStudyLst?.studies != nil {
                return todayStudyLst!.studies.count
            } else {
                return 1
            }
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == rprDdayCV {
            if haveRprDday {
                // 대표 디데이 있을 때
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RepresentativeCell", for: indexPath) as? RepresentativeCollectionViewCell else { return UICollectionViewCell() }

                
                return cell
            } else {
                // 대표 디데이 없을 때
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyDdayCell", for: indexPath) as? EmptyDdayCollectionViewCell else { return UICollectionViewCell() }
                
                cell.layer.borderColor = UIColor.homeBorderColor.cgColor
                cell.backgroundColor = UIColor.mainNavy.withAlphaComponent(0.0)
                cell.layer.borderWidth = 1
                cell.layer.cornerRadius = 8
                
                return cell
                
            }
        } else {
            if todayStudyLst?.studies != nil {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "haveCell", for: indexPath) as? HaveStudyCollectionViewCell else { return UICollectionViewCell() }
                
                cell.layer.cornerRadius = 8
                cell.backgroundColor = UIColor.studyCellBgColor
                
                cell.nameLbl.text = todayStudyLst?.studies[indexPath.row].title
                
                if todayStudyLst?.studies[indexPath.row].recordedTime != 0 {
                    let time = todayStudyLst?.studies[indexPath.row].recordedTime
                    let hour = time! / 3600
                    let min = (time! / 60) % 60
                    let sec = time! % 60
                    let timeTxt = "\(hour)시간 \(min)분 \(sec)초"
                    let restCnt = todayStudyLst?.studies[indexPath.row].rest
                    let changeText = "측정시간 \(timeTxt) • 휴식횟수 \(String(describing: restCnt!))회"
                    
                    cell.subLbl.text = changeText
                    cell.subLbl.textColor = UIColor.link
                }
                
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyCell", for: indexPath) as? EmptyStudyCollectionViewCell else { return UICollectionViewCell() }
                
                cell.layer.cornerRadius = 8
                cell.layer.borderWidth = 1
                cell.layer.borderColor = UIColor.homeBorderColor.cgColor
                
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width * 0.872
        
        if collectionView == studyLstCV {
            if todayStudyLst?.studies == nil {
                let height = self.view.frame.height * 0.27586206896
                return CGSize(width: width, height: height)
            } else {
                let height = self.view.frame.height * 0.12068965517
    //            let height = self.view.frame.height * 0.132
                return CGSize(width: width, height: height)
            }
        } else {
            return CGSize(width: width, height: 92)
        }
    }
}


extension HomeViewController {
    func homeStudy(result : ShowDateStudyEntity) {
        self.todayStudyLst = result
        self.studyLstCV.reloadData()
    }
}
