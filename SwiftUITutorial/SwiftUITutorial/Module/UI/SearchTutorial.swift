//
//  SearchTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/1/30.
//

import SwiftUI

struct Meal: Codable, Hashable, Identifiable {

    let imageURL: String
    let id: String
    let name: String
    let location: String
    let rating: Double
    var tags: [String]

    static func preview() -> Meal {
        Meal(imageURL: "europian.jpg",
             id: "3",
             name: "food name",
             location: "Africa",
             rating: 4,
             tags: ["Fast Food"])
    }
}

class MealListViewModel: ObservableObject {
    @Published var meals = [Meal]()
    @Published var searchText = ""

    var filteredMeals: [Meal] {
        guard !searchText.isEmpty else { return meals }
        return meals.filter { meal in
            meal.name.lowercased().contains(searchText.lowercased())
        }
    }
}

struct SearchTutorial: View {

    @State private var searchText: String = ""

    @State private var isShow = false

    @Environment(\.dismiss) var dismiss
    @Environment(\.dismissSearch) var dismissSearch

    @StateObject private var vm = MealListViewModel()

    @StateObject private var model = SearchModel()
    // MARK: - system
    var body: some View {

        searchable
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

 其高级用法，SearchSuggestion、SearchTokens
 */

/*-
 dismiss
 */
extension SearchTutorial {

    var searchable: some View {
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
        .searchable(text: $searchText, tokens: $model.tokens, placement: .navigationBarDrawer) { token in
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
        .searchSuggestions(.visible, for: .content)
        // .searchPresentationToolbarBehavior(.avoidHidingContent)
        // .searchable(text: $searchText, isPresented: $isShow, placement: .automatic, prompt: "Input")
    }

    var searchVm: some View {
        List {
            ForEach(vm.filteredMeals) { meal in

            }
            .listRowSeparator(.hidden, edges: .all)
        }
        .listStyle(.plain)
        .navigationTitle("Find Your Next Meal")
        .searchable(text: $vm.searchText)
        .onSubmit(of: .search) {
            // 点击完成
        }
    }
}

// MARK: - findNavigator(isPresented:)、findDisabled(_:)、replaceDisabled(_:)
extension SearchTutorial {

    /*
     findDisabled、TextEditor的查找
     replaceDisable、TextEditor的替换
     findNavigator查找和替换导航的显示
     */
    var textEditor: some View {
        TextEditor(text: $searchText)
            .findDisabled(false)
            .replaceDisabled(false)
            .findNavigator(isPresented: $isShow)
            .toolbar {
                Toggle(isOn: $isShow) {
                    Label("Find", systemImage: "magnifyingglass")
                }
            }
    }
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
