import UIKit

class DonatorDirectionsController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //addresses example before server
    let DirectionsList = [
                                "tel aviv kikar hamedina"    ,
                                "haifa" ,
                                "חיפה"    ,
                                "חולון אלופי צה״ל 10",
                                "רמת גן שדרות התמרים 9",
                                "ראשון הרצל 5",
                                "פרדס חנה מורן 13",
"אור עקיבא משה שרת 8"
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController!.navigationItem.rightBarButtonItem!.isEnabled = false
        tabBarController!.navigationItem.rightBarButtonItem!.title = ""
        tabBarController!.title = "סניפים"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DirectionsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "address_cell") as! DonatorAddressCell
        cell.address_name.text = DirectionsList[indexPath.row]
        return cell
    }

    

}
