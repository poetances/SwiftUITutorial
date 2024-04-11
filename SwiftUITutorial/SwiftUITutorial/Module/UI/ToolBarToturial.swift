//
//  ToolBarToturail.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/1/28.
//

import SwiftUI

/*
 ToolBar两种初始化方式：
 func toolbar<Content>(@ViewBuilder content: () -> Content) -> some View where Content : View
 func toolbar<Content>(@ToolbarContentBuilder content: () -> Content) -> some View where Content : ToolbarContent
 也就是其Content可以是View，也可以是ToolBarContent

 ToolBarContent协议
 ToolBarItem、ToolBarItemGroup遵循了ToolBarContent协议

 ToolBarItem用Label修饰，不会显示Text


 // 修饰标题
 toolbarTitleMenu
 toolbarTitleDisplayMode
 */
struct ToolBarToturial: View {

    @State private var text = ""

    @State private var isShowSheet = false

    @State private var bold = false

    @Environment(\.dismiss) var dismiss
    
    // MARK: - system
    var body: some View {
        List {
            toolbar
//            toolbar2
//            modal
//            custom
        }
        .toolbar(.hidden, for: .tabBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarTitleMenu {
            ForEach(0 ..< 5) { index in
                Button(action: {
                    dismiss()
                }, label: {
                    Text("\(index)")
                })
            }
        }
        .toolbarTitleDisplayMode(.inline)
    }
}

// MARK: - toolbar(content:)
extension ToolBarToturial {

    /*
     虽然.toolbar有个方法是View，但是其实不起效果
     */
    var toolbar: some View {
        Text("Tool bar")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    VStack {
                        Image(systemName: "pencil.tip.crop.circle.fill")
                        Text("Text")
                    }
                }

                ToolbarItem(placement: .bottomBar) {
                    VStack {
                        Image(systemName: "pencil.tip.crop.circle.fill")
                        Text("Text")
                    }
                }

                ToolbarItem(placement: .bottomBar) {
                    VStack {
                        Image(systemName: "pencil.tip.crop.circle.fill")
                        Text("Text")
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Label("Two", systemImage: "lasso")
                }

                ToolbarItem(placement: .principal) {
                    Label("Three", systemImage: "trash")
                }

                ToolbarItem(placement: .primaryAction) {
                    Label("Fore", systemImage: "doc.richtext.hi")
                }
            }
    }
}

// MARK: - init(placement:content:label:)
extension ToolBarToturial {

    /*
     ToolbarItemGroup创建有个方法有一个类
     LabeledToolbarItemGroupContent
     You don’t create this type directly. SwiftUI creates it when you build a ToolbarItemGroup.
     */
    var toolbar2: some View {
        TextField("Title", text: $text)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Label("Two", systemImage: "lasso")
                    Label("Three", systemImage: "trash")
                }
            }
    }
}

/*
 ToolbarItemPlacement
 There are two types of placements:
 Semantic placements, such as principal and navigation, denote the intent of the item being added. SwiftUI determines the appropriate placement for the item based on this intent and its surrounding context, like the current platform.
 Positional placements, such as navigationBarLeading, denote a precise placement for the item, usually for a particular platform.

 有两种规则：
 1、根据语义
 2、具体位置

 具体值：
 1、automatic
 In macOS and in Mac Catalyst apps, the system places items in the current toolbar section in order of leading to trailing. On watchOS, only the first item appears, pinned beneath the navigation bar.
 In iPadOS, the system places items in the center of the navigation bar if the navigation bar supports customization. Otherwise, it places items in the trailing position of the navigation bar.
 In iOS, and tvOS, the system places items in the trailing position of the navigation bar.
 In iOS, iPadOS, and macOS, the system uses the space available to the toolbar when determining how many items to render in the toolbar. If not all items fit in the available space, an overflow menu may be created and remaining items placed in that menu.

 2、principal（重要的）
 Principal actions are key units of functionality that receive prominent placement. For example, the location field for a web browser is a principal item.
 In macOS and in Mac Catalyst apps, the system places the principal item in the center of the toolbar.
 In iOS, iPadOS, and tvOS, the system places the principal item in the center of the navigation bar. This item takes precedent over a title specified through View/navigationTitle.

 3、 status
 Status items are informational in nature, and don’t represent an action that can be taken by the user. For example, a message that indicates the time of the last communication with the server to check for new messages.
 In macOS and in Mac Catalyst apps, the system places status items in the center of the toolbar.
 In iOS and iPadOS, the system places status items in the center of the bottom toolbar.

 4、topBarLeading
 5、topBarTrailing
 6、bottomBar
 7、keyboard
 */

// MARK: - primaryAction、navigation、secondaryAction、confirmationAction、cancellationAction、destructiveAction
extension ToolBarToturial {

    var modal: some View {
        Button("Modal") {
            isShowSheet.toggle()
        }
        .sheet(isPresented: $isShowSheet, content: {
            NavigationStack {
                Button("Hide sheet") {
                    isShowSheet.toggle()
                }
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button("PrimaryAction") {
                            isShowSheet.toggle()
                        }
                    }

                    ToolbarItem(placement: .secondaryAction) {
                        Button("SecondaryAction") {
                            isShowSheet.toggle()
                        }
                    }

                    ToolbarItem(placement: .confirmationAction) {
                        Button("ConfirmationAction") {
                            isShowSheet.toggle()
                        }
                    }

                    ToolbarItem(placement: .cancellationAction) {
                        Button("CancellationAction") {
                            isShowSheet.toggle()
                        }
                    }

                    ToolbarItem(placement: .destructiveAction) {
                        Button("DestructiveAction") {
                            isShowSheet.toggle()
                        }
                    }

                    ToolbarItem(placement: .navigation) {
                        Button("Navigation") {
                            isShowSheet.toggle()
                        }
                    }
                }
            }
        })
    }
}

extension ToolBarToturial {

    var custom: some View {
        Text("Custom")
            .navigationTitle("ToolBar")
            .toolbarTitleMenu(content: {
                Button("Tsk") {

                }
            })
            .toolbar(id: "main") {
                ToolbarItem(id: "left", placement: .topBarTrailing) {
                    Toggle(isOn: $bold) {
                        Image(systemName: "bold")
                    }
                }
            }
    }
}

#Preview {
    ToolBarToturial()
}
