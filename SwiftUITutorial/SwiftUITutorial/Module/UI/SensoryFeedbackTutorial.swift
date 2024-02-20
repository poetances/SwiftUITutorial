//
//  SensoryFeedbackTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/20.
//

import SwiftUI

/*
 SensoryFeedback感知回馈：

 里面有很多回馈类型：
 但是在iOS中不多：
 static let selection: SensoryFeedback
 static let success: SensoryFeedback
 static let warning: SensoryFeedback
 static let error: SensoryFeedback
 static let impact: SensoryFeedback

 里面有两个重要结构体：
 SensoryFeedback.Flexibility
 SensoryFeedback.Weight
 */
struct SensoryFeedbackTutorial: View {

    @State private var showAccessory = false

    // MARK: - system
    var body: some View {

        VStack(spacing: 15) {
            
            Text("SensoryFeedback")
                .sensoryFeedback(.impact(weight: .heavy, intensity: 2), trigger: showAccessory)
                .onLongPressGesture {
                    showAccessory.toggle()
                }
        }
        .padding()
    }
}

#Preview {
    SensoryFeedbackTutorial()
}
