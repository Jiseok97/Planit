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
    
    var dDayLst : [String] = ["Test", "Test02", "Test03"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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


extension DdayPageViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func changeHeight() {
        self.cvHeight.constant = self.dDayCV.collectionViewLayout.collectionViewContentSize.height
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dDayLst.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RepresentativeCell", for: indexPath) as? RepresentativeCollectionViewCell else { return UICollectionViewCell() }
            
            cell.layer.cornerRadius = 8
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DdayCell", for: indexPath) as? DdayListCollectionViewCell else { return UICollectionViewCell() }
            
            cell.layer.cornerRadius = 8
            cell.backgroundColor = UIColor.studyCellBgColor
            cell.dDayName.text = dDayLst[indexPath.row]
            
            return cell
        }
        
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
