import UIKit
import CoreLocation

class AlertController: UIViewController {
    
    var name: String?
    var phoneNumber: String?
    var address: String?
    var hours: String?
    
    @IBOutlet var place_name: UILabel!
    @IBOutlet var place_phone: UILabel!
    @IBOutlet var place_address: UILabel!
    @IBOutlet var open_hours: UILabel!
    
    @IBOutlet var container: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initialize the strings to set the lables with them
        if let name = self.name {
            self.place_name.text? = name
        }
        if let p = phoneNumber{
            place_phone.text? = p
        }
        if let add = self.address{
            self.place_address.text? = add
        }
        if let h = hours{
            open_hours.text? = h
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "wallpaper.jpg")!)
        
        self.container.layer.cornerRadius = 30
        //self.container.layer.shadowColor =
        
    }
    
    //get the lables values from the previous viewController
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
            let addressTry = address!
            let geoCoder = CLGeocoder()
            
            geoCoder.geocodeAddressString(addressTry, completionHandler: { (placemarks, error) in
                let longitude = placemarks?.first?.location?.coordinate.longitude
                let latitude = placemarks?.first?.location?.coordinate.latitude
                
                let addressURL = URL(string: "http://waze.com/ul?ll=\(latitude!),\(longitude!)&navigate=yes")
                // let addressURL = URL(string: "http://waze.com/ul?q=45.6906304,-120.810983&navigate=yes")
                
                UIApplication.shared.open(addressURL!, options: [:], completionHandler: nil)
                UIApplication.shared.isIdleTimerDisabled = true
                
            })
            ////
        } else {
            //else open a web url that says waze is not installed and link to appstore to download waze
            let url = URL(string:"http://www.itunes.apple.com/us/app/id323229106")
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
}
