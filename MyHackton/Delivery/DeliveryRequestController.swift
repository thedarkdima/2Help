import UIKit

class DeliveryRequestController: UIViewController, UITableViewDataSource ,UITableViewDelegate {
    
    private var RequestsList : [Donator] = []
    private var donator : Donator!
    
    override func viewWillAppear(_ animated: Bool) {
        let b = UIBarButtonItem(title: "התנתק", style: .plain, target: self, action: #selector(backcheck) )
        
            self.navigationItem.hidesBackButton = true
            self.navigationItem.leftBarButtonItem = b
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "חזור", style: .plain, target: nil, action: nil)
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requests_list_ofDelivery") as! DeliveryRequestCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! DeliveryRequestCell
        let next = storyboard?.instantiateViewController(withIdentifier: "statusPage") as! DonatorsStatusController
        
        next.set(address: cell.adress.text!)
        //RequestsList.remove(at: indexPath.row)
        show(next, sender: self)
        self.navigationItem.backBarButtonItem?.title = "חזור"
    }
    ////
    
    func setDonatorObj(donator : Donator){
        self.donator = donator
    }

    
   
}
