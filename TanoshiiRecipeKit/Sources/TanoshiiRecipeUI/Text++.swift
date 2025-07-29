import SwiftUI

extension Text {
  init(
    _ key: LocalizedStringKey,
    tableName: String? = nil,
    comment: StaticString? = nil
  ) {
    self.init(
      key,
      tableName: tableName,
      bundle: .module,
      comment: comment
    )
  }
}
