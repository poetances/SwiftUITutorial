//
//  SecureTextFieldTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/21.
//

import SwiftUI

/*
 密文输入
 */
struct SecureTextFieldTutorial: View {

    @State private var text = ""
    // MARK: - system
    var body: some View {
        VStack(spacing: 15) {

            SecureField("Secure", text: $text)
        }
        .padding()
    }
}

#Preview {
    SecureTextFieldTutorial()
}
