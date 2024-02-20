//
//  GaugeTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/20.
//

import SwiftUI

/*
 Gauge相当于环形展示。
 A gauge is a view that shows a current level of a value in relation to a specified finite capacity, very much like a fuel gauge in an automobile. Gauge displays are configurable; they can show any combination of the gauge’s current value, the range the gauge can display, and a label describing the purpose of the gauge itself.
 类似油表的展示，一般iWatch上面看到的比较多，比如运行、心跳、天气等app上。

 GaugeStyle有个重要的相关类型
 AccessoryCircularCapacityGaugeStyle
 AccessoryCircularGaugeStyle
 AccessoryLinearCapacityGaugeStyle
 AccessoryLinearGaugeStyle
 CircularGaugeStyle
 DefaultGaugeStyle
 LinearCapacityGaugeStyle
 LinearGaugeStyle
 */

struct GaugeTutorial: View {

    @State private var current = 67.0
    @State private var minValue = 0.0
    @State private var maxValue = 170.0

    @State private var currentSpeed = 140.0

    // MARK: - system
    var body: some View {
        VStack(spacing: 15) {
            Gauge(value: current) {
                Text("Gauge")
            }

            Gauge(value: current, in: minValue...maxValue, label: {
                Text("Gauge2")
            })
            .gaugeStyle(.accessoryCircularCapacity)

            Gauge(
                value: 0.5,
                label: {
                    Text("Gauge3")
                },
                currentValueLabel: { Text("50%") },
                minimumValueLabel: { Text("0%") },
                maximumValueLabel: { Text("100%") }
            ).gaugeStyle(.accessoryLinear)

            Gauge(
                value: current,
                in: minValue...maxValue,
                label: {
                    Text("Label")
                },
                currentValueLabel: { Text("\(current)") },
                markedValueLabels: {
                    Text("0%").tag(0.0)
                    Text("50%").tag(0.5)
                    Text("100%").tag(1.0)
                }
            )
            .gaugeStyle(.accessoryCircular)

            Gauge(value: currentSpeed, in: 0...200) {
                        Image(systemName: "gauge.medium")
                            .font(.system(size: 50.0))
                    } currentValueLabel: {
                        Text("\(currentSpeed.formatted(.number))")

                    }
                    .gaugeStyle(SpeedometerGaugeStyle())

        }
        .padding()
    }
}

#Preview {
    GaugeTutorial()
}


struct SpeedometerGaugeStyle: GaugeStyle {
    private var purpleGradient = LinearGradient(gradient: Gradient(colors: [ Color(red: 207/255, green: 150/255, blue: 207/255), Color(red: 107/255, green: 116/255, blue: 179/255) ]), startPoint: .trailing, endPoint: .leading)

    func makeBody(configuration: Configuration) -> some View {
        ZStack {

            Circle()
                .foregroundColor(Color(.systemGray6))

            Circle()
                .trim(from: 0, to: 0.75 * configuration.value)
                .stroke(purpleGradient, lineWidth: 20)
                .rotationEffect(.degrees(135))

            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(Color.black, style: StrokeStyle(lineWidth: 10, lineCap: .butt, lineJoin: .round, dash: [1, 34], dashPhase: 0.0))
                .rotationEffect(.degrees(135))

            VStack {
                configuration.currentValueLabel
                    .font(.system(size: 80, weight: .bold, design: .rounded))
                    .foregroundColor(.gray)
                Text("KM/H")
                    .font(.system(.body, design: .rounded))
                    .bold()
                    .foregroundColor(.gray)
            }

        }
        .frame(width: 300, height: 300)

    }

}
