import UIKit

class DonatorController: UIViewController ,UICollectionViewDelegate , UICollectionViewDataSource {
    
    @IBOutlet var tbl_products: UITableView!
    @IBOutlet var productsCollectionView: UICollectionView!
    @IBAction func phoneNumber(_ number: UIButton) {
        
        let numberToCall = (number.titleLabel?.text)!
        if let phoneURL = URL(string :"tel://" + numberToCall){
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        }
    
    }
    
    
    var totalCount: Int = 0
    var products: [String] = []
    
override func viewWillAppear(_ animated: Bool) {
        tabBarController!.navigationItem.rightBarButtonItem!.isEnabled = false
    if totalCount > 0 {
        tabBarController!.navigationItem.rightBarButtonItem!.isEnabled = true
    }
        tabBarController!.navigationItem.rightBarButtonItem!.title = "מלא פרטים"
        tabBarController!.title = "תרומות"
}
    
    

/*override func viewDidAppear(_ animated: Bool){
        // show the products from the server in a new task
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
    } */

    
override func viewDidLoad(){
    super.viewDidLoad()
    
}
    
    //Products Collection View//
    
    let productsArray = ["תחליפי חלב","מיוחדים של מטרנה","דייסות מטרנה","מחיות מטרנה","פסטה מטרנה","ביסקוויט מטרנה"]
    let productsImage: [UIImage] = [ UIImage(named:"daisa")!,
                                     UIImage(named:"special")!,
                                     UIImage(named:"tamal")!,
                                     UIImage(named:"biscate")!,
                                     UIImage(named:"pasta")!,
                                     UIImage(named:"canes")!]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product_cell", for: indexPath) as! ProductsCollectionViewCell
        cell.productLabel.text = productsArray[indexPath.item]
        cell.ProductImageView.image = productsImage[indexPath.item]
       
        return  cell
    }
    
    
    ////
    
    // dependency injection - update the count from each dontaorProductCell
    func updateCount(c : Int){
        totalCount += c
        
        //enable the button press if count is bigger than 0
        tabBarController!.navigationItem.rightBarButtonItem!.isEnabled = totalCount > 0
    }
    ////
    
}

