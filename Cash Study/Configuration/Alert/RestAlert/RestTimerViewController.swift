//
//  RestTimerViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/30.
//

import UIKit

class RestTimerViewController: UIViewController {
    
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
    
    var timer : Timer?
    var timerCnt : Int = 300
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTimer()
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2
    }

    
    // MARK: Functions
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [self] (_) in
            self.timerCnt -= 1
            
            DispatchQueue.main.async {
                let timeString = self.makeTimeLabel(count: self.timerCnt)
                self.timerLbl.text = timeString
            }
            
            if self.timerCnt == 0 {
                dismiss(animated: true, completion: nil)
            }
            
        })
    }
    
    func makeTimeLabel(count: Int) -> String {
        let sec = timerCnt % 60
        let min = (timerCnt / 60) % 60
        
        let secString = "\(sec)".count == 1 ? "0\(sec)" : "\(sec)"
        let minString = "\(min)".count == 1 ? "0\(min)" : "\(min)"
        
        return ("\(minString):\(secString)")
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        timer?.invalidate()
        dismiss(animated: true, completion: nil)
    }
    
}
