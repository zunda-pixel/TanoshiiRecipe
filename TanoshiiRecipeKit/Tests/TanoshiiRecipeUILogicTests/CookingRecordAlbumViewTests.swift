import Testing

@testable import TanoshiiRecipeUI

@MainActor
@Suite
struct CookingRecordAlbumViewTests {
  @Test
  func fetchData() async throws {
    let view = CookingRecordAlbumView()

    await view.fetchData()
    #expect(view.model.cookingRecords.count == 10)

    await view.fetchData()
    #expect(view.model.cookingRecords.count == 20)
  }
}
