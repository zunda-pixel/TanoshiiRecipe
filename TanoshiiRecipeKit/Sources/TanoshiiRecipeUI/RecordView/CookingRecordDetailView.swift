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
        .clipShape(.rect(cornerRadius: 14))
        .frame(maxHeight: 400)
        .overlay(alignment: .topLeading) {
          Text(cookingRecord.recipeType.label)
            .padding(5)
            .background(.regularMaterial, in: .capsule)
            .padding(.horizontal, 5)
            .padding(.vertical, 12)
        }

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
        ToolbarItem(placement: .topBarTrailing) {
          CloseButton {
            dismiss()
          }
        }
      #endif
    }
  }
}

#Preview {
  CookingRecordDetailView(cookingRecord: .sample)
}

struct CloseButton: UIViewRepresentable {
  var action: @MainActor () -> Void

  func makeUIView(context: Context) -> some UIView {
    return UIButton(
      type: .close,
      primaryAction: .init(handler: { _ in
        action()
      })
    )
  }

  func updateUIView(_ uiView: UIViewType, context: Context) {}
}
