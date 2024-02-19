//
//  ButtonStyleTutorail.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/18.
//

import SwiftUI
import AuthenticationServices

/*
 buttonStyle(_:)
 func buttonStyle<S>(_ style: S) -> some View where S : ButtonStyle

 ButtonStyle是一个协议。
 To configure the current button style for a view hierarchy, use the buttonStyle(_:) modifier. Specify a style that conforms to ButtonStyle when creating a button that uses the standard button interaction behavior defined for each platform. To create a button with custom interaction behavior, use PrimitiveButtonStyle instead.

 也就是一般我们使用PrimitiveButtonStyle，其具有自定义交互行为.

 总的来说，ButtonStyle 更多地用于自定义按钮的视觉风格，而 PrimitiveButtonStyle 提供了对按钮行为的底层控制。根据你的需求，你可以选择使用这两者中的任何一个来实现你的设计目标。

 */
struct ButtonStyleTutorial: View {
    var body: some View {
        VStack(spacing: 15) {
            Button("Sign In", action: signIn)
            Button("Regist", action: regist)

            // For example, on iOS, buttons only display their icons by default when placed in toolbars, but show both a leading title and trailing icon in menus. Defining labels this way also helps with accessibility — for example, applying the labelStyle(_:) modifier with an iconOnly style to the button will cause it to only visually display its icon, but still use its title to describe the button in accessibility modes like VoiceOver:
            Button("Sign In", systemImage: "arrow.up", action: signIn)
            Button(action: signIn) {
                Label("Sign In", systemImage: "arrow.up")
            }
            .labelStyle(.iconOnly)

            // 按钮角色
            Button("Delete", role: .destructive, action: delete)
            Button("Cancel", role: .cancel, action: delete)

            //
            Button("Delete", action: delete)
                .buttonBorderShape(.roundedRectangle(radius: 10))

            Button {
                print("--", Date())
            } label: {
                Label("Speed up", systemImage: "hare")
            }
            .buttonRepeatBehavior(.enabled)

            // 苹果登录按钮
            SignInWithAppleButton { request in

            } onCompletion: { result in

            }
            .frame(width: 150, height: 46)
            .signInWithAppleButtonStyle(.black)
        }
        .buttonStyle(.bordered)
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

extension ButtonStyleTutorial {

    func signIn() {

    }

    func regist() {

    }

    func delete() {

    }
}

#Preview {
    ButtonStyleTutorial()
}
