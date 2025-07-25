public struct CookingRecordsResponse: Decodable, Hashable, Sendable {
  public var pagination: Pagination
  public var cookingRecords: [CookingRecord]
}
