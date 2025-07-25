import Foundation

extension JSONDecoder {
  public static var tanoshiiRecipe: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .custom({ decoder in
      let container = try decoder.singleValueContainer()
      let string = try container.decode(String.self)
      // Date Format: 2018-04-27 13:59:48
      return try Date(
        string,
        strategy: .iso8601
          .year()
          .month()
          .day()
          .time(includingFractionalSeconds: false)
          .dateTimeSeparator(.space)
      )
    })
    return decoder
  }
}
