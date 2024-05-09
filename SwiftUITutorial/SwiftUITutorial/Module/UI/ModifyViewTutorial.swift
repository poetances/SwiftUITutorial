//
//  ModifyViewTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/4/18.
//

import SwiftUI

struct ModifyViewTutorial: View {
    var body: some View {
        Text("Downtown Bus")
            .borderedCaption()
    }
}

#Preview {
    ModifyViewTutorial()
}

struct BorderedCaption: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.caption2)
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 1)
            )
            .foregroundColor(Color.blue)
    }
}

extension View {

    func borderedCaption() -> some View {
        modifier(BorderedCaption())
    }
}

// MARK: - EmptyModifier
struct EmptyViewModifierContentView: View {
    var body: some View {
        Text("Hello, World!")
            .modifier(modifier)
    }


    var modifier: some ViewModifier {
        #if DEBUG
            return BorderedCaption()
        #else
            return EmptyModifier()
        #endif
    }
}



