//
//  AnimationsPage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/22.
//

import SwiftUI

/*
 三种方式添加动画
 To avoid abrupt visual transitions when the state changes, add animation in one of the following ways:

 Animate all of the visual changes for a state change by changing the state inside a call to the withAnimation(_:_:) global function.

 Add animation to a particular view when a specific value changes by applying the animation(_:value:) view modifier to the view.

 Animate changes to a Binding by using the binding’s animation(_:) method.

 */
struct AnimationsPage: View {

    private let contents: [Content] = [
        .init(title: "AddingAnimationAction", destination: .addingAnimationAction)
    ]
    // MARK: - system
    var body: some View {
        List(contents) { content in
            NavigationLink(content.title, value: content.destination)
        }
        .navigationDestination(for: Destination.self) { des in
            switch des {
            case .addingAnimationAction:
                AddingAnimationActionTutorial()
            }
        }
    }
}

extension AnimationsPage {

    enum Destination: CaseIterable {
        case addingAnimationAction
    }

    struct Content: Identifiable {

        let id = UUID()

        let title: String
        let destination: Destination
    }
}

#Preview {
    AnimationsPage()
}
