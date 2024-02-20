//
//  ControlsAndIndicatorsPage.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/19.
//

import SwiftUI

struct ControlsAndIndicatorsPage: View {

    private var contents = [
        Content(title: "Button", destination: .button),
        Content(title: "EditButton", destination: .editButton),
        Content(title: "PasteButton", destination: .pasteButton),
        Content(title: "RenameButton", destination: .renameButton),
        Content(title: "Link", destination: .link),
        Content(title: "Slide", destination: .slide),
        Content(title: "Stepper", destination: .stepper),
        Content(title: "Picker", destination: .picker),
        Content(title: "DatePicker", destination: .datePicker),
        Content(title: "ColorPicker", destination: .colorPicker),
        Content(title: "Gauge", destination: .gauge),
        Content(title: "ProgressView", destination: .progressView),
        Content(title: "SensoryFeedback", destination: .sensoryFeedback),
        Content(title: "ControlSize", destination: .controlSize)
    ]

    // MARK: - system
    var body: some View {
        List(contents) {
            NavigationLink($0.title, value: $0.destination)
        }
        .navigationTitle("ControlsAndIndicators")
        .navigationDestination(for: Destination.self) { des in
            switch des {
            case .button:
                ButtonTutorial()
            case .editButton:
                EditButtonTutorial()
            case .pasteButton:
                PasteButtonTutorial()
            case .renameButton:
                RenameButtonTutorial()
            case .link:
                LinkTutorial()
            case .slide:
                SlideTutorial()
            case .stepper:
                StepperTutorial()
            case .picker:
                PickerTutorial()
            case .datePicker:
                DatePickerTutorial()
            case .colorPicker:
                ColorPickerTutorial()
            case .gauge:
                GaugeTutorial()
            case .progressView:
                ProgressViewTutorial()
            case .sensoryFeedback:
                SensoryFeedbackTutorial()
            case .controlSize:
                ControlSizeTutorial()
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

extension ControlsAndIndicatorsPage {

    struct Content: Identifiable {

        let id = UUID()

        let title: String
        let destination: Destination
    }

    enum Destination: CaseIterable {
        case button
        case editButton
        case pasteButton
        case renameButton
        case link
        case slide
        case stepper
        case picker
        case datePicker
        case colorPicker
        case gauge
        case progressView
        case sensoryFeedback
        case controlSize
    }
}

#Preview {
    ControlsAndIndicatorsPage()
}
