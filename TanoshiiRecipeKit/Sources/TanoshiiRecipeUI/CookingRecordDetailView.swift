import SwiftUI
import Kingfisher
import TanoshiiRecipeAPI

struct CookingRecordDetailView: View {
  var cookingRecord: CookingRecord
  
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
    }
  }
}

#Preview {
  let cookingRecord = CookingRecord(
    imageUrl: URL(string: "https://cooking-records.ex.oishi-kenko.com/images/2.jpg")!,
    comment: "パンチのきいた辛味が印象的です。",
    recipeType: .mainDish,
    recordedAt: .now
  )
  
  CookingRecordDetailView(cookingRecord: cookingRecord)
}
