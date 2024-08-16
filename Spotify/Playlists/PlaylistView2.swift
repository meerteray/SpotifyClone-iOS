import SwiftUI
import AVFoundation

struct PlaylistView2: View {
    @Binding var image: String
    @Binding var colors: [Color]
    @Binding var songs: [String]
    @Binding var artist: String
    
    @State private var selectedSong: String?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying = false
    
    @State private var showTitle = false
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: colors),
                           startPoint: .top,
                           endPoint: .init(x: 0.6, y: 0.6))
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ZStack {
                            Image(image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 250, height: 250)
                                .clipped()
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        
                        Text("This is \(artist), The essential tracks, all in one playlist.")
                            .font(.system(size: 13))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        ForEach(songs, id: \.self) { song in
                            Button(action: {
                                selectedSong = song
                                playSong(song: song)
                            }) {
                                HStack(spacing: 10) {
                                    Image("songThumbnail")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(song)
                                            .foregroundColor(selectedSong == song ? .green : .white)
                                            .font(.system(size: 16))
                                        Text(artist)
                                            .foregroundColor(.gray)
                                            .font(.system(size: 14))
                                    }
                                    
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .background(GeometryReader { geometry -> Color in
                        DispatchQueue.main.async {
                            let offset = geometry.frame(in: .global).minY
                            scrollOffset = offset
                            
                            if offset < -40 {
                                showTitle = true
                            } else {
                                showTitle = false
                            }
                        }
                        return Color.clear
                    })
                }
                if let selectedSong = selectedSong {
                    PlayerControlView(song: selectedSong, artist: artist, isPlaying: $isPlaying, togglePlayPause: togglePlayPause)
                }
            }
        }
        
        .navigationTitle(showTitle ? artist : "")
    }
    
    func playSong(song: String) {
        audioPlayer?.stop()
        
        guard let url = Bundle.main.url(forResource: song, withExtension: "mp3") else {
            print("Şarkı dosyası bulunamadı: \(song)")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            selectedSong = song
            isPlaying = true
        } catch {
            print("Şarkı çalınamadı: \(error.localizedDescription)")
        }
    }
    
    func togglePlayPause() {
        if isPlaying {
            audioPlayer?.pause()
        } else {
            audioPlayer?.play()
        }
        isPlaying.toggle()
    }
}

struct PlayerControlView: View {
    let song: String
    let artist: String
    @Binding var isPlaying: Bool
    let togglePlayPause: () -> Void
    
    var body: some View {
        HStack {
            Image("songThumbnail")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading) {
                Text(song)
                    .font(.caption)
                    .foregroundColor(.white)
                Text(artist)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button(action: togglePlayPause) {
                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(Color.black.opacity(0.8))
    }
}
#Preview {
    PlaylistView2(
        image: .constant("sezenAksuImage"),
        colors: .constant([Color.red.opacity(0.8), Color.black]),
        songs: .constant(Constants().artistSongs["Sezen Aksu"] ?? []),
        artist: .constant("Sezen Aksu")
    )
}

struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
