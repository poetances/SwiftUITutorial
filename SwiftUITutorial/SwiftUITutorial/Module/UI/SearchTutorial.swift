//
//  SearchTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/1/30.
//

import SwiftUI

struct SearchTutorial: View {

    @State private var searchText: String = ""

    @State private var isShow = false

    @Environment(\.dismiss) var dismiss
    @Environment(\.dismissSearch) var dismissSearch

    @StateObject private var model = SearchModel()
    // MARK: - system
    var body: some View {

        List {
            ForEach(0 ..< 10) { index in
                Text("\(index)")
            }

            Section {
                Button("dismiss") {
                    // dismissSearch()
                    isShow = false
                }
            }
        }
        .searchable(text: $searchText, tokens: $model.tokens, placement: .sidebar) { token in
            switch token {
            case .apple: Text("apple")
            case .banana: Text("banana")
            case .pear: Text("pear")
            }
        }
        .searchSuggestions {
            Text("🍎").searchCompletion("apple")
            Text("🍐").searchCompletion("pear")
            Text("🍌").searchCompletion("banana")
        }
        .searchSuggestions(.visible, for: .menu)
        // .searchable(text: $searchText, isPresented: $isShow, placement: .automatic, prompt: "Input")
    }
}

/*
 SearchFieldPlacement
 automatic
 In iOS, iPadOS, and macOS, the search field appears in the toolbar.
 In tvOS and watchOS, the search field appears inline with its content.

 navigationBarDrawer
 The search field appears in the navigation bar.
 即导航栏下面

 toolbar
 In iOS and watchOS, the search field appears below the navigation bar and is revealed by scrolling.
 In iPadOS, the search field appears in the trailing navigation bar.
 In macOS, the search field appears in the trailing toolbar.

 */

/*
 dismiss
 */
extension SearchTutorial {


}

#Preview {
    SearchTutorial()
}

class SearchModel: ObservableObject {

    @Published var tokens: [FruitToken] = []
}

enum FruitToken: String, Identifiable, Hashable, CaseIterable {
    case apple
    case pear
    case banana
    var id: Self { self }
}
