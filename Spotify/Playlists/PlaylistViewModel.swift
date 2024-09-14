import SwiftUI
import AVFoundation
import FirebaseStorage

class PlaylistViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false
    @Published var currentSong: Song?
    @Published var playbackProgress: Double = 0.0
    
    private var timer: Timer?
    private let selectedUser: User
    
    init(selectedUser: User) {
        self.selectedUser = selectedUser
        fetchImageFromFirebase()
    }
    
    func fetchImageFromFirebase() {
        let storage = Storage.storage()
        let reference = storage.reference(forURL: selectedUser.imageURL)
        
        reference.getData(maxSize: 10 * 1024 * 1024) { [weak self] data, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
            } else if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = uiImage
                }
            }
        }
    }
    
    func playOrPauseSong(_ song: Song) {
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
        stopTimer()
    }
    
    private func playSong(_ song: Song) {
        guard let url = URL(string: song.song.removingPercentEncoding ?? song.song) else {
            print("Invalid song URL: \(song.song)")
            return
        }
        
        print("Playing song from URL: \(url)")
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
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
                self?.audioPlayer = try AVAudioPlayer(data: data)
                self?.audioPlayer?.play()
                DispatchQueue.main.async {
                    self?.currentSong = song
                    self?.isPlaying = true
                    self?.startTimer()
                }
            } catch {
                print("Error creating audio player: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updatePlaybackProgress()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updatePlaybackProgress() {
        guard let player = audioPlayer else { return }
        let progress = player.currentTime / player.duration
        playbackProgress = progress
    }
}
