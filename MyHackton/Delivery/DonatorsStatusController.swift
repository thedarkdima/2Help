import UIKit
import CoreLocation

class DonatorsStatusController: UIViewController {
    
    @IBOutlet var donatorNameLbl: UILabel!
    @IBOutlet var donatorsAddressLbl: UILabel!
    @IBOutlet var donatorNumberLbl: UILabel!
    @IBOutlet var donatorNoticesLbl: UITextView!
    
    private var donator : Request!
    private var RequestsList : [Request] = []

    private var index : Int!
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        donatorNameLbl.text = donator.getFullName()
        donatorsAddressLbl.text = donator.getAddress()
        donatorNumberLbl.text = donator.getPhoneNumber()
        donatorNoticesLbl.text = donator.getNotices()
    }
    
    
  //method to change address
    public func set(donator : Request, index : Int){
        self.donator = donator
        self.index = index

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
            var package = token + "&"
            package += "נלקח"
            package += "&" + donator.getId()
            ServerConnections.getDoubleArrayAsync("/request_status_change", [package], handler: {requests in
                    //self.RequestsList.remove(at:Int(self.donator.getId())!)
//                let lastPage = self.storyboard!.instantiateViewController(withIdentifier: "addresses") as! DeliveryRequestController
//                lastPage.RequestsList.remove(at: self.index)
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
