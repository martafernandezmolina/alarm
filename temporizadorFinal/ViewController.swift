
import UIKit
import AVFoundation

class ViewController: UIViewController{
  
  let softTime: Int = 6 // 5 minutos
  var player: AVAudioPlayer?
  let hardTime: Int = 12 // 7 minutos
  
  var secondsPassed: Int = 0
  var totalTime :Int = 0
 
  
  var timer: Timer = Timer()
  
  
  @IBOutlet weak var titleLabel: UILabel!
  
 
  @IBOutlet weak var progressView: UIProgressView!
  
  @IBOutlet weak var StopButton: UIButton!
  
  @IBAction func timerInvalidate(_ sender: Any) {
    timer.invalidate()
    playerfalse()
  }
  @IBAction func hardnessSelected(_ sender: UIButton) {
    
    timer.invalidate()
    
    
  
    let hardness = sender.currentTitle  // "Soft" o "Hard"
    if hardness == "Soft" {
      print("softTime: \(softTime)")
      totalTime = softTime
    } else {
      print ("hardTime: \(hardTime)")
      totalTime = hardTime
    }
    
    progressView.progress = 0
    secondsPassed = 0
    titleLabel.text = hardness
    
    
   timer = Timer.scheduledTimer(timeInterval: 1.0,
                         target: self,
                         selector: #selector(updateTimer) ,
                         userInfo: nil,
                         repeats: true)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @objc func updateTimer() {
    if secondsPassed < totalTime  {
       secondsPassed += 1
      
      let percentageProgress:Float = Float(secondsPassed) / Float(totalTime)

      progressView.progress = percentageProgress
      
    } else {
      titleLabel.text = "FINALIZAR COCCIÓN!"
      playSound(songName:"alarm")
      
      timer.invalidate()
    }
  }
  
  func playSound (songName:String){
    let url = Bundle.main.url(forResource: songName,
                              withExtension: "mp3")
    player = try! AVAudioPlayer(contentsOf: url!)
    player?.play()
  }
  
  func playerfalse(){
    player?.stop()
  }
  
}




