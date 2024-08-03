import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        VStack {
            Text("Kullanıcı Adı: \(viewModel.userName)")
                .padding()
            Button(action: {
                viewModel.fetchUserName()
            }) {
                Text("Kullanıcı Adını Çek")
            }
        }
    }
}

#Preview {
    HomeView()
}
