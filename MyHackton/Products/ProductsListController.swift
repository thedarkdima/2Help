import UIKit

class ProductsListController: UIViewController , UITableViewDataSource {
    
    //var products = [""]
    
    @IBOutlet var productsTable: UITableView!
    //var to store later the page title
    var pageTitle : String?
    //var to store later the products
    var productsArray: [[String]] = [[]]
    //var to store later product image
    var productImage : UIImage!
  
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = pageTitle!
        getProducts()
    }
    
    @IBAction func addToBasket(_ sender: UIButton) {
        
        //let basketPage = storyboard!.instantiateViewController(withIdentifier: "basket") as! DonationsBasketController
        let prefs = UserDefaults.standard
        var basket: [String: [String]] = [:]
        if let prefsBasket = prefs.dictionary(forKey: "basket"){
            basket = prefsBasket as! [String: [String]]
        }
        var index = 0
        for cell in productsTable.visibleCells as! [ProductsTableViewCell] {
            let name = cell.name.text!
            let count = cell.count
            if count > 0{
                if let keyExists = basket[name]{
                    basket.updateValue([String(Int(keyExists[0])! + count), keyExists[1]], forKey: name)
                } else {
                    basket.updateValue([String(count), productsArray[index][4]], forKey: name)
                }
            }
            index += 1
        }
        prefs.set(basket, forKey: "basket")
        print(basket)
        navigationController?.popViewController(animated: false)
        
        //present(basketPage, animated: true, completion: nil)
        
        //show(basketPage, sender: self)
    }
    
    //// server////
    func getProducts(){
        ServerConnections.getDoubleArrayAsync("/items", [pageTitle!], handler: {products in
            //self.productsArray = []
            if let temp = products{
                self.productsArray = temp
                
                self.productsTable.reloadData()
            }
            //print(self.productsArray)
        })
    }
    
    /////

    
    //copy the title of the page from last page collection view label.
    func setTitle(title : String){
        pageTitle = title
    }
    
//    //copy the current product image from last page collection view image.
//    func setImage(image : UIImage){
//        //just need to store pics
//        productImage = image
//
//    }
    
    //table view functions//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsCounts[section]
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productsCell")! as! ProductsTableViewCell
        
        //change the product image to the apropiate one
        cell.product_image.image = self.productImage
        
        var count = 0
        print(indexPath.section)
        for i in 0...sectionsCounts.count{
            if(i == indexPath.section){
                break
            }
            count += sectionsCounts[i]
        }
        cell.setName(name: productsArray[count + indexPath.row][0])
        do {
            if let url = URL(string: productsArray[count + indexPath.row][4]){
                let data = try Data(contentsOf: url)
                if let uiImage = UIImage(data: data){
                    cell.product_image.image = uiImage
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        //cell.product_image.image = productsArray[count + indexPath.row][4]

        return cell
    }
    
    //sections//
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sections[section]
    }
    
    var sections: [String] = []
    var sectionsCounts: [Int] = []
    func numberOfSections(in tableView: UITableView) -> Int {
        sections = []
        sectionsCounts = []
        for product in productsArray{
            if (sections.count == 0 || sections[sections.count - 1] != product[2]) && product.count > 0{
                sections.append(product[2])
                sectionsCounts.append(0)
            }
            if sectionsCounts.count > 0{
                sectionsCounts[sectionsCounts.count - 1] += 1
            }
        }
        return sections.count
    }
    ////
    
}
