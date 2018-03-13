import UIKit

class DonationsBasketController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var scannedCode = ""
    var backButton : UIBarButtonItem!
    //Manager
    var manager = false
    var token = ""
    var request: [String] = []
    var items: [[String]] = [[]]
    //

    var productImage : UIImage!

    @IBOutlet var table: UITableView!
    
    @IBAction func toAddDetailsController(_ sender: UIBarButtonItem) {
        let nextPage = storyboard!.instantiateViewController(withIdentifier: "donator_details")
        navigationController?.pushViewController(nextPage, animated: true)
        //show(nextPage, sender: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let prefs = UserDefaults.standard
        if manager{
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
            if let prefsBasket = prefs.dictionary(forKey: "basket"){
                basket = prefsBasket as! [String: [String]]
                for key in basket.keys{
                    if Int(basket[key]![0])! < 1{
                        basket.removeValue(forKey: key)
                    }
                }
                prefs.set(basket, forKey: "basket")
                print(basket)
            }
        }
    }
    
    //move to scannerViewController to scan barcodes
    @IBAction func scanBarcode(_ sender: UIButton) {
        print("in")
        let scanPage = storyboard!.instantiateViewController(withIdentifier: "scanner") as! ScannerViewController
        //let fromDonatorMenu = storyboard?.instantiateViewController(withIdentifier: "collection")
        
        let i = navigationController?.viewControllers.index(of: self)
        let previousViewController = navigationController?.viewControllers[i!-1]
        print((previousViewController?.restorationIdentifier)!)
        if(previousViewController == scanPage){
            navigationController?.pushViewController(scanPage, animated: true)
            
        } else {
       // navigationController?.popToViewController(scanPage, animated: true)
           self.dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    //table view functions//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(manager){
            if items.count > 0{
                if items[0].count > 0{
                    return items.count
                } else {
                    return 0
                }
            } else {
                return 0
            }
        } else {
            return basket.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "products_cell")! as! ProductsTableViewCell
        cell.manager = manager
        if manager{
            cell.name.text = items[indexPath.row][1]
            cell.counter.text = items[indexPath.row][2]
            cell.count = Int(items[indexPath.row][2])!
        } else {
            let key = Array(basket.keys)[indexPath.row]
            cell.name.text = key
            cell.counter.text = basket[key]![0]
            cell.count = Int(basket[key]![0])!
            do {
                if let url = URL(string: basket[key]![1]){
                    let data = try Data(contentsOf: url)
                    if let uiImage = UIImage(data: data){
                        cell.product_image.image = uiImage
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
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
    
    ///Warehouse Manager
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
    ///
}
