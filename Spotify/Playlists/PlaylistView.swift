import SwiftUI
import FirebaseStorage
import AVFoundation

struct PlaylistView: View {
    let selectedUser: User
    @State private var image: UIImage?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying = false
    @State private var currentSong: Song?
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            VStack {
                                if let image = image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 200, height: 200)
                                } else {
                                    ProgressView()
                                }
                                Text(selectedUser.name)
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                        }
                        ForEach(selectedUser.songs) { song in
                            Button(action: {
                                playSong(song)
                            }) {
                                Text(song.name)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 4)
                            }
                        }
                    }
                    .padding()
                }
                
                Spacer()
                
                if currentSong != nil {
                    playerControls
                }
            }
        }
        .onAppear {
            fetchImageFromFirebase()
        }
    }
    
    private var playerControls: some View {
        HStack {
            if let currentSong = currentSong {
                Text(currentSong.name)
                    .foregroundColor(.white)
            }
            Spacer()
            Button(action: {
                if isPlaying {
                    audioPlayer?.pause()
                } else {
                    audioPlayer?.play()
                }
                isPlaying.toggle()
            }) {
                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 44, height: 44)
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.3))
    }
    
    private func fetchImageFromFirebase() {
        let storage = Storage.storage()
        let reference = storage.reference(forURL: selectedUser.imageURL)
        
        reference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
            } else if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = uiImage
                }
            }
        }
    }
    
    private func playSong(_ song: Song) {
        guard let url = URL(string: song.song) else {
            print("Invalid song URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error downloading song: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                audioPlayer = try AVAudioPlayer(data: data)
                audioPlayer?.play()
                DispatchQueue.main.async {
                    currentSong = song
                    isPlaying = true
                }
            } catch {
                print("Error creating audio player: \(error.localizedDescription)")
            }
        }.resume()
    }
}

#Preview {
    PlaylistView(
        selectedUser:
            User(id: "1", name: "Sezen Aksu", imageURL:"https://firebasestorage.googleapis.com/v0/b/spotifyclone-80fcd.appspot.com/o/Kaybolan%20Yıllar.mp3?alt=media&token=8266e208-763a-4df3-a108-735ef48daefa",
                 songs: [
                    Song(id: "1", name: "Gülümse", song: "https://firebasestorage.googleapis.com/v0/b/spotifyclone-80fcd.appspot.com/o/Gülümse.mp3?alt=media&token=ebdfe903-3194-4ae5-b4c4-839fe9b8b5a5"),
                    Song(id: "2", name: "Firuze", song: "https://firebasestorage.googleapis.com/v0/b/spotifyclone-80fcd.appspot.com/o/Firuze.mp3?alt=media&token=bf01d723-aff9-4cad-8d66-036ff2037e80"),
                    Song(id: "3", name: "Kaybolan Yıllar", song:"https://firebasestorage.googleapis.com/v0/b/spotifyclone-80fcd.appspot.com/o/Kaybolan%20Yıllar.mp3?alt=media&token=8266e208-763a-4df3-a108-735ef48daefa"),
                    Song(id: "4", name: "Kutlama", song: "https://firebasestorage.googleapis.com/v0/b/spotifyclone-80fcd.appspot.com/o/Kutlama.mp3?alt=media&token=46348393-d9df-48b5-af72-c187c855d2b9"),
                    Song(id: "5", name: "Seni Yerler", song: "https://firebasestorage.googleapis.com/v0/b/spotifyclone-80fcd.appspot.com/o/Seni%20Yerler.mp3?alt=media&token=12014c94-cd9b-429b-a528-13a58c989051")
                 ])
    )
}
