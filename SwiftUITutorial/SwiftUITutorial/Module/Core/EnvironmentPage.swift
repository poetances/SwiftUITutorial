//
//  EnvironmentPage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/4/12.
//

import SwiftUI

struct EnvironmentPage: View {
    var body: some View {
        List(Destination.allCases, id: \.rawValue) { des in
            NavigationLink(des.rawValue.capitalized, value: des)
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle("Environment")
        .navigationBarTitleDisplayMode(.automatic)
        .navigationDestination(for: Destination.self) { des in
            switch des {
            case .action:
                EnvironmetActionTutorial()
            case .authorization:
                EnvironmentAuthorizationTutorial()
            case .controlsAndInput:
                EnvironmentControlsAndInputTutorial()
            case .display:
                EnvironmentDisplayTutorial()
            case .global:
                EnvironmentGlobalTutorial()
            case .scrolling:
                EnvironmentScrollingTutorial()
            case .state:
                EnvironmentStateTutorial()
            case .textStyle:
                EnvironmentStateTutorial()
            case .viewAttribute:
                EnvironmentViewAttributeTutorial()
            }
        }
        .environment(\.customBook, ModelDataBook())
    }
}

extension EnvironmentPage {

    enum Destination: String, CaseIterable {

        case action
        case authorization
        case controlsAndInput
        case display
        case global
        case scrolling
        case state
        case textStyle
        case viewAttribute
    }
}

#Preview {
    EnvironmentPage()
}

struct BookKey: EnvironmentKey {
    static var defaultValue = ModelDataBook()
}

extension EnvironmentValues {
    var customBook: ModelDataBook {
        get { self[BookKey.self] }
        set { self[BookKey.self] = newValue }
    }
}
