//
//  NavigationTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/1/24.
//

import SwiftUI

/*
 If your app has a minimum deployment target of iOS 16, iPadOS 16, macOS 13, tvOS 16, or watchOS 9, or later, transition away from using NavigationView. In its place, use NavigationStack and NavigationSplitView instances. How you use these depends on whether you perform navigation in one column or across multiple columns. With these newer containers, you get better control over view presentation, container configuration, and programmatic navigation.
 即官方建议使用NavigationStack、NavigationSplitView来替换NavigationView；
 NavigationView { // This is deprecated.
     /* content */
 }
 .navigationViewStyle(.stack)

 NavigationStack {
     /* content */
 }
 */

struct NavigationTutorial: View {

    @State private var path = NavigationPath()

    @StateObject private var coordinator = Coordinator()

    @State private var isShowDetail = false

    @State private var colorShown: Color?


    // MARK: - system
    var body: some View {
         // navigationLink
        Text("Navigation")
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Navigation")

    }
}

// MARK: - NavigationLink
extension NavigationTutorial {

    /*
     NavigationLink有两种方式进行导航。
     isDetailLink：一个单独方法，用于处理是否是详情，一般应用与NavigationSplitView中。

     This method sets the behavior when the navigation link is used in a NavigationSplitView, or a multi-column navigation view, such as one using ColumnNavigationViewStyle.
     For example, in a two-column navigation split view, if isDetailLink is true, triggering the link in the sidebar column sets the contents of the detail column to be the link’s destination view. If isDetailLink is false, the link navigates to the destination view within the primary column.
     If you do not set the detail link behavior with this method, the behavior defaults to true.
     The isDetailLink modifier only affects view-destination links. Links that present data values always search for a matching navigation destination beginning in the column that contains the link.
     */
    var navigationLink: some View {
        List {
            NavigationLink("Mint", value: Color.mint)
            NavigationLink("Pink", value: Color.pink)
            NavigationLink("Teal", value: Color.teal)
            NavigationLink("Other", value: "Other")
        }
        .navigationDestination(for: Color.self) { color in
            ColorDetail(color: color)
        }
        .navigationDestination(for: String.self) { f in
            let _ = print("navigationDestination", f)
            Text("")
        }
        .navigationTitle("Colors")
    }
}

extension NavigationTutorial {

    /*
     ⚠️在使用堆栈管理系统的情况下，请不要在编程式导航中混用声明式导航，这样会破坏当前的视图堆栈数据

     NavigationLink("SubView3",value: 3)
     NavigationLink("SubView4", destination: { SubView4() }) // 不要在编程式导航中混用声明式导航
     
     */
//    var navigationStack: some View {
//        NavigationStack {
//            List(parks) { park in
//                NavigationLink(park.name, value: park)
//            }
//            .navigationDestination(for: Park.self) { park in
//                ParkDetails(park: park)
//            }
//        }
//    }
}

// MARK: - NavigationPath
extension NavigationTutorial {
    
    /*
     A type-erased list of data representing the content of a navigation stack.
     用于类型擦除
     */
    var navigationPath: some View {

        NavigationStack(path: $path) {
            List {
                Button("append int") {
                    path.append(12)
                }
                Button("append string") {
                    path.append("12")
                }
                Button("remove") {
                    path.removeLast()
                }
            }
            .navigationDestination(for: Int.self) { intValue in
               let _ = print(intValue)
            }
            .navigationDestination(for: String.self) { stringValue in
                let _ = print(stringValue)
            }
        }
        .environmentObject(coordinator) // 第二种方式
    }

    class Coordinator: ObservableObject {
        @Published var path = NavigationPath()

        func gotoHomePage() {
            path.append("homepage")
        }

        func gotoOther() {
            path.append("other")
        }

        func pop() {
            path.removeLast()
        }
    }
}

// MARK: - NavigationDestination
extension NavigationTutorial {

    var navigationDestination: some View {
        Text("Navigation Destination")
            .navigationDestination(for: Int.self) { intValue in

            }
            .navigationDestination(isPresented: $isShowDetail) {
                ColorDetail(color: .red)
            }
            .navigationDestination(item: $colorShown) { color in
                // A binding to the data presented, or nil if nothing is currently presented.
                ColorDetail(color: color)
            }
    }

    var navigationDestinationItem: some View {
        List {
            Button("Mint") { colorShown = .mint }
            Button("Pink") { colorShown = .pink }
            Button("Teal") { colorShown = .teal }
        }
        .navigationDestination(item: $colorShown) { color in
            ColorDetail(color: color)
        }
    }
}

// MARK: - Modifier
extension NavigationTutorial {
    /*
     navigationTitle
     navigationBarBackButtonHidden
     navigationBarTitleDisplayMode

     navigationSubtitle (macOS)
     navigationDocument
     */
}

// MARK: - NavigationBarItem.TitleDisplayMode
extension NavigationTutorial {

    /*
     navigationBarTitleDisplayMode，需要传入NavigationBarItem.TitleDisplayMode
     automatic. Inherit the display mode from the previous navigation item.
        也是默认效果，如果上一个页面是large，则该页面就是large，如果上个页面是inline则该页面为inline

     inline. Display the title within the standard bounds of the navigation bar.

     large. Display a large title within an expanded navigation bar.
     */
    var titleDisplayMode: some View {
        Text("").navigationBarTitleDisplayMode(.inline)
    }

    // SidebarRowSize主要Mac使用
}

#Preview {
    NavigationTutorial()
}

struct ColorDetail: View {
    var color: Color

    var body: some View {
        color.navigationTitle(color.description)
    }
}


