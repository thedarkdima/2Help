import UIKit

class DonatorsStatusController: UIViewController {
    
    @IBOutlet var donatorsAddressLbl: UILabel!
    
    private var address: String!
    
    override func viewWillAppear(_ animated: Bool) {
       // donatorsAddressLbl.text = address
        donatorsAddressLbl.text = "tel aviv hahagana train station "
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
  //method to change address
    public func set(address: String){
        self.address = address
    }
    
    //confirm the messanger took the products from the donator
    @IBAction func confirmBtn(_ sender: UIButton) {
        //by clicking the button - and pressing confirm in the alert, the product and address will be removed from the messsanger list, and the deliveries page will open
        let alert = UIAlertController(title: "אשר איסוף מוצרים", message: "האם אספת כעת את המוצרים מהלקוח?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ביטול", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "אישור", style: .default, handler: { ok in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func toWaze(_ sender: UIButton) {
        //check if waze installed on the iPhone
        if(UIApplication.shared.canOpenURL(URL(string:"waze://")!)){
            
            let NameUrl = (donatorsAddressLbl.text?.replacingOccurrences(of: " ", with: "+"))!
            
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
