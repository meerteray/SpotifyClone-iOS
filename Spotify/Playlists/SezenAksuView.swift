import SwiftUI
import AVFoundation

struct SezenAksuView: View {
    @State private var selectedSong: String?
    @State private var audioPlayer: AVAudioPlayer?
    
    let songs = [
        "Kaybolan Yıllar",
        "Firuze",
        "Gülümse",
        "Seni Yerler",
        "Kutlama",
        "Hadi Bakalım",
        "İkili Delilik",
        "Aldatıldık",
        "Tutsak"
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.red.opacity(1), Color.black]),
                           startPoint: .top,
                           endPoint: .init(x: 0.6, y: 0.6))
            .edgesIgnoringSafeArea(.all)
            
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
                .padding(.horizontal)
            }
        }
    }
    
    func playSong(song: String) {
        guard let url = Bundle.main.url(forResource: song, withExtension: "mp3") else {
            print("Şarkı dosyası bulunamadı: \(song)")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Şarkı çalınamadı: \(error.localizedDescription)")
        }
    }
}

struct SezenAksuView_Previews: PreviewProvider {
    static var previews: some View {
        SezenAksuView()
    }
}
