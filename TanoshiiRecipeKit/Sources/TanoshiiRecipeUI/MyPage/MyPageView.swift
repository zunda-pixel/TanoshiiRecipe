import SwiftUI

struct MyPageView: View {
  var body: some View {
    NavigationStack {
      List {
        NavigationLink {
          LicenseListView()
        } label: {
          Text("Licenses")
        }
      }
      .navigationTitle("MyPage")
    }
  }
}

#Preview {
  MyPageView()
}
