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

  @Test
  func decodeResponse() async throws {
    let url = Bundle.module.url(forResource: "Response", withExtension: "json")!
    let data = try Data(contentsOf: url)
    let response = try JSONDecoder.tanoshiiRecipe.decode(CookingRecordsResponse.self, from: data)
    print(response)
  }
}
