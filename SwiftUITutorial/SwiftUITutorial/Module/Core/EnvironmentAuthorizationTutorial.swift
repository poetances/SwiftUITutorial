//
//  EnvironmentAuthorizationTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/4/12.
//

import SwiftUI

struct EnvironmentAuthorizationTutorial: View {

    /// struct AuthorizationController
    @Environment(\.authorizationController) private var authorizationController

    @Environment(\.webAuthenticationSession) private var webAuthenticationSession

    // MARK: - system
    var body: some View {
        VStack(spacing: 15) {

            Button("AuthorizationController") {
                Task {

                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle("Authorization")
    }
}

#Preview {
    EnvironmentAuthorizationTutorial()
}
