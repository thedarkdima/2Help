
import UIKit

class AlertController: UIViewController {

    @IBOutlet var alertBox: UIView!
    
    @IBOutlet var address_label: UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func backBtn() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func toWaze() {
        //check if waze installed on the iPhone
        if(UIApplication.shared.canOpenURL(URL(string:"waze://")!)){
            
            let NameUrl = (address_label.text?.replacingOccurrences(of: " ", with: "+"))!
            
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
            
        }    }
    
}
