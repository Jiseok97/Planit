//
//  TimerViewModel.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/24.
//

import SwiftUI

class TimerViewModel : ObservableObject {
    
    @Published var isStart : Bool = false
    @Published var angle : Double = 0.0
    
//    func updateTimer() {
//        withAnimation(Animation.linear(duration: 0.1)) {
//            self.angle = Double()
//        }
//    }
}
