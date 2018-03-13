import UIKit
import MapKit

class AddDetailsController: UIViewController {
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var sendLabel: UIButton!
    @IBOutlet weak var notes:UITextView!
    
    @IBOutlet weak var notice: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        notice.isHidden = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.name.returnKeyType = .next
        self.address.returnKeyType = .next
        self.phone.returnKeyType = .done
        self.notes.returnKeyType = .done
        
    }
    
    
    
    
    @IBAction func sendBtn(_ sender: UIButton) {
        
        if (!(address.text?.isEmpty)! &&  (address.text?.count != 0) && !(name.text?.isEmpty)! && !(phone.text?.isEmpty)!){
            notice.isHidden = true
            checkAddress(address: address.text!)
            var basket:[String:[String]] = [:]
            let prefs = UserDefaults.standard
            if let prefsBasket = prefs.dictionary(forKey: "basket"){
                basket = prefsBasket as! [String: [String]]
                for key in basket.keys{
                    if Int(basket[key]![0])! < 1{
                        basket.removeValue(forKey: key)
                    }
                }
                prefs.set(basket, forKey: "basket")
            }
            if(basket.count > 0){
                var package = [[name.text!, address.text!, phone.text!, notice.text!]]
                for array in basket{
                    package.append(array.value)
                }
                ServerConnections.getDoubleArrayAsync("/add_request", package, handler: {back in})
            }
        } else {
            notice.isHidden = false
            notice.text = "שגיאה ! אנא בדוק שלא הפרטים שהזנת תקינים !"
        }
        
    }
    
    func checkAddress(address : String){
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(address, completionHandler: { (placemarks, error) in
            let longitude = placemarks?.first?.location?.coordinate.longitude
            let latitude = placemarks?.first?.location?.coordinate.latitude
            UIApplication.shared.isIdleTimerDisabled = true
            
            let loction: CLLocation = CLLocation(latitude:latitude!, longitude: longitude!)
            
            geoCoder.reverseGeocodeLocation(loction, completionHandler:
                {(placemarks, error) in
                    if (error != nil)
                    {
                        print("reverse geodcode error)")
                    }
                    
                    let pm = placemarks! as [CLPlacemark]
                    
                    if pm.count > 0 {
                        let pm = placemarks![0]
                        print(pm.country!)
                        
                        var addressString : String = ""
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "
                        }
                        if pm.country != nil {
                            addressString = addressString + pm.country! + ", "
                        }
                        
                        print(addressString)
                    }
            })
            
            
        })
    }
    
}

