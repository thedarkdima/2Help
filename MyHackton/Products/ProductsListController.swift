import UIKit

class ProductsListController: UIViewController , UITableViewDataSource {
    var products = ["chicken","drink","meat","bamba","milk"]
    
    // reading from server
    
    
    
    
    //
    
    override func viewDidLoad() {
      //  navigationController?.toolbar = "רשימת מוצרים"
        navigationItem.backBarButtonItem?.isEnabled = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productsCell")!
        return cell
    }
    
    
  
}
