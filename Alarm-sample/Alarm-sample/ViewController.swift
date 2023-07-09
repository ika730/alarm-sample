import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    
    @IBOutlet weak var imfomlabel: UILabel!
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBAction func setNotification(_ sender: UIButton) {
        //時間
        let calendar = Calendar(identifier: .gregorian)
        let pickerDate = datepicker.date
        let dateComponents = calendar.dateComponents([.hour,.minute], from: pickerDate )
        //.year, .month, .day,

//        let year = dateComponents.year!
//        let month = dateComponents.month!
//        let day = dateComponents.day!
        let hour = dateComponents.hour!
        let minute = dateComponents.minute!

        let seconds = Int(segment.titleForSegment(at: segment.selectedSegmentIndex)!)!
        // content
        let content = UNMutableNotificationContent()
        content.title = "時間だよ"
        content.subtitle = "\(hour)時\(minute)分だよ "
        content.body = "おきてー"
        content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "008_se_kira8.mp3"))

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "TIMER\(seconds)",
                                            content: content,
                                            trigger: trigger)
        

        // schedule notification by adding request to notification center
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        print(dateComponents)
        imfomlabel.text = "\(hour)時\(minute)分にアラームがセットされています"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
