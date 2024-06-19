//
//  AnyShapeTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/6/19.
//

import SwiftUI

/*
 @frozen
 struct AnyShape

 A type-erased shape value.
 */
struct AnyShapeTutorial: View {

    private var isCircle = true
    var body: some View {
        Text("AnyShapeTutorial")
            .clipShape(isCircle ? AnyShape(Circle()):AnyShape(RoundedRectangle.rect(cornerRadius: 6)))
    }
}

#Preview {
    AnyShapeTutorial()
}
