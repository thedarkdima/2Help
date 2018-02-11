import UIKit

class DonatorAddressCell: UITableViewCell {
    
    @IBOutlet var address_name: UILabel!
    
    @IBAction func toWaze(_ sender: UIButton) {
        
        if(UIApplication.shared.canOpenURL(URL(string:"waze://")!)){
            //check if waze installed on the iPhone
            let nameUrl = (address_name.text?.replacingOccurrences(of: " ", with: "+"))!
            //let nameUrl = address_name.text!
            
          //  let url = URL(string: "https://waze.com/ul?q=" + nameUrl!)!
            
            
            let address = "https://waze.com/ul?q=\(nameUrl)"
            let addressURL = URL(string:address)
            
          //  let url2 = URL(string : address.removingPercentEncoding!)
            
            UIApplication.shared.open(addressURL!, options: [:], completionHandler: nil)
            UIApplication.shared.isIdleTimerDisabled = true
        } else {
            //else open a web url that says waze is not installed and link to appstore to download waze
            let url = URL(string:"http://www.itunes.apple.com/us/app/id323229106")!
          //  let url = URL(string:"http://www.google.com/")!   //test
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

   

}
