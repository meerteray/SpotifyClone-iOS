import SwiftUI
import AVFoundation

struct SezenAksuView: View {
    @State private var selectedSong: String?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying = false
    
   
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.red.opacity(1), Color.black]),
                           startPoint: .top,
                           endPoint: .init(x: 0.6, y: 0.6))
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ZStack {
                            Image("sezenAksuImage")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 250, height: 250)
                                .clipped()
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        
                        Text("This is Sezen Aksu, The essential tracks, all in one playlist.")
                            .font(.system(size: 13))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        ForEach(Constants().sezenAksuSongs, id: \.self) { song in
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
                    .padding(.horizontal)
                }
                
                if let selectedSong = selectedSong {
                    PlayerControlView(song: selectedSong, isPlaying: $isPlaying, togglePlayPause: togglePlayPause)
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
    @Binding var isPlaying: Bool
    let togglePlayPause: () -> Void
    
    var body: some View {
        HStack {
            Image("kaybolanYıllarImage")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading) {
                Text(song)
                    .font(.caption)
                    .foregroundColor(.white)
                Text("Sezen Aksu")
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

struct SezenAksuView_Previews: PreviewProvider {
    static var previews: some View {
        SezenAksuView()
    }
}
