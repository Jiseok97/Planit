//
//  HomeViewController.swift
//  Planit
//
//  Created by 이지석 on 2021/11/03.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addStudyBtn: UIButton!
    @IBOutlet weak var addDdayBtn: UIButton!
    @IBOutlet weak var studyLstCV: UICollectionView!
    @IBOutlet weak var studyLstCVHeight: NSLayoutConstraint!
    @IBOutlet weak var ctView: UIView!
    
    
    var studyDataLst : [String] = ["Empty", "hello", "Empty", "hello", "Empty", "hello", "Empty", "hello", "Empty", "hello"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setGradation()
        
        studyLstCV?.delegate = self
        studyLstCV?.dataSource = self
        studyLstCV.backgroundColor = UIColor.mainNavy
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
    
    func setGradation() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.gradationStartColor.cgColor, UIColor.mainNavy.cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.zPosition = 0
//        self.view.layer.addSublayer(gradientLayer)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func setUI() {
        addDdayBtn.layer.borderColor = UIColor.homeBorderColor.cgColor
        addDdayBtn.layer.borderWidth = 1
        addDdayBtn.layer.cornerRadius = 8
        
        addStudyBtn.layer.borderColor = UIColor.myGray.cgColor
        addStudyBtn.layer.borderWidth = 1
        addStudyBtn.layer.cornerRadius = addStudyBtn.frame.height / 2
        
        studyLstCV.layer.cornerRadius = 8
        studyLstCV.layer.zPosition = 999
    }
    
    
    
//    func customNavBarLeft(title: String) {
//        let containerView = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 70))
//        let topLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 15))
//        topLabel.numberOfLines = 1
//        topLabel.textAlignment = .left
//        topLabel.font = .systemFont(ofSize: 11.5)
//        topLabel.textColor = .black
//        topLabel.text = "지금 보고있는 지역은"
//
//        let bottomLabel = UILabel(frame: CGRect(x: 0, y: topLabel.frame.height, width: 200, height: 20))
//        bottomLabel.numberOfLines = 1
//        bottomLabel.textAlignment = .left
//        bottomLabel.font = .systemFont(ofSize: 18)
//        bottomLabel.textColor = .black
//        bottomLabel.text = title
//        bottomLabel.sizeToFit()
//    }
    
    
}


extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func changeHeight() {
        self.studyLstCVHeight.constant = self.studyLstCV.collectionViewLayout.collectionViewContentSize.height
//        self.studyLstCVHeight.constant = CGFloat(studyDataLst.count * 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if studyDataLst.count > 1 {
            // 데이터가 비어있지 않을 경우, Cell 클릭 → 타이머 이동
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return studyDataLst.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if studyDataLst.count == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyCell", for: indexPath) as? EmptyStudyCollectionViewCell else { return UICollectionViewCell() }
            
            cell.backgroundColor = UIColor.mainNavy
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width * 0.872
        if studyDataLst.count == 1 {
            let height = self.view.frame.height * 0.27586206896
            return CGSize(width: width, height: height)
        } else {
            let height = self.view.frame.height * 0.12068965517
            return CGSize(width: width, height: height)
        }
    }
    
}
