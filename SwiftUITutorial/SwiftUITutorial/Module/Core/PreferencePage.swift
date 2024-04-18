//
//  PreferencePage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/4/15.
//

import SwiftUI

struct PreferencePage: View {

    // MARK: - system
    var body: some View {
        List(Destination.allCases, id: \.rawValue) { des in
            NavigationLink(des.rawValue.capitalized, value: des)
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle("Preference")
        // .navigationBarBackButtonHidden()
        .navigationDestination(for: Destination.self) { des in
            switch des {
            case .settingPreferences:
                SettingPreferencesTutorial()
            case .preferencesGeometry:
                PreferencesGeometryTutorial()
            }
        }
    }
}

extension PreferencePage {

    enum Destination: String, CaseIterable {
        case settingPreferences
        case preferencesGeometry
    }
}

#Preview {
    PreferencePage()
}
