import UIKit

class DonatorAddressCell: UITableViewCell {
    
    @IBOutlet var address_name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func openAlertBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "ha", message: "ha", preferredStyle: .alert)
        
        let name = UIAlertAction(title: "שם", style: .default, handler: nil)
        let phone = UIAlertAction(title: "מספר טלפון", style: .default, handler: nil)
        let openHours = UIAlertAction(title: "שעות פעילות", style: .default, handler: nil)
        
        //waze handler//
        func toWaze(alert : UIAlertAction){
            //check if waze installed on the iPhone
            if(UIApplication.shared.canOpenURL(URL(string:"waze://")!)){
                
                let encodedAddressName = (address_name.text?.replacingOccurrences(of: "", with: "+"))!
                
                let address = "https://waze.com/ul?q=\(encodedAddressName)"
                let addressURL = URL(string: address)
                
                print("\(addressURL!)")
                
                UIApplication.shared.open(addressURL!, options: [:], completionHandler: nil)
                UIApplication.shared.isIdleTimerDisabled = true
            } else {
                //else open a web url that says waze is not installed and link to appstore to download waze
                let url = URL(string:"http://www.itunes.apple.com/us/app/id323229106")!
                //  let url = URL(string:"http://www.google.com/")!   //test
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            ////
                }
        }
        
        //let waze = UIAlertAction(title: "", style: .default, handler: toWaze)
        
       // waze.setValue(imageView, forKey: "waze_icon")
        
        alert.addAction(name)
        alert.addAction(phone)
        alert.addAction(openHours)
       // alert.addAction(waze)
    
       
        
    }

}
