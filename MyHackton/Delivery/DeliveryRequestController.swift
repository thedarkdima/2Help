import UIKit

class DeliveryRequestController: UIViewController, UITableViewDataSource ,UITableViewDelegate {
    
    private var RequestsList : [Donator] = []
    private var donator : Donator!
    
    override func viewWillAppear(_ animated: Bool) {
        let b = UIBarButtonItem(title: "התנתק", style: .plain, target: self, action: #selector(backcheck) )
        
      
            self.tabBarController?.navigationItem.hidesBackButton = true
            self.tabBarController?.navigationItem.leftBarButtonItem = b
        
     
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
      
    }
    
    
    @objc func backcheck(){
        //let main = storyboard!.instantiateViewController(withIdentifier: "main")
        let alert =  UIAlertController(title:"יציאה מהמערכת", message: "האם אתה בטוח שברצונך להתנתק מהמערכת?", preferredStyle: .alert)
        
        func okHandler(alert: UIAlertAction!){
           // let main = storyboard?.instantiateViewController(withIdentifier: "main") as! MainController
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
        tabBarController?.navigationItem.backBarButtonItem?.title = "חזור"
    }
    ////
    
    func setDonatorObj(donator : Donator){
        self.donator = donator
    }

    
   
}
