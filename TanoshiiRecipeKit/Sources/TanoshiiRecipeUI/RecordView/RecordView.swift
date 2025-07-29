import SwiftUI

struct RecordView: View {
  @State var router = NavigationRouter()

  var body: some View {
    NavigationStack(path: $router.path) {
      List {
        Button {
          router.path.append(.cookingRecordAlbum)
        } label: {
          Text("Cooking Record Album")
        }
      }
      .navigationDestination(for: NavigationRouter.Item.self) { item in
        switch item {
        case .cookingRecordAlbum:
          CookingRecordAlbumView()
        case .cookingRecordDetail(let cookingRecord):
          CookingRecordDetailView(cookingRecord: cookingRecord)
        }
      }
    }
    .environment(router)
  }
}
