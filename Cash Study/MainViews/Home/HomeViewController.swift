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
    
    var studyDataLst : [String] = ["Empty"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        studyLstCV?.delegate = self
        studyLstCV?.dataSource = self
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
    
    
    func setUI() {
        addDdayBtn.layer.borderColor = UIColor.homeBorderColor.cgColor
        addDdayBtn.layer.borderWidth = 1
        addDdayBtn.layer.cornerRadius = 8
        
        addStudyBtn.layer.borderColor = UIColor.myGray.cgColor
        addStudyBtn.layer.borderWidth = 1
        addStudyBtn.layer.cornerRadius = addStudyBtn.frame.height / 2
        
        studyLstCV.layer.cornerRadius = 8
    }
}


extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func changeHeight() {
        self.studyLstCVHeight.constant = self.studyLstCV.collectionViewLayout.collectionViewContentSize.height
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
            
            
            return UICollectionViewCell()
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
