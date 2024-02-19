//
//  ButtonTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/19.
//

import SwiftUI
import AuthenticationServices

/*
 可以关注几个重要的结构体：

 ButtonBoardStyle
 ButtonRole
 ButtonRepeatBehaviours
 */
struct ButtonTutorial: View {
    var body: some View {
        VStack(spacing: 15) {
            Button("Sign In", action: signIn)
            Divider()
            // For example, on iOS, buttons only display their icons by default when placed in toolbars, but show both a leading title and trailing icon in menus. Defining labels this way also helps with accessibility — for example, applying the labelStyle(_:) modifier with an iconOnly style to the button will cause it to only visually display its icon, but still use its title to describe the button in accessibility modes like VoiceOver:
            Button("Sign In", systemImage: "arrow.up", action: signIn)
            Button(action: signIn) {
                Label("Sign In", systemImage: "arrow.up")
            }
            .labelStyle(.iconOnly)
            Divider()

            // 按钮角色
            Button("Delete", role: .destructive, action: delete)
            Button("Cancel", role: .cancel, action: delete)
            Divider()

            Button("Delete", action: delete)
                .buttonBorderShape(.roundedRectangle(radius: 10))
            Divider()

            Button {
                print("--", Date())
            } label: {
                Label("Speed up", systemImage: "hare")
            }
            .buttonRepeatBehavior(.enabled)
            Divider()

            // 苹果登录按钮
            SignInWithAppleButton { request in

            } onCompletion: { result in

            }
            .frame(width: 150, height: 46)
            .signInWithAppleButtonStyle(.black)
        }
    }
}

/*
 Button有一个重要的结构体，ButtonBoardShape其继承关系有点复杂，我们可以记一下。
 Animatable
 Equatable
 InsettableShape
 Sendable
 Shape
 View

 */

extension ButtonTutorial {

    func signIn() {

    }

    func regist() {

    }

    func delete() {

    }
}


#Preview {
    ButtonTutorial()
}
