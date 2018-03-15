import UIKit
import MapKit

class AddDetailsController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
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
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "wallpaper.jpg")!)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.name.returnKeyType = .next
        self.phone.returnKeyType = .done
        self.notes.returnKeyType = .done
        
        //Add delgate for the animation for all the textfields
        city.delegate = self
        street.delegate = self
        name.delegate = self
        phone.delegate = self
        notes.delegate = self
        
        //Change the look of the notes
        //UIColor borderColor = [UIColor colorWithRed: 204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0]
        let borderColor = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        
        notes.layer.borderColor = borderColor.cgColor
        notes.layer.borderWidth = 1.0
        notes.layer.cornerRadius = 5.0
        
        if let prefsInfo = prefs.stringArray(forKey: "info"){
            name.text = prefsInfo[0]
            city.text = prefsInfo[1]
            street.text = prefsInfo[2]
            phone.text = prefsInfo[3]
            if prefsInfo[4] == ""{
                notes.text = "הערות?"
            } else {
                notes.text = prefsInfo[4]
            }
        }
    }
    
    @IBAction func sendBtn(_ sender: UIButton) {
        if name.text!.count != 0 {
            if city.text!.count != 0 {
                if street.text!.count != 0 {
                    address = city.text! + " " + street.text!
                    let geoCoder = CLGeocoder()
                    geoCoder.geocodeAddressString(address, completionHandler: { (placemarks, error) in
                        if let _ = placemarks?.first?.location?.coordinate.longitude{
                            if let _ = placemarks?.first?.location?.coordinate.latitude{
    
                                if self.phone.text!.count != 0 {
                                    self.notice.isHidden = true
                                    //checkAddress(address: address.text!)
                                    var basket:[String:[String]] = [:]
                                    if let prefsBasket = self.prefs.dictionary(forKey: "basket"){
                                        basket = prefsBasket as! [String: [String]]
                                        for key in basket.keys{
                                            if Int(basket[key]![0])! < 1{
                                                basket.removeValue(forKey: key)
                                            }
                                        }
                                        self.prefs.set(basket, forKey: "basket")
                                    }
                                    self.prefs.set([self.name.text!, self.city.text!, self.street.text!, self.phone.text!, self.notes.text!], forKey: "info")
                                    if(basket.count > 0){
                                        var note = ""
                                        if self.notes.text! != "הערות?" {
                                            note = self.notes.text!
                                        }
                                        var package = [[self.name.text!, self.address!, self.phone.text!, note]]
                                        for array in basket{
                                            package.append([array.key, array.value[0]])
                                        }
                                        ServerConnections.getDoubleArrayAsync("/add_request", package, handler: {back in
                                            self.notice.isHidden = false
                                            self.notice.text = "בקשתכם איתקבלה בהצלחה"
                                            self.prefs.set([:], forKey: "basket")
                                        })
                                    } else {
                                        self.notice.isHidden = false
                                        self.notice.text = "הסל רייק"
                                    }
                                } else {
                                    self.TextAnimation(textField: self.phone)
                                }
                            } else {
                                self.TextAnimation(textField: self.street)
                                self.TextAnimation(textField: self.city)
                            }
                        } else {
                            self.TextAnimation(textField: self.street)
                            self.TextAnimation(textField: self.city)
                        }
                    })
                } else {
                    TextAnimation(textField: street)
                }
            } else {
                TextAnimation(textField: city)
            }
        } else {
            TextAnimation(textField: name)
        }
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if(notes.text! == "הערות?"){
            notes.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if(notes.text! == ""){
            notes.text = "הערות?"
        }
    }
    
    func TextAnimation(textField: UITextField){
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            textField.center.x += 10
        }, completion: nil)
        
        UIView.animate(withDuration: 0.1, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            textField.center.x -= 20
        }, completion: nil)
        
        UIView.animate(withDuration: 0.1, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            textField.center.x += 10
        }, completion: nil)
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
                    
                    //let pm = placemarks! as [CLPlacemark]
            })
            
        })
    }
    
}
