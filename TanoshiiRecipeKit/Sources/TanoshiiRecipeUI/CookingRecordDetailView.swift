import SwiftUI
import Kingfisher
import TanoshiiRecipeAPI

struct CookingRecordDetailView: View {
  var cookingRecord: CookingRecord
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationStack {
      List {
        KFImage(cookingRecord.imageUrl)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .overlay(alignment: .topLeading) {
            Text(cookingRecord.recipeType.label)
              .padding(5)
              .background(.regularMaterial, in: .capsule)
              .padding(5)
          }
        
        LabeledContent("Registerd at") {
          Text(cookingRecord.recordedAt, style: .date)
        }
        
        Text(cookingRecord.comment)
          .lineLimit(nil)
      }
      .listStyle(.insetGrouped)
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          if #available(iOS 26.0, *) {
            Button(role: .close) {
              dismiss()
            }
          }
        }
      }
    }
  }
}

#Preview {
  CookingRecordDetailView(cookingRecord: .sample)
}
