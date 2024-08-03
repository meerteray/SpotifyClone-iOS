import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    func greetingMessage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 6..<12:
            return "Good Morning"
        case 12..<17:
            return "Good Afternoon"
        case 17..<22:
            return "Good Evening"
        default:
            return "Good Night"
        }
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.users) { user in
                Button(action: {
                    viewModel.selectUser(user)
                }) {
                    Text(user.name)
                }
            }
            .navigationTitle(greetingMessage())
            .onAppear {
                viewModel.fetchUsers()
            }
        }
    }
}

#Preview {
    HomeView()
}
