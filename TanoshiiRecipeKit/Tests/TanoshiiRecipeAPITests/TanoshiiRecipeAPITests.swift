import Foundation
import TanoshiiRecipeAPI
import Testing

@Suite
struct TanoshiiRecipeAPITests {
  @Test
  func getCookingRecords() async throws {
    let client = Client()
    _ = try await client.cookingRecords()
  }
}
