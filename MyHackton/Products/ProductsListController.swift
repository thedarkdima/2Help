import UIKit

class ProductsListController: UIViewController , UITableViewDataSource {
    var products = [""]
    
    @IBOutlet weak var productsTable: UITableView!
    var pageTitle : String?
    var productsArray: [[String]] = [[]]
  
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = pageTitle!
        getProducts()
    }
    
    
    ///// server
    
    func getProducts(){
        ServerConnections.getDoubleArrayAsync("/items", [pageTitle!], handler: {products in
            //self.productsArray = []
            if let temp = products{
                self.productsArray = temp
                
                self.productsTable.reloadData()
            }
            print(self.productsArray)
        })
    }
    
    /////

    
    
    //copy the title of the page from last page collection view label.
    func setTitle(title : String){
        pageTitle = title
    }
    
    //table view functions//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsCounts[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productsCell")! as! ProductsTableViewCell
        var count = 0
        print(indexPath.section)
        for i in 0...sectionsCounts.count{
            if(i == indexPath.section){
                break
            }
            count += sectionsCounts[i]
        }
        cell.setName(name: productsArray[count + indexPath.row][0])
        return cell
    }
    
    //sections
    
    
    
    
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
