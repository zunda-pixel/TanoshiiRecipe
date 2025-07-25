import MemberwiseInit

@MemberwiseInit(.public)
public struct Pagination: Decodable, Hashable, Sendable {
  /// 総レコード数
  public var total: Int

  /// オフセット
  public var offset: Int

  /// リクエスト時指定の取得数
  public var limit: Int
}
