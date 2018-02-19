
import UIKit

class AlertController: UIViewController {

    @IBOutlet var alertBox: UIView!
    var name: String?
    var phoneNumber: String?
    var address: String?
    var hours: String?
    
    @IBOutlet var name1: UILabel!
    @IBOutlet var phone: UILabel!
    @IBOutlet var addresses: UILabel!
    @IBOutlet var open_hours: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initialize the strings to set the lables with them
        if let n = name {
            name1.text? = n
        }
        if let p = phoneNumber{
            phone.text? = p
        }
        if let add = address{
            addresses.text? = add
        }
        if let h = hours{
            open_hours.text? = h
        }
    }
    
    func set(name : String, phone : String, address : String, openHours : String){
        self.name = name
        self.phoneNumber = phone
        self.address = address
        self.hours = openHours
    }
    
    @IBAction func backBtn() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func toWaze() {
        //check if waze installed on the iPhone
        if(UIApplication.shared.canOpenURL(URL(string:"waze://")!)){
            
            let NameUrl = (addresses.text?.replacingOccurrences(of: " ", with: "+"))!
            let address = "https://waze.com/ul?q=\(NameUrl)"
            let addressURL = URL(string: address)
            
            // print("\(addressURL!)")
            
            UIApplication.shared.open(addressURL!, options: [:], completionHandler: nil)
            UIApplication.shared.isIdleTimerDisabled = true
        } else {
            //else open a web url that says waze is not installed and link to appstore to download waze
            let url = URL(string:"http://www.itunes.apple.com/us/app/id323229106")!
            //  let url = URL(string:"http://www.google.com/")!   //test
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
