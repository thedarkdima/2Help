import UIKit

class DonatorController: UIViewController ,UICollectionViewDelegate , UICollectionViewDataSource {
    
    @IBOutlet var productsCollectionView: UICollectionView!
  
   
    //collection view variables//
    
    //var to store later each product name
    var productName : String?
    //var to store later array of products names
    var productsNamesArray : [String] = []
    
    //stored images url's in strings to use later to open products images
    //var images_URLs : [String] = []
    
     //var to store later each product image
    var productImage: UIImage?
     //var to store later array of products images
    var productsImagesArray: [UIImage] = []
    
    //    var productsImage: [UIImage] = [ UIImage(named:"daisa")!,
    //                                     UIImage(named:"biscate")!,
    //                                     UIImage(named:"canes")!,
    //                                     UIImage(named:"special")!,
    //                                     UIImage(named:"pasta")!,
    //                                     UIImage(named:"tamal")!]
    
    ////
    
override func viewWillAppear(_ animated: Bool) {
    tabBarController!.navigationItem.rightBarButtonItem!.isEnabled = true
    tabBarController!.navigationItem.rightBarButtonItem!.title = "לסל תרומות"
    
        tabBarController!.navigationItem.backBarButtonItem?.title = "חזור"
//        tabBarController!.title = "תרומות"
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
    
    //// dont delete!!!! ////
//    func downloadImage(url : URL){
//
//        //create cell instance to change its imageView.image
//        collectionCell = ProductsCollectionViewCell()
//
//
//        //creating a dataTask
//        URLSession.shared.dataTask(with:url) { (data, response, error) in
//
//            //if there is any error
//            if let e = error {
//                //displaying the message
//                print("Error Occurred: \(e)")
//            } else {
//                //in case of now error, checking wheather the response is nil or not
//                if (response as? HTTPURLResponse) != nil {
//
//                    //checking if the response contains an image
//                    if let imageData = data {
//
//                        //displaying the image
//                        DispatchQueue.main.async {
//                            self.productsImage = UIImage(data: imageData)
//                        }
//                    } else {
//                        print("Image file is currupted")
//                    }
//                } else {
//                    print("No response from server")
//                }
//            }
//            }.resume()
//    }
    ////
    
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
            var index = 0
            //unwrap - make sure ther is data in the array
            if let typs = types{
                //get data from server
                for type in typs{
                    //each loop add one product name
                    self.productsNamesArray.append(type[0])
                    //each loop add one product url to get image from it
                    //self.images_URLs.append(type[1])
                    
                    //each loop add one product image
                    do {
                        if let url = URL(string: type[1]){
                            let data = try Data(contentsOf: url)
                            if let uiImage = UIImage(data: data){
                                self.productsImagesArray.append(uiImage)
                            }
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                
                    index += 1
                }
                self.productsCollectionView.reloadData()
            }
//            print(self.productsArray)
//            print(self.imageUrl)
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
        cell.ProductImageView.image = productsImagesArray[indexPath.item]
        
        return  cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
        let productsList = storyboard!.instantiateViewController(withIdentifier: "productsList") as! ProductsListController
        
        //save the title of the product
        productName = productsNamesArray[indexPath.row]
        //save the image of the product
        productImage = productsImagesArray[indexPath.row]

        
        //move the title to the next page so it can be used as page title
        productsList.setTitle(title: productName!)
        //productsList.setImage(image: productImage!)
        show(productsList, sender: self)
    }
    ////

}
