import UIKit

class DonatorController: UIViewController ,UICollectionViewDelegate , UICollectionViewDataSource {
    
    @IBOutlet var productsCollectionView: UICollectionView!
  
    //collection view variables//
    
    //var to store later each product name
    var productName : String?
    //var to store later array of products names
    var productsNamesArray : [String] = []
    //var to store later each product image
    var productImage: UIImage?
    //var to store later array of products images
    var productsImagesArray: [String] = []
    ////
    
override func viewWillAppear(_ animated: Bool) {
    tabBarController!.navigationItem.rightBarButtonItem!.isEnabled = true
    tabBarController!.navigationItem.rightBarButtonItem!.title = "לסל תרומות"
    tabBarController!.navigationItem.backBarButtonItem?.title = "חזור"
    
    let prefs = UserDefaults.standard
    if let _ = prefs.string(forKey: "barcode"){
        prefs.removeObject(forKey: "barcode")
        let basketViewController = storyboard?.instantiateViewController(withIdentifier: "basket") as! DonationsBasketController
        self.navigationController?.pushViewController(basketViewController, animated: false)
    }
}
    override func viewDidAppear(_ animated: Bool) {
        tabBarController!.title = tabBarItem!.title
        tabBarController!.navigationItem.rightBarButtonItem!.isEnabled = true

    }
    
override func viewDidLoad(){
    super.viewDidLoad()
    getProductsTypes()
    tabBarController!.navigationItem.rightBarButtonItem!.isEnabled = true
        
}
    
    @IBAction func phoneNumber(_ number: UIButton) {
        let numberToCall = (number.titleLabel?.text)!
        if let phoneURL = URL(string :"tel://" + numberToCall){
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        }
        
    }
    
    @IBAction func scanBarcode(_ sender: UIButton) {
        let scanPage = storyboard!.instantiateViewController(withIdentifier: "scanner") as! ScannerViewController
        
        //present(scanPage, animated: true, completion: nil)
        navigationController?.pushViewController(scanPage, animated: true)
    }
    
    
    //server//
    func getProductsTypes(){
        ServerConnections.getDoubleArrayAsync("/itemstypes", [""], handler: {types in
            self.productsNamesArray = []
            //unwrap - make sure ther is data in the array
            if let typs = types{
                //get data from server
                for type in typs{
                    //each loop add one product name
                    self.productsNamesArray.append(type[0])
                    self.productsImagesArray.append(type[1])
                   
                    //creating a dataTask
                    if let url = URL(string: type[1]){
                        URLSession.shared.dataTask(with:url){ (data, response, error) in
                            //if there is any error
                            if let e = error{
                                //displaying the message
                                print("Error Occurred: \(e)")
                            } else {
                                //in case of now error, checking wheather the response is nil or not
                                if (response as? HTTPURLResponse) != nil{
                                    //checking if the response contains an image
                                    if let imageData = data{
                                        //displaying the image
                                        DispatchQueue.main.async{
                                            if let prefImageData = UserDefaults.standard.object(forKey: url.absoluteString){
                                                if prefImageData as! Data != imageData{
                                                    UserDefaults.standard.set(imageData, forKey: url.absoluteString)
                                                    self.productsCollectionView.reloadData()
                                                }
                                            } else {
                                                UserDefaults.standard.set(imageData, forKey: url.absoluteString)
                                                self.productsCollectionView.reloadData()
                                            }
                                        }
                                    } else {
                                        print("Image file is currupted")
                                    }
                                } else {
                                    print("No response from server")
                                }
                            }
                            }.resume()
                    }
                }
                self.productsCollectionView.reloadData()
            }
        })
    }
    ////
    
    //Products Collection View//
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsNamesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product_cell", for: indexPath) as! ProductsCollectionViewCell
        cell.productLabel.text = productsNamesArray[indexPath.item]
        //Prevents out of bounds exception
        if productsImagesArray.count > indexPath.item{
            //Get image from user defaults
            if let prefImageData = UserDefaults.standard.object(forKey: productsImagesArray[indexPath.item]){
                cell.ProductImageView.image = UIImage(data: prefImageData as! Data)
            }
        }
        return  cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
        let productsList = storyboard!.instantiateViewController(withIdentifier: "productsList") as! ProductsListController
        
        //save the title of the product
        productName = productsNamesArray[indexPath.row]
    
        //move the title to the next page so it can be used as page title
        productsList.setTitle(title: productName!)
        show(productsList, sender: self)
    }
    ////

}
