import Kingfisher
import SwiftUI
import TanoshiiRecipeAPI

struct CookingRecordAlbumView: View {
  @Observable
  final class Model {
    var cookingRecords: [CookingRecord] = []

    @ObservationIgnored var pagination: Pagination?
    @ObservationIgnored let client = Client()
    var isLoading = false

    var selectedCookingRecord: CookingRecord?

    var error: (any Error)?
    var isPresentedError = false
  }

  @State var model = Model()
  @Namespace var namespace
  @Environment(NavigationRouter.self) var router

  func fetchData() async {
    guard model.isLoading == false else { return }
    defer { model.isLoading = false }
    if let total = model.pagination?.total,
      model.cookingRecords.count >= total
    {
      return
    }

    do {
      model.isLoading = true
      let response = try await model.client.cookingRecords(
        offset: model.cookingRecords.count,
        limit: 10
      )
      model.pagination = response.pagination
      model.cookingRecords.append(contentsOf: response.cookingRecords)
    } catch {
      model.error = error
      model.isPresentedError.toggle()
    }
  }

  struct CellView: View {
    var cookingRecord: CookingRecord

    var body: some View {
      KFImage(cookingRecord.imageUrl)
        .resizable()
        .aspectRatio(1, contentMode: .fit)
        .clipShape(.rect(cornerRadius: 8))
        .overlay(alignment: .topLeading) {
          Text(cookingRecord.recipeType.label)
            .padding(5)
            .background(.regularMaterial, in: .capsule)
            .padding(5)
        }
    }
  }

  var body: some View {
    ScrollView(.vertical) {
      #if os(macOS)
        let columnCount = 5
      #else
        let columnCount = 2
      #endif

      LazyVGrid(columns: Array(repeating: .init(), count: columnCount)) {
        ForEach(model.cookingRecords) { cookingRecord in
          CellView(cookingRecord: cookingRecord)
            .matchedTransitionSource(id: cookingRecord, in: namespace)
            .task {
              guard cookingRecord == model.cookingRecords.last else { return }
              await fetchData()
            }
            .contentShape(.rect)
            .onTapGesture {
              #if os(macOS)
                router.path.append(.cookingRecordDetail(cookingRecord))
              #else
                model.selectedCookingRecord = cookingRecord
              #endif
            }
        }

        if model.cookingRecords.isEmpty && model.isLoading {
          ForEach(0..<10) { _ in
            CellView(cookingRecord: .sample)
              .redacted(reason: .placeholder)
              .overlay {
                ProgressView()
              }
          }
        }
      }
    }
    .sheet(item: $model.selectedCookingRecord) { cookingRecord in
      NavigationStack {
        CookingRecordDetailView(cookingRecord: cookingRecord)
      }
      #if !os(macOS)
        .navigationTransition(.zoom(sourceID: cookingRecord, in: namespace))
      #endif
    }
    .padding(.horizontal, 8)
    .navigationTitle(Text("Cooking Record Album"))
    .refreshable {
      await fetchData()
    }
    .task {
      await fetchData()
    }
    .alert("Error", isPresented: $model.isPresentedError, presenting: model.error) { error in
      Text(error.localizedDescription)
    }
  }
}

#Preview {
  NavigationStack {
    CookingRecordAlbumView()
  }
}

extension CookingRecord: Identifiable {
  public var id: Self { self }
}

extension RecepeType {
  var label: LocalizedStringKey {
    switch self {
    case .mainDish: "Main Dith"
    case .sideDish: "Side Dish"
    case .soup: "Soup"
    }
  }
}

extension CookingRecord {
  static let sample = CookingRecord(
    imageUrl: URL(string: "https://cooking-records.ex.oishi-kenko.com/images/2.jpg")!,
    comment: """
      パンチのきいた辛味が印象的です。
      """,
    recipeType: .mainDish,
    recordedAt: .now
  )
}
