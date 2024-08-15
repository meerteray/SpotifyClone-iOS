import SwiftUI

struct HomeView2: View {
    
    @State var openDetail = false
    
    @State var image = ""
    @State var colors = [Color]()
    @State var songs = [String]()
    @State var artist = ""
        
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            /*vf
            */
            VStack(alignment: .leading, spacing: 20) {
                
                NavigationLink(destination: PlaylistView(
                    image: $image,
                    colors: $colors,
                    songs: $songs,
                    artist: $artist
                ), isActive: $openDetail) {
                    EmptyView()
                }
                
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        createButton(title: "This Is", subtitle: "Sezen Aksu", imageName: "sezenAksuImage", colors: [Color.yellow.opacity(1), Color.black], songs: Constants().artistSongs["Sezen Aksu"] ?? [])
                        createButton(title: "Liked", subtitle: "Songs", imageName: "likedSongsImage", colors: [Color.yellow.opacity(1), Color.black], songs: [])
                    }
                    HStack(spacing: 10) {
                        createButton(title: "No.1", subtitle: "", imageName: "no1Image",colors: [Color.gray.opacity(1), Color.black], songs: Constants().artistSongs["No.1"] ?? [])
                        createButton(title: "This Is", subtitle: "Eminem", imageName: "eminemImage", colors: [Color.red.opacity(1), Color.black], songs: Constants().artistSongs["Eminem"] ?? [])
                    }
                    HStack(spacing: 10) {
                        createButton(title: "This Is", subtitle: "Kanye West", imageName: "kanyewestImage",colors: [Color.red.opacity(1), Color.black], songs: Constants().artistSongs["Kanye West"] ?? [])
                        createButton(title: "Ceza", subtitle: "", imageName: "cezaImage",colors: [Color.gray.opacity(1), Color.black],
                                     songs: Constants().artistSongs["Ceza"] ?? [])
                    }
                    HStack(spacing: 10) {
                        createButton(title: "Sagopa Kajmer", subtitle: "", imageName: "sagopaImage",colors: [Color.green.opacity(1), Color.black], songs: Constants().artistSongs["Sagopa Kajmer"] ?? [])
                        createButton(title: "Sefo", subtitle: "", imageName: "sefoImage",colors: [Color.pink.opacity(1), Color.black],
                                     songs: Constants().artistSongs["Sefo"] ?? [])
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
    
    func createButton(title: String, subtitle: String, imageName: String, colors: [Color], songs: [String]) -> some View {
        Button(action: {
            print("\(title) \(subtitle) tapped")
            self.image = imageName
            self.colors = colors
            self.songs = songs
            self.artist = subtitle.isEmpty ? title : subtitle
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
    HomeView2()
}
