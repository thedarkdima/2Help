import UIKit

class DonatorConroller: UIViewController, UITableViewDataSource {
    
    //Table and textfield outlets
    @IBOutlet var tbl_products: UITableView!
    @IBOutlet var tf_money: UITextField!
    
    //example for table
    var str : [Int] = [1,2,3,4,5,6,7,8,9,10]
    
    /////
    //typealias Coin = [String: Any]
    
//    var coins: [Coin] = []
//    @IBOutlet var tbl: UITableView!
//
//    override func viewDidAppear(_ animated: Bool) {
//        let url = URL(string: "https://api.coinmarketcap.com/v1/ticker/?limit=10")!
//        URLSession.shared.dataTask(with: url, completionHandler: {(d,r,e) in
//            AsyncTask(backgroundTask: { (d: Data) -> [Coin]? in
//                return (try? JSONSerialization.jsonObject(with: d, options: .mutableContainers)) as? [Coin]
//            }, afterTask: { coins in
//                if coins == nil {print("nil was found HERE")}
//                self.coins = coins ?? []
//                self.tbl.reloadData()
//            }).execute(d!)
//        }).resume()
//    }
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return coins.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        let index = indexPath.row
//        cell.textLabel?.text = "\(coins[index]["name"]!) \(coins[index]["price_usd"]!)"
//        return cell
//    }
    
    
    ///////
    var products: [String] = []
    
    override func viewDidAppear(_ animated: Bool) {
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
                    self.tbl_products.reloadData()
                }
            }).execute(d!)
        }).resume()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Products table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! DonatorProductsCell
      
        cell.productName.text = products[indexPath.row]
        
        return cell
    }
    

}

