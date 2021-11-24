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
    var studyDataLst : [String] = ["Empty", "hello", "Empty", "Test", "HiCV", "중간고사"]
    
    
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
        rprDdayCV.register(UINib(nibName: "HaveRprDdayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "rprDdayCell")
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    
    // MARK: Functions
    func setUI() {
        
        addStudyBtn.layer.borderColor = UIColor.myGray.cgColor
        addStudyBtn.layer.borderWidth = 1
        addStudyBtn.layer.cornerRadius = addStudyBtn.frame.height / 2
        
//        guard let name = UserInfoData.name as? String else { return }
//        self.topLbl.text = "\(name) 님의 \n 공부를 응원합니다."
    }
    
    @IBAction func moveAddStudyBtn(_ sender: Any) {
        let vc = AddStudyViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    
}


extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func changeHeight() {
        self.studyLstCVHeight.constant = self.studyLstCV.collectionViewLayout.collectionViewContentSize.height
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == studyLstCV {
            if studyDataLst.count > 1 {
                // 데이터가 비어있지 않을 경우, Cell 클릭 → 타이머 이동
                // 타이머 뷰
                
                let vc = TimerStopViewController(title: "테스트 공부하기")
                vc.modalPresentationStyle = .overFullScreen
                present(vc, animated: true, completion: nil)
            }
        } else {
            print("Tapped")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == studyLstCV {
            return studyDataLst.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == rprDdayCV {
            if haveRprDday {
                // 대표 디데이 있을 때
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rprDdayCell", for: indexPath) as? HaveRprDdayCollectionViewCell else { return UICollectionViewCell() }

                
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
            if studyDataLst.count == 1 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyCell", for: indexPath) as? EmptyStudyCollectionViewCell else { return UICollectionViewCell() }
                
                cell.layer.cornerRadius = 8
                cell.layer.borderWidth = 1
                cell.layer.borderColor = UIColor.homeBorderColor.cgColor
                
                return cell
                
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "haveCell", for: indexPath) as? HaveStudyCollectionViewCell else { return UICollectionViewCell() }
                
                cell.nameLbl.text = studyDataLst[indexPath.row]
                cell.layer.cornerRadius = 8
                cell.backgroundColor = UIColor.studyCellBgColor
                
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width * 0.872
        
        if collectionView == studyLstCV {
            if studyDataLst.count == 1 {
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
