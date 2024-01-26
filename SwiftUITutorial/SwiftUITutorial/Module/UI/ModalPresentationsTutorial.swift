//
//  ModalPresentationsTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/1/26.
//

import SwiftUI

/*
 Modal Presention都是以modifier的形式展示的。

 DialogSeverity，对话框的严重程度。
 automatic
    The default dialog severity. Alerts that present an error will use .critical and all others will use .standard.
 standard
 critical

 */
struct ModalPresentationsTutorial: View {

    @State private var isShowSheet = false

    @State private var inventory: InventoryItem?

    @State private var isShowFullScreen = false
    @Environment(\.dismiss) private var dismiss

    @State private var isShowPoper = false

    // MARK: - system
    var body: some View {
        VStack(spacing: 15) {
            sheet_presented
            sheet_item
            sheet_fullScreenCover
            sheet_poper
            sheet_compact
        }
    }
}

// MARK: - sheet(isPresented:onDismiss:content:)
extension ModalPresentationsTutorial {
    
    var sheet_presented: some View {
        Button("Sheet Presented") {
            isShowSheet.toggle()
        }
        .sheet(isPresented: $isShowSheet) {
            Text("Sheet").background(Color.purple)
        }
    }
}

// MARK: - sheet(item:onDismiss:content:)
extension ModalPresentationsTutorial {
    /*
     A binding to an optional source of truth for the sheet. When item is non-nil, the system passes the item’s content to the modifier’s closure. You display this content in a sheet that you create that the system displays to the user. If item changes, the system dismisses the sheet and replaces it with a new one using the same process.
     */
    var sheet_item: some View {
        Button("Sheet Item") {
            inventory = InventoryItem(
                id: "0123456789",
                partNumber: "Z-1234A",
                quantity: 100,
                name: "Widget"
            )
        }
        .sheet(item: $inventory) { inventory in
            VStack(alignment: .leading, spacing: 20) {
                Text("Part Number: \(inventory.partNumber)")
                Text("Name: \(inventory.name)")
                Text("Quantity On-Hand: \(inventory.quantity)")
            }
        }

    }

    struct InventoryItem: Identifiable {
        var id: String
        let partNumber: String
        let quantity: Int
        let name: String
    }
}

// MARK: - fullScreenCover(isPresented:onDismiss:content:)
extension ModalPresentationsTutorial {

    var sheet_fullScreenCover: some View {
        Button("Sheet Full Screen") {
            isShowFullScreen.toggle()
        }
        .fullScreenCover(isPresented: $isShowFullScreen) {
            VStack(spacing: 15) {
                Button("Dismiss") {
                    dismiss() // DismissAction callAsFunction
                }
                Button("Dissmiss2") {
                    isShowFullScreen.toggle()
                }
            }
        }
    }

    // fullScreenCover(item:onDismiss:content:)， 这里和.navigationDestination很像
    var sheet_fullScreenCover_item: some View {
        Button("Sheet Full Screen item") {

        }
        .fullScreenCover(item: $inventory) { inventory in
            VStack(alignment: .leading, spacing: 20) {
                Text("Part Number: \(inventory.partNumber)")
                Text("Name: \(inventory.name)")
                Text("Quantity On-Hand: \(inventory.quantity)")
            }
        }
    }
}

// MARK: - popover(isPresented:attachmentAnchor:arrowEdge:content:)
extension ModalPresentationsTutorial {

    /*
     Popover并不只适用于macOS。尽管它在macOS中非常常见，但是在iOS和iPadOS也可以使用Popover。
     但是，需要注意的是，Popover在不同的操作系统和设备上可能会有不同的表现形式。
     例如，在iPad上，Popover可能会以一个悬浮的窗口形式出现，而在iPhone上，Popover可能会以全屏或者底部弹出的形式出现。
     */
    var sheet_poper: some View {
        Button("Sheet Poper") {
            isShowPoper.toggle()
        }
        .popover(isPresented: $isShowPoper, content: {
            Button("Hide Poper") {
                isShowPoper.toggle()
            }
        })
    }
}

// MARK: - presentationCompactAdaptation(_:)
extension ModalPresentationsTutorial {
    /*
     苹果考虑到popver在iOS上的限制，所以提供了presentationCompactAdaptation(_:)来进行sheet优化
     */
    var sheet_compact: some View {
        Button("Sheet compact") {
            isShowPoper.toggle()
        }
        .popover(isPresented: $isShowPoper) {
            Button("Hide Poper") {
                isShowPoper.toggle()
            }.presentationCompactAdaptation(horizontal: .popover, vertical: .sheet)
        }
    }
}


#Preview {
    ModalPresentationsTutorial()
}
