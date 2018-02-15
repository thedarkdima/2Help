import UIKit

class DeliveryRequestController: UIViewController, UITableViewDataSource ,UITableViewDelegate {
    
    private var RequestsList : [Request] = []
    private var donator : Request!
    
    override func viewWillAppear(_ animated: Bool) {
        let b = UIBarButtonItem(title: "התנתק", style: .plain, target: self, action: #selector(backcheck) )
        
            self.navigationItem.hidesBackButton = true
            self.navigationItem.leftBarButtonItem = b
    }
    
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "חזור", style: .plain, target: nil, action: nil)
        
        let prefs = UserDefaults.standard
        if let token = prefs.string(forKey: "token"){
            ServerConnections.getDoubleArrayAsync("/myrequests", token, handler: {requests in
                if let reqs = requests{
                    for request in reqs{
                        self.RequestsList.append(Request(id: request[0], fullName: request[1], address: request[2], phoneNumber: request[3], notice: request[4], status: request[5]))
                    }
                    self.table.reloadData()
                }
            })
        } else {
            //Move back to the main page
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc func backcheck(){
        //let main = storyboard!.instantiateViewController(withIdentifier: "main")
        let alert =  UIAlertController(title:"יציאה מהמערכת", message: "האם אתה בטוח שברצונך להתנתק מהמערכת?", preferredStyle: .alert)
        
        func okHandler(alert: UIAlertAction!){
              navigationController?.popToRootViewController(animated: true)
           
        }
        alert.addAction(UIAlertAction(title: "ביטול", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "אישור", style: .default, handler: okHandler))
        
        present(alert, animated: true, completion: nil)
        
       
    }
    //table view methods//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RequestsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requests_list_ofDelivery") as! DeliveryRequestCell
        cell.address.text = RequestsList[indexPath.row].getAddress()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! DeliveryRequestCell
        let next = storyboard?.instantiateViewController(withIdentifier: "statusPage") as! DonatorsStatusController
        
        next.set(address: cell.address.text!)
        //RequestsList.remove(at: indexPath.row)
        show(next, sender: self)
        self.navigationItem.backBarButtonItem?.title = "חזור"
    }
    ////
    
    func setDonatorObj(donator : Request){
        self.donator = donator
    }

    
   
}
