import Foundation
import MemberwiseInit

@MemberwiseInit(.public)
public struct CookingRecord: Decodable, Sendable, Hashable {
  /// 写真のURL
  public var imageUrl: URL

  /// コメント
  public var comment: String

  /// レシピの種類
  public var recipeType: RecepeType
  
  /// 記録日時
  public var recordedAt: Date
}
