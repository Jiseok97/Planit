//
//  TimerView.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/24.
//

import SwiftUI

struct TimerView: View {
    @Binding var name: String
    
    init(name: Binding<String>) {
        self._name = name
        print("이용자의 이름은 \(name)입니다.")
    }
    
    @StateObject var timerData = TimerViewModel()
    @State var progress : CGFloat = 0.0
    @State var size : CGFloat = UIScreen.main.bounds.width - 100
    
    var body: some View {
        
        ZStack {
            
            Spacer(minLength: 0)
            
            // 전체 원
            Circle()
                .trim(from: 0.0, to: 1.0)
                .stroke(Color.black.opacity(0.06), lineWidth: 15)
                .frame(width: size, height: size)
            
            // 채워지는 부분
            Circle()
                .trim(from: 0, to: self.progress)
                .stroke(Color.blue, lineWidth: 15)
                .frame(width: size, height: size)
                .animation(.default)
                
            
            // 채워지는 부분 맨 앞 원
            Circle()
                .fill(Color.blue.opacity(0.8))
                .frame(width: 35, height: 35)
                .offset(x: size / 2)
                .rotationEffect(.init(degrees: timerData.angle))
            
        }
        .rotationEffect(.init(degrees: 270))
        .onTapGesture {
            self.progress = 1.0
        }
        
        HStack(spacing: 60) {
            Button("Click", action: { start() })
        }
    
    }
    
    func start() {
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                if self.progress == 1.0 {
                    self.progress = 0.0
                } else {
                    self.progress += 0.1
                }
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(name: .constant(""))
        
    }
}



