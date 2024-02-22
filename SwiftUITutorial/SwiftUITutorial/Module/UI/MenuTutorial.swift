//
//  MenuTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/20.
//

import SwiftUI

/*
 Menu的title同样不起作用，这点和Picker类似，可用於 accessibility 說明元件的目的，比方搭配 VoiceOver 功能。

 Menu也有相应的MenuStyle
 ButtonMenuStyle
 DefaultMenuStyle
 */
struct MenuTutorial: View {

    @State private var isShow = false
    @State private var selection = 0

    // MARK: - system
    var body: some View {
        VStack(spacing: 15) {
            Button("popover") {
                isShow.toggle()
            }

            menu
            menu_lable
            menu_primary_action

            Divider()
            showingMenuIndicator

            Divider()
            menuDismissal

            Divider()
            menuOrder
        }
        .popover(isPresented: $isShow, content: {
            VStack {
                Button("Dismiss") {
                    isShow.toggle()
                }
            }
            .presentationCompactAdaptation(.popover)
        })
    }

    func itemTap() {

    }
}

extension MenuTutorial {

    var menu: some View {
        Menu("Menu") {
            Button("One", action: itemTap)
            Button("Two", action: itemTap)
            Menu("Second") {
                Button("Second One", action: itemTap)
                Button("Second Two", action: itemTap)
            }
        }
    }

    var menu_lable: some View {
        Menu {
            Button("One", action: itemTap)
            Button("Two", action: itemTap)
        } label: {
            Label("Menu Label", systemImage: "square.and.arrow.up.on.square")
        }
        .menuStyle(.button)
    }

    /*
     primary(主要的)
     primaryAction能够改变Menu的行为，默认点击触发，当添加primaryAction之后，点击触发primaryAction行为，
     长按才触发Menu
     */
    var menu_primary_action: some View {
        Menu("Menu action") {
            Button("One", action: itemTap)
            Button("Two", action: itemTap)
        } primaryAction: {
            print("primary action start")
        }
    }
}

// MARK: - menuIndicator(.visible)
extension MenuTutorial {

    /*
     Picker默认的样式是Menu，而且是带有MenuIndicator的，所以改修饰符更多的是用在picker上。
     */
    var showingMenuIndicator: some View {
        Picker("MenuIndicator", selection: $selection) {
            Text("One").tag(0)
            Text("Two").tag(1)
        }
        .tint(.red)
        .menuIndicator(.hidden)
    }
}

// MARK: - menuActionDismissBehavior(.enabled)
extension MenuTutorial {

    /*
     menuActionDismissBehavior，定义了点击MenuAction时候，Menu的隐藏方式，默认是点击action就隐藏，我们可以设置成不隐藏。

     MenuActionDismissBehavior结构体定义了两种类型：
     automatic
     enabled
     disabled
     */
    var menuDismissal: some View {
        Text("MenuDismissal")
            .padding()
            .contextMenu {
                Button("♥️ - Hearts", action: itemTap)
                Button("♣️ - Clubs", action: itemTap)
                Button("♠️ - Spades", action: itemTap)
                Button("♦️ - Diamonds", action: itemTap)
            }
            .menuActionDismissBehavior(.disabled)
    }
}

// MARK: - menuOrder(_:)
extension MenuTutorial {
    
    /*
     MenuOrder定义了Menu的顺序。
     */
    var menuOrder: some View {
        Menu {
            Button("Select", action: itemTap)
            Button("New Folder", action: itemTap)

        } label: {
            Label("MenuOrder", systemImage: "ellipsis.circle")
        }
        .menuOrder(.fixed)
    }
}

#Preview {
    MenuTutorial()
}
