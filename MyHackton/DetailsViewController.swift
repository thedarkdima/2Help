import UIKit

class DetailsViewController: UIViewController {
    
    ////// example for download image from url and put in image view  ////////
    
    
    @IBOutlet var imageView: UIImageView!
    
    //URL containing the image
    let image_url = URL(string: "https://i.ytimg.com/vi/jcTxbd1R3gQ/maxresdefault.jpg")
    
    func downloadImage(url : URL){
        //creating a dataTask
        URLSession.shared.dataTask(with:url) { (data, response, error) in
            
            //if there is any error
            if let e = error {
                //displaying the message
                print("Error Occurred: \(e)")
            } else {
                //in case of now error, checking wheather the response is nil or not
                if (response as? HTTPURLResponse) != nil {
                    
                    //checking if the response contains an image
                    if let imageData = data {
                        
                        //displaying the image
                        DispatchQueue.main.async {
                            self.imageView.image = UIImage(data: imageData)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadImage(url: image_url!)
        
    }
}



/*

import UIKit

class DonatorController: UIViewController ,UICollectionViewDelegate , UICollectionViewDataSource {
    
    @IBOutlet var productsCollectionView: UICollectionView!
    
    
    
    //var totalCount: Int = 0
    // var products: [String] = []
    var productName : String?
    
    //collection view variables//
    
    var images_URLs : [String] = []
    
    var text : String = ""
    var productsNamesArray : [String] = []
    //    var productsImage: [UIImage] = [ UIImage(named:"daisa")!,
    //                                     UIImage(named:"biscate")!,
    //                                     UIImage(named:"canes")!,
    //                                     UIImage(named:"special")!,
    //                                     UIImage(named:"pasta")!,
    //                                     UIImage(named:"tamal")!]
    var productsImage: [UIImage] = []
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
                    self.images_URLs.append(type[1])
                    //each loop add one product image
                    
                    //                    self.productsImage.append(UIImage(data: try! Data(contentsOf: URL(string: self.images_URLs[index])!))!)
                    ////
                    URLSession.shared.dataTask(with: URL(string: self.images_URLs[index])! ) { (data, response, error) in
                        
                        //if there is any error
                        if let e = error {
                            //displaying the message
                            print("Error Occurred: \(e)")
                        } else {
                            //in case of no error, checking whether the response is nil or not
                            if (response as? HTTPURLResponse) != nil {
                                
                                //checking if the response contains an image
                                if let imageData = data {
                                    
                                    //displaying the image
                                    DispatchQueue.main.async {
                                        //self.imageView.image = UIImage(data: imageData)
                                        self.productsImage.append(UIImage(data: imageData)!)
                                        index += 1
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
        cell.ProductImageView.image = productsImage[indexPath.item]
        
        return  cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
        let productsList = storyboard!.instantiateViewController(withIdentifier: "productsList") as! ProductsListController
        
        productName = productsNamesArray[indexPath.row]
        productsList.setTitle(title: productName!)
        
        show(productsList, sender: self)
    }
    ////
    
}
*/
