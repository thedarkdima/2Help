import UIKit

class DonatorController: UIViewController ,UICollectionViewDelegate , UICollectionViewDataSource {
    
    @IBOutlet var productsCollectionView: UICollectionView!
    @IBAction func phoneNumber(_ number: UIButton) {
        
        let numberToCall = (number.titleLabel?.text)!
        if let phoneURL = URL(string :"tel://" + numberToCall){
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        }
    
    }
    
    
    var totalCount: Int = 0
    var products: [String] = []
    var productName : String?
    
    //collection view variables//
    var imageUrl :[String] = []
    
    var text : String = ""
    var productsArray: [String] = []
    var productsImage: [UIImage] = [ UIImage(named:"daisa")!,
                                     UIImage(named:"biscate")!,
                                     UIImage(named:"canes")!,
                                     UIImage(named:"special")!,
                                     UIImage(named:"pasta")!,
                                     UIImage(named:"tamal")!]
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
    
    //server//
    func getProductsTypes(){
        ServerConnections.getDoubleArrayAsync("/itemstypes", [""], handler: {types in
            self.productsArray = []
            if let typs = types{
                for type in typs{
                    self.productsArray.append(type[0])
                    self.imageUrl.append(type[1])
                    
                }
                self.productsCollectionView.reloadData()
            }
            print(self.productsArray)
        })
    }
    ///
    
    //Products Collection View//
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product_cell", for: indexPath) as! ProductsCollectionViewCell
        cell.productLabel.text = productsArray[indexPath.item]
        cell.ProductImageView.image = productsImage[indexPath.item]
        
        return  cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
        let productsList = storyboard!.instantiateViewController(withIdentifier: "productsList") as! ProductsListController
        
        productName = productsArray[indexPath.row]
        productsList.setTitle(title: productName!)
        
    
        show(productsList, sender: self)
    }
    
    ////

}
