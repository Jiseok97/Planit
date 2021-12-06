//
//  DailyReportViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/06.
//

import UIKit

class DailyReportViewController: UIViewController {

    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var studyAnalysisCV: UICollectionView!
    @IBOutlet weak var cvHeight: NSLayoutConstraint!
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        studyAnalysisCV.delegate = self
        studyAnalysisCV.dataSource = self
        studyAnalysisCV.backgroundColor = .mainNavy.withAlphaComponent(0.0)
        studyAnalysisCV.register(UINib(nibName: "EmptyReportCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "emptyReportCell")
        
        if let collectionViewLayout = studyAnalysisCV.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    override func viewDidLayoutSubviews() {
        self.changeHeight()
    }


    // MARK: Functions
//    @IBAction func showCalendarTapped(_ sender: Any) {
//    }
//
}


extension DailyReportViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func changeHeight() {
        self.cvHeight.constant = self.studyAnalysisCV.collectionViewLayout.collectionViewContentSize.height
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyReportCell", for: indexPath) as? EmptyReportCollectionViewCell else { return UICollectionViewCell() }
        
        cell.layer.borderColor = UIColor.homeBorderColor.cgColor
        cell.layer.borderWidth = 0.8
        cell.layer.cornerRadius = 8
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.studyAnalysisCV.bounds.width * 0.88
        let height = self.view.frame.height * 0.157857142857143
        
        return CGSize(width: width, height: height)
    }
    
}
