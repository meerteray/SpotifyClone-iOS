import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.users) { user in
                Button(action: {
                    viewModel.selectUser(user)
                }) {
                    Text(user.name)
                }
            }
            .navigationTitle("Artist")
            .onAppear {
                viewModel.fetchUsers()
            }
        }
        .sheet(item: $viewModel.selectedUser) { user in
            UserDetailView(user: user)
        }
    }
}

struct UserDetailView: View {
    let user: User
    var body: some View {
            VStack {
                Text("Kullanıcı Detayları")
                    .font(.title)
                    .padding()
                Text("ID: \(user.id)")
                Text("İsim: \(user.name)")
            }
        }
    }

    #Preview {
        HomeView()
    }
