//
//  CircleTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/23.
//

import SwiftUI

struct CircleTutorial: View {
    var body: some View {
        VStack(spacing: 15) {
            Circle()
                .frame(width: 100, height: 100)
                .foregroundStyle(.red)

            /*
             Ellipse椭圆，其前提是frame要有限制
             An ellipse aligned inside the frame of the view containing it.

             也就是说如果宽高一样，就是○，如果宽高不一样就是椭圆
             */
            HStack {
                Ellipse()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.pink)

                Ellipse()
                    .frame(width: 200, height: 100)
                    .foregroundStyle(.cyan)
            }

            /*
             Capsule胶囊，前提也是frame要限制
             A capsule shape aligned inside the frame of the view containing it.

             也就是说如果宽高一样，就是○，如果宽高不一样就是胶囊
             */
            HStack {
                Capsule()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.indigo)
                Capsule()
                    .frame(width: 200, height: 100)
                    .foregroundStyle(.indigo)
            }
        }
    }
}

#Preview {
    CircleTutorial()
}
