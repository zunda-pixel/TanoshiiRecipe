import Foundation
import HTTPTypes
import HTTPTypesFoundation
import MemberwiseInit

@MemberwiseInit(.public)
public struct Client: Sendable {
  public var httpClient: URLSession = .shared
  public var baseUrl: URL = URL(string: "https://cooking-records.ex.oishi-kenko.com")!

  /// 料理の記録を取得
  /// - Parameters:
  ///   - offset: 取得する記録のオフセット
  ///   - limit: 一度のリクエストで取得する記録数
  /// - Returns: `CookingRecordsResponse`
  public func cookingRecords(
    offset: Int = 0,
    limit: Int = 10
  ) async throws -> CookingRecordsResponse {
    let url =
      baseUrl
      .appending(path: "cooking_records")
      .appending(queryItems: [
        .init(name: "offset", value: String(offset)),
        .init(name: "limit", value: String(limit)),
      ])

    let request = HTTPRequest(
      method: .get,
      url: url
    )

    let (data, _) = try await httpClient.data(for: request)

    let response = try JSONDecoder.tanoshiiRecipe.decode(CookingRecordsResponse.self, from: data)

    return response
  }
}
