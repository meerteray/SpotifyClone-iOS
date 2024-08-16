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
            
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text(greetingMessage())
                        .foregroundStyle(.white)
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.users) { user in
                                
                                
                            NavigationLink(destination: PlaylistView()) {
                                    
                                
                                    HStack(spacing: 0) {
                                        AsyncImage(url: URL(string: user.imageURL)) { phase in
                                            if let image = phase.image {
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 60, height: 60)
                                                    .clipped()
                                            } else if phase.error != nil {
                                                Text("Görsel Yüklenemedi")
                                            } else {
                                                ProgressView()
                                            }
                                        }
                                        
                                        VStack(alignment: .leading) {
                                            Text(user.name)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            if !user.name.isEmpty {
                                                Text(user.name)
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                        .padding(.leading, 10)
                                        Spacer()
                                    }
                                    .frame(height: 60)
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(5)
                                }
                            }
                        }
                        .padding()
                    }
                    
                }
                .onAppear {
                    viewModel.fetchUsers()
                }
            }
        }
    }
}
#Preview {
    HomeView()
}
