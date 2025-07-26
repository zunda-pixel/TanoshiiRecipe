/// レシピの種類
public enum RecepeType: String, Decodable, Hashable, Sendable {
  /// 主菜/主食
  case mainDish = "main_dish"

  /// 副菜
  case sideDish = "side_dish"
  
  /// スープ
  case soup
}
