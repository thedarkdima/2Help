import UIKit

class DonationsBasketController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var scannedCode = ""
    var backButton : UIBarButtonItem!
    //Manager
    var manager = false
    var token = ""
    var request: [String] = []
    var items: [[String]] = [[]]
    @IBOutlet var table: UITableView!
    //
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if manager{
            let prefs = UserDefaults.standard
            if let tok = prefs.string(forKey: "token"){
                token = tok
                navigationItem.title = "הוסף למלאי"
                ServerConnections.getDoubleArrayAsync("/request_items", [token, request[0]], handler: {itemsArray in
                    if let array = itemsArray{
                        self.items = array
                        self.table.reloadData()
                    }
                })
            }
        } else {
            navigationItem.title = "סל תרומות"
            print(scannedCode)
            
        }
    }
    
    //move to scannerViewController to scan barcodes
    @IBAction func scanBarcode(_ sender: UIButton) {
        print("in")
        let scanPage = storyboard!.instantiateViewController(withIdentifier: "scanner") as! ScannerViewController
        let fromDonatorMenu = storyboard?.instantiateViewController(withIdentifier: "collection")
        
        let i = navigationController?.viewControllers.index(of: self)
        let previousViewController = navigationController?.viewControllers[i!-1]
        
        if(previousViewController == scanPage){
            print("s1")
            navigationController?.pushViewController(scanPage, animated: true)
            
        } else {
            print("ssss")
       // navigationController?.popToViewController(scanPage, animated: true)
           self.dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    //table view functions//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(manager){
            if items[0].count > 0{
                return items.count
            } else {
                return 0
            }
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "products_cell")! as! ProductsTableViewCell
        if manager{
            cell.name.text = items[indexPath.row][1]
            cell.counter.text = items[indexPath.row][2]
            cell.count = Int(items[indexPath.row][2])!
        } else {
            
        }
        return cell
    }
    ////
    var text: UITextField!
    func showAlert(flag: Bool){
        let alert = UIAlertController(title: "חריגה", message: "סיבה לשינוי הכמות", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "ביטול", style: .cancel, handler: nil)
        let accept = UIAlertAction(title: "אישור", style: .default, handler: { action in
            if self.text.text!.count != 0{
                self.addReason()
                self.addItems()
            } else {
                self.showAlert(flag: true)
            }
        })
        
        alert.addTextField { (tf) in
            tf.textAlignment = .right
            tf.returnKeyType = .next
            self.text = tf
            if flag{
                tf.placeholder = "חייב להכניס סיבה"
            }
        }
        alert.addAction(cancel)
        alert.addAction(accept)
        present(alert, animated: true, completion: nil)
    }
    
    var changedItems = ""
    @IBAction func addItemsManager(_ sender: Any) {
        var flag = false
        for i in 0...items.count - 1{
            let item = table.visibleCells[i] as! ProductsTableViewCell
            if(items[i][2] != item.counter.text!){
                flag = true
                changedItems += "\(items[i][1]):\(item.count - Int(items[i][2])!)&"
            }
        }
        if flag{
            showAlert(flag: false)
        } else {
            addItems()
        }
    }
    
    
    func addItems(){
        items.insert([token, "חולון התחיה 10"], at: 0)
        ServerConnections.getDoubleArrayAsync("/addItems", items, handler: {array in
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    func addReason(){
        ServerConnections.getArrayAsync("/add_reason", [token, request[0], text.text!, changedItems], handler: { array in
            
        })
    }
}
