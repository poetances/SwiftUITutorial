//
//  MenuStyleTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/20.
//

import SwiftUI

/*
 BorderedButtonMenuStyle
 BorderlessButtonMenuStyle
 ButtonMenuStyle
 DefaultMenuStyle

 iOS上只能使用buttonMenu
 */
struct MenuStyleTutorial: View {
    var body: some View {
        VStack(spacing: 15, content: {
            Menu("Menu") {
                Button("copy") {

                }

                Button("past") {

                }
            }
            .menuStyle(.automatic)

            Menu("Menu2") {
                Button("copy") {

                }
                Button("past") {

                }

                Menu("Other") {
                    Button("Rename") {

                    }
                    Button("Create") {

                    }
                }
                .menuStyle(.button)
            }
            .menuStyle(.automatic)
        })
    }
}

#Preview {
    MenuStyleTutorial()
}
