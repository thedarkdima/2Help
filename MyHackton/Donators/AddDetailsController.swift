import UIKit
import MapKit

class AddDetailsController: UIViewController {
    @IBOutlet var city: UITextField!
    @IBOutlet var street: UITextField!
    
    var address: String!
    @IBOutlet var name: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var notes:UITextView!
    
    @IBOutlet var sendLabel: UIButton!

    @IBOutlet weak var notice: UILabel!
    
    let prefs = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        notice.isHidden = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.name.returnKeyType = .next
        //self.address.returnKeyType = .next
        self.phone.returnKeyType = .done
        self.notes.returnKeyType = .done
        
        if let prefsInfo = prefs.stringArray(forKey: "info"){
            name.text = prefsInfo[0]
            //address.text = prefsInfo[1]
            phone.text = prefsInfo[2]
            notes.text = prefsInfo[3]
        }
    }
    
    @IBAction func sendBtn(_ sender: UIButton) {
        address = city.text! + " " + street.text!
        if (!(address.isEmpty) &&  (address.count != 0) && !(name.text?.isEmpty)! && !(phone.text?.isEmpty)!){
            notice.isHidden = true
            //checkAddress(address: address.text!)
            var basket:[String:[String]] = [:]
            if let prefsBasket = prefs.dictionary(forKey: "basket"){
                basket = prefsBasket as! [String: [String]]
                for key in basket.keys{
                    if Int(basket[key]![0])! < 1{
                        basket.removeValue(forKey: key)
                    }
                }
                prefs.set(basket, forKey: "basket")
            }
            prefs.set([name.text!, address!, phone.text!, notes.text!], forKey: "info")
            if(basket.count > 0){
                var package = [[name.text!, address!, phone.text!, notes.text!]]
                for array in basket{
                    package.append([array.key, array.value[0]])
                }
                ServerConnections.getDoubleArrayAsync("/add_request", package, handler: {back in
                    self.notice.isHidden = false
                    self.notice.text = "בקשתכם איתקבלה בהצלחה"
                })
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
                        print("reverse geodcode error. \(error.debugDescription)")
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
