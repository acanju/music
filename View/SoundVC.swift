import UIKit

class SoundVC: UIViewController {
    
    //MARK: @IBOutlet
    @IBOutlet weak var waveView: BarWaveView!
    @IBOutlet weak var btnPlayPause: UIButton!
    
    //MARK: @variables
    let audioManager = AudioManager()
    var displayLink: CADisplayLink!
    var isPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setElement()
    }
    
    func  setElement() {
        btnPlayPause.setTitle("Play", for: .normal)
        btnPlayPause.setImage(UIImage(named: "icon_Play"), for: .normal)
        audioManager.volumeCallback = { [weak self] volume in
            self?.waveView.amplitude = CGFloat(volume)
        }
    }
    
    //MARK: @IBAction
    @IBAction func BtnPlayPause(_ sender: Any) {
        isPlaying.toggle()
        
        if isPlaying {
            audioManager.start()
            displayLink = CADisplayLink(target: self, selector: #selector(updateWave))
            displayLink.add(to: .main, forMode: .default)
            btnPlayPause.setTitle("Pause", for: .normal)
            btnPlayPause.setImage(UIImage(named: "icon_Pause"), for: .normal)
        } else {
            audioManager.stop()
            displayLink.invalidate()
            btnPlayPause.setImage(UIImage(named: "icon_Play"), for: .normal)
        }
    }
    
    @objc func updateWave() {
        waveView.setNeedsDisplay()
    }
    
    deinit {
        displayLink?.invalidate()
        audioManager.stop()
    }
}
