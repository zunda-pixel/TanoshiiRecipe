import SwiftUI
import TanoshiiRecipeAPI
import Kingfisher

struct CookingRecordAlbumView: View {
  @Observable
  final class Model {
    var cookingRecords: [CookingRecord] = []
    
    @ObservationIgnored var pagination: Pagination?
    let client = Client()
    var isLoading = false
  }

  var model = Model()

  func fetchData() async {
    guard model.isLoading == false else { return }
    defer { model.isLoading = false }
    if let total = model.pagination?.total,
       model.cookingRecords.count >= total {
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
      print(error)
    }
  }
  
  struct CellView: View {
    var cookingRecord: CookingRecord
    
    var body: some View {
      KFImage(cookingRecord.imageUrl)
        .resizable()
        .aspectRatio(1, contentMode: .fit)
    }
  }

  var body: some View {
    ScrollView(.vertical) {
      LazyVGrid(columns: [.init(), .init()]) {
        ForEach(model.cookingRecords, id: \.self) { cookingRecord in
          CellView(cookingRecord: cookingRecord)
            .task {
              guard cookingRecord == model.cookingRecords.last else { return }
              await fetchData()
            }
        }
      }
    }
    .navigationTitle(Text("Cooking Record Album"))
    .refreshable {
      await fetchData()
    }
    .task {
      await fetchData()
    }
  }
}

#Preview {
  NavigationStack {
    CookingRecordAlbumView()
  }
}

