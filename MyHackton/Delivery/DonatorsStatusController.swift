import UIKit
import CoreLocation

class DonatorsStatusController: UIViewController {
    
    @IBOutlet var donatorNameLbl: UILabel!
    @IBOutlet var donatorsAddressLbl: UILabel!
    @IBOutlet var donatorNumberBtn: UIButton!
    @IBOutlet var donatorNoticesLbl: UITextView!
    @IBOutlet var donatorDateLbl: UILabel!
    
    private var donator : Request!
    private var RequestsList : [Request] = []

    private var index : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        donatorNameLbl.text = donator.getFullName()
        donatorsAddressLbl.text = donator.getAddress()
        donatorNumberBtn.setTitle(donator.getPhoneNumber(), for: .normal) 
        donatorNoticesLbl.text = donator.getNotices()
        donatorDateLbl.text = String(donator.getDate().prefix(donator.getDate().count - 5))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "wallpaper.jpg")!)
    }
    
    @IBAction func returnDeliveryBack(_ sender: UIButton) {
        //by clicking the button - and pressing confirm in the alert, the request will be send back to the map
        let alert = UIAlertController(title: "אשר החזרת משלוח", message: "האם אתה בטוח שברצונך להחזיר את המשלוח לרשימת המשלוחים במפה?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ביטול", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "אישור", style: .default, handler: { ok in
            self.sendBackRequest()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func sendBackRequest(){
        let prefs = UserDefaults.standard
        if let token = prefs.string(forKey: "token"){
            ServerConnections.getDoubleArrayAsync("/return_request", [token, donator.getId() + ""], handler: {requests in
                self.navigationController?.popViewController(animated: true)
            })
        } else {
            //Move back to the main page
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    
  //method to change address
    public func set(donator : Request, index : Int){
        self.donator = donator
        self.index = index

    }
    
    @IBAction func call(_ sender: Any) {
        //call the organization
        let numberToCall = (donatorNumberBtn.titleLabel?.text)!
        if let phoneURL = URL(string :"tel://" + numberToCall) {
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        }else{
            print("number is not good")
        }
    }
    
    //confirm the messanger took the products from the donator
    @IBAction func confirmBtn(_ sender: UIButton) {
        //by clicking the button - and pressing confirm in the alert, the product and address will be removed from the messsanger list(in the server), and the deliveries page will open
        let alert = UIAlertController(title: "אשר איסוף מוצרים", message: "האם אספת כעת את המוצרים מהלקוח?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ביטול", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "אישור", style: .default, handler: { ok in
            self.removeRequest()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    //need to add to server
    private func removeRequest(){
        let prefs = UserDefaults.standard
        if let token = prefs.string(forKey: "token"){
            ServerConnections.getDoubleArrayAsync("/request_status_change", [token, "נלקח", donator.getId() + ""], handler: {requests in
                self.navigationController?.popViewController(animated: true)
            })
        } else {
            //Move back to the main page
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func toWaze(_ sender: UIButton) {
        //check if waze installed on the iPhone
        if(UIApplication.shared.canOpenURL(URL(string:"waze://")!)){
            //to be able to read, the spaces need to be replaced with "+"
          ///  let address = (donatorsAddressLbl.text?.replacingOccurrences(of: " ", with: "+"))!
//            let address = "tel+aviv+yafo"
//            let addressURL = URL(string: "https://waze.com/ul?q=\(address)")
            
            // geocoding
            
            let addressTry = "פתח תקווה רוטשילד 119"
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
            
//            UIApplication.shared.open(addressURL!, options: [:], completionHandler: nil)
//            UIApplication.shared.isIdleTimerDisabled = true
        }else {
            //else open a web url that says waze is not installed and link to appstore to download waze
            let url = URL(string:"http://www.itunes.apple.com/us/app/id323229106")!
            //  let url = URL(string:"http://www.google.com/")!   //test
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
