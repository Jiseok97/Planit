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
    
    var body: some View {
        
        Text("안녕하세요 !! \(name)님!!")
        
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(name: .constant(""))
        
    }
}
