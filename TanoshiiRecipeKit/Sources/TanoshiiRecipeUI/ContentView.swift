import SwiftUI

public struct ContentView: View {
  @State var selectedTab: TabItem = .record
  
  public init() {}
  
  @ViewBuilder
  func tabView(_ tab: TabItem) -> some View {
    switch tab {
    case .home: Text("Home")
    case .favorite: Text("Favorite")
    case .makeRecipe: Text("Recipe")
    case .record: RecordView()
    case .mypage: Text("MyPage")
    }
  }
  
  public var body: some View {
    TabView(selection: $selectedTab) {
      ForEach(TabItem.allCases, id: \.self) { tab in
        Tab(value: tab) {
          tabView(tab)
        } label: {
          Label {
            Text(tab.label)
          } icon: {
            Image(systemName: tab.iconName)
          }
        }
      }
    }
  }
}

enum TabItem: CaseIterable {
  case home
  case favorite
  case makeRecipe
  case record
  case mypage
  
  var label: LocalizedStringKey {
    switch self {
    case .home: "Home"
    case .favorite: "Favorite"
    case .makeRecipe: "Recipe"
    case .record: "Record"
    case .mypage: "MyPage"
    }
  }
  
  var iconName: String {
    switch self {
    case .home: "house"
    case .favorite: "heart"
    case .makeRecipe: "square.and.pencil"
    case .record: "graph.2d"
    case .mypage: "person"
    }
  }
}
