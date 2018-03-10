import UIKit

class MessengersListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var donatorsAddresses : [String] = []
    var messangersNames : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func toSuppliesPage(_ sender: UIButton) {
        let suppliesPage = storyboard!.instantiateViewController(withIdentifier: "supplies")
        present(suppliesPage, animated: true, completion: nil)
        
    }
    
    
    //table functions//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messanger")!
        return cell
    }
    ////
    
}
