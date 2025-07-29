import Observation

@Observable
final class NavigationRouter {
  var path: [Item] = []

  enum Item: Hashable {
    case cookingRecordAlbum
  }
}
