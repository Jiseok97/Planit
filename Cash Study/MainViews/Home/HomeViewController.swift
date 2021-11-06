//
//  HomeViewController.swift
//  Planit
//
//  Created by 이지석 on 2021/11/03.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var studyLstTV: UITableView!
    @IBOutlet weak var studyLstTVHeight: NSLayoutConstraint!
    @IBOutlet weak var addStudyBtn: UIButton!
    @IBOutlet weak var addDdayBtn: UIButton!
    
    var studyDataLst : [String] = ["Empty", "Have", "Hello", "MyStudy", "GoOut", "sleep"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        studyLstTV.register(UINib(nibName: "EmptyStudyTableViewCell", bundle: nil), forCellReuseIdentifier: "emptyCell")
        studyLstTV.register(UINib(nibName: "HaveStudyTableViewCell", bundle: nil), forCellReuseIdentifier: "haveCell")
    }
    
    override func viewDidLayoutSubviews() {
//        self.changeHeight()
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
        
        studyLstTV.delegate = self
        studyLstTV.dataSource = self
        studyLstTV.backgroundColor = UIColor.mainNavy
        studyLstTV.layer.cornerRadius = 8
    }
}


extension HomeViewController : UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func changeHeight() {
//        self.studyLstTVHeight.constant = self.view.intrinsicContentSize.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studyDataLst.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if studyDataLst.count == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "emptyCell", for: indexPath) as? EmptyStudyTableViewCell else { return UITableViewCell() }
            
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.homeBorderColor.cgColor
            cell.layer.cornerRadius = 8
            
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "haveCell", for: indexPath) as? HaveStudyTableViewCell else { return UITableViewCell() }
            
            cell.studyTitleLbl.text = studyDataLst[indexPath.row]
            
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if studyDataLst.count == 1 {
            return 224
        } else {
            return 120
        }
    }
    
}
