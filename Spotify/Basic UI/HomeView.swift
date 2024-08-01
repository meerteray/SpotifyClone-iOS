import SwiftUI

struct HomeView: View {
    
    @State var openDetail = false
    
    @State var image = ""
    @State var colors = [Color]()
    
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
                                                            
                    NavigationLink(destination: PlaylistView(image: $image, colors: $colors), isActive: $openDetail) { }
                    
                    VStack(spacing: 10) {
                        HStack(spacing: 10) {
                            createButton(title: "This Is", subtitle: "Sezen Aksu", imageName: "sezenAksuImage", destination: SezenAksuView())
                            createButton(title: "Liked", subtitle: "Songs", imageName: "likedSongsImage", colors: [Color.yellow.opacity(1), Color.black])
                        }
                        HStack(spacing: 10) {
                            createButton(title: "No.1", subtitle: "", imageName: "no1Image", destination: no1View())
                            createButton(title: "This Is", subtitle: "Eminem", imageName: "eminemImage", colors: [Color.red.opacity(1), Color.black])
                        }
                        HStack(spacing: 10) {
                            createButton(title: "This Is", subtitle: "Kanye West", imageName: "kanyewestImage",colors: [Color.red.opacity(1), Color.black])
                               
                            createButton(title: "Ceza", subtitle: "", imageName: "cezaImage",colors: [Color.gray.opacity(1), Color.black])
                               
                        }
                        HStack(spacing: 10) {
                            createButton(title: "Sagopa Kajmer", subtitle: "", imageName: "sagopaImage",colors: [Color.green.opacity(1), Color.black])
                            createButton(title: "Sefo", subtitle: "", imageName: "sefoImage",colors: [Color.pink.opacity(1), Color.black])
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
    
    func createButton(title: String, subtitle: String, imageName: String, colors: [Color]) -> some View {
        Button(action: {
            print("\(title) \(subtitle) tapped")
            self.image = imageName
            self.colors = colors
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
