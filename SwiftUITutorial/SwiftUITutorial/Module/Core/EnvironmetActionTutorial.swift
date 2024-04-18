//
//  EnvironmetActionTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/4/12.
//

import SwiftUI

struct EnvironmetActionTutorial: View {

    /// DismissAction
    /// func callAsFunction()
    /// Dismiss a modal presentation, like a sheet or a popover.
    /// Pop the current view from a NavigationStack.
    /// Close a window that you create with WindowGroup or Window.
    @Environment(\.dismiss) private var dismiss

    /// struct DismissSearchAction
    /// func callAsFunction()
    /// Sets isSearching to false.
    /// Clears any text from the search field.
    /// Removes focus from the search field.
    ///
    /// 注意使用的位置：也就是searchable是在哪里注册环境变量，我们需要从哪里获取环境变量，需要有清晰的认知。
    @Environment(\.dismissSearch) private var dismissSearch
    @State private var searchText: String = ""


    /// struct OpenURLAction
    /// func callAsFunction(URL)
    /// func callAsFunction(URL, completion: (Bool) -> Void)
    @Environment(\.openURL) private var openUrl


    /// struct RefreshAction
    /// func callAsFunction() async
    /// 注意和searchable一样，需要考虑其作用于和调用时机
    @Environment(\.refresh) private var refresh

    // MARK: - system
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Button("Dismiss") {
                    dismiss()
                }


                Button("DismissSearch") {
                    dismissSearch()
                }
                SearchAbleContentView()


                Button("OpenUrl") {
                    openUrl(URL(string: "https://www.baidu.com")!)
                }
                Button("OpenUrl2") {
                    openUrl(URL(string: "https://www.baidu.com")!) { accepted in
                        print("accept", accepted)
                    }
                }


                Button("Refresh") {
                    Task {
                        await refresh?()
                    }
                }.disabled(refresh == nil)
                RefreshableContentView()
            }
        }
        .searchable(text: $searchText)
        .refreshable {
            try! await Task.sleep(nanoseconds: 3_000_000_000)
            print("Start Refresh")
        }
    }
}

struct SearchAbleContentView: View {

    @Environment(\.dismissSearch) private var dismissSearch
    @State private var searchText: String = ""

    var body: some View {
        Button("DismissSearch2") {
            dismissSearch()
        }
    }
}


struct RefreshableContentView: View {

    @Environment(\.refresh) private var refresh

    var body: some View {
        Button("Refresh2") {
            Task {
                await refresh?()
            }
        }
        .disabled(refresh == nil)
    }
}

#Preview {
    EnvironmetActionTutorial()
}
