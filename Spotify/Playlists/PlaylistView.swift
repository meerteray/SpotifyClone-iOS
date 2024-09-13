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
                                playOrPauseSong(song)
                            }) {
                                HStack {
                                    Text(song.name)
                                        .foregroundColor(currentSong?.id == song.id ? .green : .white)
                                        .padding(.vertical, 4)
                                    
                                    Spacer()
                                }
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
            if let currentSong = currentSong, let userImage = image {
                Image(uiImage: userImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
                    .padding(.trailing, 8)
                
                Text(currentSong.name)
                    .foregroundColor(.white)
                    .font(.headline)
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
        
        reference.getData(maxSize: 10 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
            } else if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = uiImage
                }
            }
        }
    }
    
    private func playOrPauseSong(_ song: Song) {
        if currentSong?.id == song.id {
            if isPlaying {
                audioPlayer?.pause()
            } else {
                audioPlayer?.play()
            }
            isPlaying.toggle()
        } else {
            stopCurrentSong()
            playSong(song)
        }
    }
    
    private func stopCurrentSong() {
        audioPlayer?.stop()
        audioPlayer = nil
        isPlaying = false
    }
    
    
    private func playSong(_ song: Song) {
        guard let url = URL(string: song.song.removingPercentEncoding ?? song.song) else {
            print("Invalid song URL: \(song.song)")
            return
        }
        
        print("Playing song from URL: \(url)")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading song: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received for song: \(song.name)")
                return
            }
            
            print("Downloaded data size: \(data.count) bytes")
            
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

