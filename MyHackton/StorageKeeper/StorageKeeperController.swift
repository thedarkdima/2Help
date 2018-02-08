import UIKit

class StorageKeeperController: UIViewController, UITableViewDataSource {
  
    @IBOutlet var productsTable: UITableView!
    
    var products: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // show the products from the srever in a new task
        let url = URL(string: "http://2help-server.eu-gb.mybluemix.net/items")!
        URLSession.shared.dataTask(with: url, completionHandler: {(d,r,e) in
            AsyncTask(backgroundTask: { (d: Data) -> [String]? in
                return (try? JSONSerialization.jsonObject(with: d, options: .mutableContainers)) as? [String]
            }, afterTask: { products in
                self.products = products ?? []
                if products == nil {
                    print("nil was found HERE")
                }
                else {
                    print(products!)
                    
                    self.productsTable.reloadData()
                }
            }).execute(d!)
        }).resume()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storageCell") as! StorageKeeperCell
        
        cell.product.text! = products[indexPath.row]
        
        return cell
    }
    
    
    
        
}
