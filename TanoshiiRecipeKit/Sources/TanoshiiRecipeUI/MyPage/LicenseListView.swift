import SwiftUI

struct LicenseListView: View {
  var body: some View {
    List {
      ForEach(LicenseProvider.packages) { package in
        NavigationLink(package.name) {
          Text(package.license)
            .navigationTitle(package.name)
            .toolbar {
              if case .remoteSourceControl(let location) = package.kind {
                ShareLink(item: location)
              }
            }
        }
      }
    }
    .navigationTitle(Text("Licenses"))
  }
}

#Preview {
  NavigationStack {
    LicenseListView()
  }
}
