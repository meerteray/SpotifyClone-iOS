import Foundation
import AVFoundation

class PlaylistViewModel: ObservableObject {
    let selectedUser: User
    @Published var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false
    @Published var currentSong: Song?
    @Published var playbackProgress: Double = 0.0
    private var timer: Timer?
    
    init(selectedUser: User) {
        self.selectedUser = selectedUser
    }
    
    func playOrPauseSong(_ song: Song) {
        if currentSong?.id == song.id {
            togglePlayPause()
        } else {
            stopCurrentSong()
            playSong(song)
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