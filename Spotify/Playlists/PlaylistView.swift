import SwiftUI
import AVFAudio

struct PlaylistView: View {
    
    @Binding var image: String
    @Binding var colors: [Color]
    @Binding var songs: [String]
    
    @State private var selectedSong: String?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying = false
    
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
                    }
                    
                    ForEach(songs, id: \.self) { song in
                        Button(action: {
                            selectedSong = song
                            playSong(song: song)
                        }) {
                            HStack(spacing: 10) {
                                Image("kaybolanYıllarImage")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(song)
                                        .foregroundColor(selectedSong == song ? .green : .white)
                                        .font(.system(size: 16))
                                    Text("Sezen Aksu")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14))
                                }
                                
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
        
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
}

#Preview {
    PlaylistView(image: .constant("sagopaImage"), colors: .constant([Color.gray.opacity(1), Color.black]), songs: .constant(Constants().sezenAksuSongs))
}
