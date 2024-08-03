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
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.users) { user in
                        Button(action: {
                            viewModel.selectUser(user)
                        }) {
                            Text(user.name)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
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
