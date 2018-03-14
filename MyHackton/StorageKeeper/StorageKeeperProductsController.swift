import UIKit

class StorageKeeperProductsController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var table: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "products_cell")! as! ProductsTableViewCell
        if items[0].count > 0{
            cell.manager = true
            cell.name.text = items[indexPath.row][1]
            cell.counter.text = items[indexPath.row][2]
            cell.count = Int(items[indexPath.row][2])!
        }
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let b = UIBarButtonItem(title: "התנתק", style: .plain, target: self, action: #selector(backcheck))
        tabBarController?.navigationItem.leftBarButtonItem = b
       
    }
    
    var request: [String] = []
    var items: [[String]] = [[]]
    var token = ""
    let prefs = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tok = prefs.string(forKey: "token"){
            token = tok
            navigationItem.title = "הוסף למלאי"
            ServerConnections.getDoubleArrayAsync("/warehouse_items", [token], handler: {itemsArray in
                if let array = itemsArray{
                    self.items = array
                    self.table.reloadData()
                }
            })
        }
    }
    
    var changedItems: [[String]] = []
    @IBAction func addItemsManager(_ sender: Any) {
        var flag = false
        for i in 0...items.count - 1{
            let item = table.visibleCells[i] as! ProductsTableViewCell
            if(items[i][2] != item.counter.text!){
                flag = true
                changedItems.append(["", items[i][1], String(-(Int(items[i][2])! - item.count))])
            }
        }
        if flag{
            showAlert(flag: false)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func showAlert(flag: Bool){
        let alert = UIAlertController(title: "שינוי כמות", message: "אתה בטוח שאתה רוצה לעדכן את הכמות?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "ביטול", style: .cancel, handler: nil)
        let accept = UIAlertAction(title: "אישור", style: .default, handler: { action in
        self.addItems()
        })
        alert.addAction(cancel)
        alert.addAction(accept)
        present(alert, animated: true, completion: nil)
    }
    
    func addItems(){
        changedItems.insert([token, "חולון התחיה 10"], at: 0)
        ServerConnections.getDoubleArrayAsync("/addItems", changedItems, handler: {array in
            self.navigationController?.popViewController(animated: true)
        })
    }
//    func getImages(){
//        for product in basket{
//            if let url = URL(string: product.value[1]){
//                URLSession.shared.dataTask(with:url){ (data, response, error) in
//                    //if there is any error
//                    if let e = error{
//                        //displaying the message
//                        print("Error Occurred: \(e)")
//                    } else {
//                        //in case of now error, checking wheather the response is nil or not
//                        if (response as? HTTPURLResponse) != nil{
//                            //checking if the response contains an image
//                            if let imageData = data{
//                                //displaying the image
//                                DispatchQueue.main.async{
//                                    if let prefImageData = UserDefaults.standard.object(forKey: url.absoluteString){
//                                        if prefImageData as! Data != imageData{
//                                            UserDefaults.standard.set(imageData, forKey: url.absoluteString)
//                                            self.table.reloadData()
//                                        }
//                                    } else {
//                                        UserDefaults.standard.set(imageData, forKey: url.absoluteString)
//                                        self.table.reloadData()
//                                    }
//                                }
//                            } else {
//                                print("Image file is currupted")
//                            }
//                        } else {
//                            print("No response from server")
//                        }
//                    }
//                    }.resume()
//            }
//        }
//    }
    
    //logout from the system
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

    
}
