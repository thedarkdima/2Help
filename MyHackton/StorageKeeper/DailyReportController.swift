import UIKit

class DailyReportController: UIViewController, UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.backgroundColor = UIColor.clear
        let cell = tableView.dequeueReusableCell(withIdentifier: "daily_report_cell")!
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "wallpaper.jpg")!)
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
 
  
}
