import Kingfisher
import SwiftUI
import TanoshiiRecipeAPI

struct CookingRecordDetailView: View {
  var cookingRecord: CookingRecord
  @Environment(\.dismiss) var dismiss

  var body: some View {
    List {
      KFImage(cookingRecord.imageUrl)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(maxHeight: 400)
        .overlay(alignment: .topLeading) {
          Text(cookingRecord.recipeType.label)
            .padding(5)
            .background(.regularMaterial, in: .capsule)
            .padding(5)
        }
        .clipShape(.rect(cornerRadius: 14))

      LabeledContent {
        Text(cookingRecord.recordedAt, style: .date)
      } label: {
        Text("Registerd at")
      }

      Text(cookingRecord.comment)
        .lineLimit(nil)
    }
    #if !os(macOS)
      .listStyle(.insetGrouped)
    #endif
    .toolbar {
      #if !os(macOS)
        if #available(iOS 26.0, *) {
          ToolbarItem(placement: .topBarTrailing) {
            Button(role: .close) {
              dismiss()
            }
          }
        }
      #endif
    }
  }
}

#Preview {
  CookingRecordDetailView(cookingRecord: .sample)
}
