import SwiftUI

struct HomeView: View {
    
    @State var isOpenSezenAksu = false
    @State var openDetail = false
    @State var image = ""
    
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

            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text(greetingMessage())
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                                        
                    NavigationLink(destination: PlaylistView(image: $image), isActive: $openDetail) {
                      
                    }
                    VStack(spacing: 10) {
                        HStack(spacing: 10) {
                            createButton(title: "This Is", subtitle: "Sezen Aksu", imageName: "sezenAksuImage", destination: SezenAksuView())
                            createButton(title: "Liked", subtitle: "Songs", imageName: "likedSongsImage")
                        }
                        HStack(spacing: 10) {
                            createButton(title: "No.1", subtitle: "", imageName: "no1Image", destination: no1View())
                            createButton(title: "This Is", subtitle: "Eminem", imageName: "eminemImage")
                                .onTapGesture {
                                    image = "eminemImage"
                                    openDetail.toggle()
                                }
                        }
                        HStack(spacing: 10) {
                            createButton(title: "This Is", subtitle: "Kanye West", imageName: "kanyewestImage")
                                .onTapGesture {
                                    image = "kanyewestImage"
                                    openDetail.toggle()
                                }
                            createButton(title: "Ceza", subtitle: "", imageName: "cezaImage")
                                .onTapGesture {
                                    image = "cezaImage"
                                    openDetail.toggle()
                                }
                        }
                        HStack(spacing: 10) {
                            createButton(title: "Sagopa Kajmer", subtitle: "", imageName: "sagopaImage")
                            createButton(title: "Sefo", subtitle: "", imageName: "sefoImage")
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
    }
    
    func createButton<Destination: View>(title: String, subtitle: String, imageName: String, destination: Destination) -> some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 0) {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipped()
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                    if !subtitle.isEmpty {
                        Text(subtitle)
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
    
    func createButton(title: String, subtitle: String, imageName: String) -> some View {
        Button(action: {
            print("\(title) \(subtitle) tapped")
            image = imageName
            openDetail.toggle()
        }) {
            HStack(spacing: 0) {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipped()
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                    if !subtitle.isEmpty {
                        Text(subtitle)
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

#Preview {
    HomeView()
}
