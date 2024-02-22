//
//  CommandsTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/21.
//

import SwiftUI

/*
 commands(content:)在SwiftUI中主要用于为macOS应用添加键盘命令或菜单命令。它允许开发者自定义顶部菜单栏中的菜单项或添加快捷键等。这是因为macOS应用通常包含更复杂的用户界面和交互模式，顶部菜单栏是macOS用户界面的一个核心元素，而这在iOS上并不适用。iOS应用往往更侧重于触摸交互，而不是通过菜单和快捷键进行操作。

 随着iPadOS 13及之后版本的推出，iPad开始支持更多的键盘快捷键和一些类似于macOS的特性，例如通过键盘快捷键触发操作，这使得commands(content:)在某些情况下对于提升iPad应用的体验变得可行和有用。

 On iPadOS, commands with keyboard shortcuts are exposed in the shortcut discoverability HUD that users see when they hold down the Command (⌘) key.
 也就是在iPadOS上，如果键盘有Command键，是可以组合试用的。
 */
struct CommandsTutorial: View {
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    CommandsTutorial()
}
