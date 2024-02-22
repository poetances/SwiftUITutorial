//
//  GaugeStyleTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/21.
//

import SwiftUI

/*
 GaugeStyle

 AccessoryCircularCapacityGaugeStyle
 AccessoryCircularGaugeStyle
 AccessoryLinearCapacityGaugeStyle
 AccessoryLinearGaugeStyle
 CircularGaugeStyle
 DefaultGaugeStyle
 LinearCapacityGaugeStyle
 LinearGaugeStyle
 */
struct GaugeStyleTutorial: View {
    var body: some View {
        VStack(spacing: 15) {
            Gauge(value: 10, in: 0...100) {
                Text("Gauge")
            }
            .gaugeStyle(.linearCapacity)

            Gauge(value: 0.5, label: {
                Text("Label")
            }
            ).gaugeStyle(.accessoryLinear)

            Gauge(value: 0.5, label: {
                Text("Label")
            }
            ).gaugeStyle(.accessoryLinearCapacity)

            Gauge(
                value: 0.5,
                label: { Text("Label") },
                currentValueLabel: { Text("50%") }
            )
            .gaugeStyle(.accessoryCircular)

            Gauge(value: 10, in: 0...100) {
                Text("Label")
            } currentValueLabel: {
                Text("currentValueLabel")
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("100")
            }
            .foregroundStyle(.red)
            .gaugeStyle(.accessoryCircularCapacity)
        }
        .padding()
    }
}

#Preview {
    GaugeStyleTutorial()
}
