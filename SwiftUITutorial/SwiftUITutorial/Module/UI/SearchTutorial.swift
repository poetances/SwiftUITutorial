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

    static func preview() -> [Meal] {
        [
            Meal(imageURL: "europian.jpg",
                 id: "3",
                 name: "Apple",
                 location: "Africa",
                 rating: 4,
                 tags: ["Fast Food"]),
            Meal(imageURL: "europian.jpg",
                 id: "3",
                 name: "Orange",
                 location: "Africa",
                 rating: 4,
                 tags: ["Fast Food"]),
            Meal(imageURL: "europian.jpg",
                 id: "3",
                 name: "Banana",
                 location: "Africa",
                 rating: 4,
                 tags: ["Fast Food"]),
            Meal(imageURL: "europian.jpg",
                 id: "3",
                 name: "Pear",
                 location: "Africa",
                 rating: 4,
                 tags: ["Fast Food"])
        ]
    }
}

enum MealSearchToken: String, Hashable, CaseIterable, Identifiable {
    case fourStarReview = "4+ star review"
    case onSale = "On sale"
    case toGo = "To go"
    case coupon = "coupon"
    var id: String { rawValue }
    func icon() -> String {
        switch self {
            case .fourStarReview:
               return "star"
            case .onSale:
               return "paperplane"
            case .toGo:
               return "figure.walk"
            case .coupon:
               return "tag"
        }
    }
}

class MealListViewModel: ObservableObject {
    @Published var meals = [Meal]()
    @Published var searchText: String = ""
    @Published var selectedTokens = [MealSearchToken]()
    @Published var suggestedTokens = MealSearchToken.allCases
    var filteredMeals: [Meal] {
        var meals = self.meals
        if searchText.count > 0 {
            meals = meals.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
        for token in selectedTokens {
            switch token {
                case .fourStarReview:
                    meals = meals.filter({ $0.rating >= 4 })
                case .onSale, .coupon, .toGo:
                meals = meals.filter({ $0.tags.contains(token.rawValue)})
            }
        }
        return meals
    }
}

// Holds one token that we want the user to filter by. This *must* conform to Identifiable.
struct Token: Identifiable {
    var id: String { name }
    var name: String
}

struct SearchTutorial: View {

    @State private var searchText: String = ""

    @State private var isShow = false

    @Environment(\.dismiss) var dismiss
    @Environment(\.dismissSearch) var dismissSearch

    @StateObject private var vm = MealListViewModel()

    @StateObject private var model = SearchModel()

    let names = ["Holly", "Josh", "Rhonda", "Ted"]


    // MARK: - system
    var body: some View {

//        searchable
//        textEditor
//        searchVm
//        searchSuggestion
//        searchTokens
        searchTokens2
            .toolbar(.hidden, for: .tabBar)
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
                     dismissSearch()
//                    isShow = false
                }
            }
        }
        .searchable(text: $searchText, tokens: $model.tokens, placement: .navigationBarDrawer, prompt: Text("prompt")) { token in
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
                Text(meal.name)
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

    var searchSuggestion: some View {
        List {
            ForEach(searchResults, id: \.self) { name in
                NavigationLink {
                    Text(name)
                } label: {
                    Text(name)
                }
            }
        }
        .navigationTitle("Contacts")
        .searchable(text: $searchText) {
            ForEach(searchResults, id: \.self) { result in
                Text("Are you looking for \(result)?").searchCompletion(result)
            }
        }
    }

    var searchResults: [String] {
        if searchText.isEmpty {
            return names
        } else {
            return names.filter { $0.contains(searchText) }
        }
    }
}

extension SearchTutorial {

    /// 通过建议令牌来实现
    /// searchable(text: Binding<String>, tokens: Binding<C>, suggestedTokens: Binding<C>, @ViewBuilder token: @escaping (C.Element)

    var searchTokens: some View {
        List {
            ForEach(vm.filteredMeals) { meal in
                Text(meal.name)
            }
            .listRowSeparator(.hidden, edges: .all)
        }
        .listStyle(.plain)
        .navigationTitle("Find Your Next Meal")
        .searchable(text: $vm.searchText,
                    tokens: $vm.selectedTokens,
                    suggestedTokens: $vm.suggestedTokens,
                    token: { token in
            Label(token.rawValue, systemImage: token.icon())
        })
    }

    /// searchable(text: Binding<String>, tokens: Binding<C>, @ViewBuilder token: @escaping (C.Element) -> T)
    var searchTokens2: some View {
        List {
            ForEach(vm.filteredMeals) { meal in
                Text(meal.name)
            }
            .listRowSeparator(.hidden, edges: .all)
        }
        .listStyle(.plain)
        .navigationTitle("Find Your Next Meal")
        .searchable(text: $vm.searchText,
                    tokens: $vm.selectedTokens,
                    token: { token in
            Label(token.rawValue, systemImage: token.icon())
        })
        .searchSuggestions {
            ForEach(vm.suggestedTokens) { token in
                Button {
                    vm.selectedTokens.append(token)
                } label: {
                    Label(token.rawValue, systemImage:  token.icon())
                }
            }
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
