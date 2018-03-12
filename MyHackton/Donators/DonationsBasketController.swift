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
        let scanPage = storyboard!.instantiateViewController(withIdentifier: "scanner") as! ScannerViewController
        
        navigationController?.pushViewController(scanPage, animated: true)
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
        } else {
            
        }
        return cell
    }
    ////

    
    @IBAction func addItemsManager(_ sender: Any) {
        var flag = false
        for i in 0...items.count - 1{
            let item = table.visibleCells[i] as! ProductsTableViewCell
            if(items[i][1] != item.name.text!){
                flag = true
                if(items[i][2] != item.counter.text!){
                    flag = true
                }
            }
        }
        if flag{
        } else {
            addItems()
        }
    }
    
    func addItems(){
        
    }
}
