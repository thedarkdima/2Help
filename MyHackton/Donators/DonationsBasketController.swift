import UIKit

class DonationsBasketController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var scannedCode = ""
    var backButton : UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "סל תרומות"
        print(scannedCode)
    }
    
    //move to scannerViewController to scan barcodes
    @IBAction func scanBarcode(_ sender: UIButton) {
        let scanPage = storyboard!.instantiateViewController(withIdentifier: "scanner") as! ScannerViewController
        
        present(scanPage, animated: true, completion: nil)
    }
    
    //table view functions//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "products_cell")!
        return cell
    }
    ////

    func showAlert(){
    let alert = UIAlertController(title: "שקר כלשהו", message: "haha", preferredStyle: .alert)
    let cancel = UIAlertAction(title: "haha", style: .cancel, handler: nil)
    alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
  

}
