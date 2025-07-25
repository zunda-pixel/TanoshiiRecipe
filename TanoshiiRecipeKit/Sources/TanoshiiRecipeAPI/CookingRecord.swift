import Foundation
import MemberwiseInit

@MemberwiseInit(.public)
public struct CookingRecord: Decodable, Sendable, Hashable {
  public var imageUrl: URL
  public var comment: String
  public var recipeType: RecepeType
  public var recordedAt: Date
}
