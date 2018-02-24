import UIKit

class ProductsListController: UIViewController , UITableViewDataSource {
    var products = ["chicken","drink","meat","bamba","milk"]
    
    var pageTitle : String?
  
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = pageTitle!
    }
    
    override func viewDidLoad() {
      
    }
    
    //copy the title of the page from last page collection view label.
    func setTitle(title : String){
        pageTitle = title
    }
    
    //table view functions//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productsCell")!
        return cell
    }
    ////

}
