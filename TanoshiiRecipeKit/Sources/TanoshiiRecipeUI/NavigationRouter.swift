import Observation
import TanoshiiRecipeAPI

@Observable
final class NavigationRouter {
  var path: [Item] = []

  enum Item: Hashable {
    case cookingRecordAlbum
    case cookingRecordDetail(CookingRecord)
  }
}
