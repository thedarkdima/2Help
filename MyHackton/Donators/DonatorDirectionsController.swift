import UIKit

class DonatorDirectionsController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet var tbl: UITableView!
    
    @IBAction func openAlert() {
       
        
        let alert = UIAlertController(title: "ha", message: "ha", preferredStyle: .alert)
        
        let name = UIAlertAction(title: "שם", style: .default, handler: nil)
        let phone = UIAlertAction(title: "מספר טלפון", style: .default, handler: nil)
        let openHours = UIAlertAction(title: "שעות פעילות", style: .default, handler: nil)
        
        //waze handler//
        func toWaze(alert : UIAlertAction){
            //check if waze installed on the iPhone
            if(UIApplication.shared.canOpenURL(URL(string:"waze://")!)){
                let cell = tbl.dequeueReusableCell(withIdentifier: "address_cell") as! DonatorAddressCell
                
                let encodedAddressName = (cell.address_name.text?.replacingOccurrences(of: "", with: "+"))!
                
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
        alert.addAction(name)
        alert.addAction(phone)
        alert.addAction(openHours)
        // alert.addAction(waze)
       

        
        //let waze = UIAlertAction(title: "", style: .default, handler: toWaze)
        
        // waze.setValue(imageView, forKey: "waze_icon")
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //addresses example before server
    var DirectionsList: [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController!.navigationItem.rightBarButtonItem!.isEnabled = false
        tabBarController!.navigationItem.rightBarButtonItem!.title = ""
        tabBarController!.title = "סניפים"
    }
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ServerConnections.getDoubleArrayAsync("/addresses", "", handler: {addresses in
            if let add = addresses{
                for array in add{
                    self.DirectionsList.append(array[0])
                }
                self.table.reloadData()
            }
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DirectionsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "address_cell") as! DonatorAddressCell
        cell.address_name.text = DirectionsList[indexPath.row]
        
        return cell
    

    

        
    }

}
