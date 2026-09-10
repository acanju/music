import AVFoundation

class AudioManager: NSObject, AVAudioPlayerDelegate {
    
    //MARK: Var
    var audioPlayer: AVAudioPlayer?
    var volumeCallback: ((Float) -> Void)?
    var timer: Timer?
    
    //MARK: start function
    func start() {
        guard let url = Bundle.main.url(forResource: "sound", withExtension: "mp3") else {
            print("Audio file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.isMeteringEnabled = true
            audioPlayer?.delegate = self
            audioPlayer?.play()
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
                guard let player = self?.audioPlayer else { return }
                player.updateMeters()
                let power = player.averagePower(forChannel: 0)
                let normalized = max(0.0, (power + 50) / 50)
                self?.volumeCallback?(normalized)
            }
            
        } catch {
            print("Failed to play audio:", error)
        }
    }
    
    //MARK: stop function
    func stop() {
        audioPlayer?.stop()
        timer?.invalidate()
    }
}
