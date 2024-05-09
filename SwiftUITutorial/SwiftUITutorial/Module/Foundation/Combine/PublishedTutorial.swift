//
//  PublishedTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/5/9.
//

import SwiftUI
import Combine

/*
 @propertyWrapper
 struct Published<Value>

 init(initialValue: Value)
 init(wrappedValue: Value)

 var projectedValue: Published<Value>.Publisher

 struct Publisher

 其最大的特点就是，projectedValue是一个Published.Publisher类型，遵循了Publisher，也就是我们可以通过projectedValue来获取值
 The @Published attribute is class constrained. Use it with properties of classes, not with non-class types like structures.
 'wrappedValue' is unavailable: @Published is only available on properties of classes
 */
class Weather {
    @Published var temperature: Double

    init(temperature: Double) {
        self.temperature = temperature
    }
}

struct PublishedTutorial: View {
    
    let weather = Weather(temperature: 20)

    @State private var bags = Set<AnyCancellable>()

    // MARK: - system
    var body: some View {

        Button("Change", action: {
            weather.temperature = 30
        })
        .onAppear {
            weather.$temperature
                .sink { value in
                    print(value)
                }
                .store(in: &bags)
        }
    }
}

#Preview {
    PublishedTutorial()
}
