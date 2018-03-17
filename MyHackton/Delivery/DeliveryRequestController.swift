import UIKit
import MapKit
import CoreLocation

class DeliveryRequestController: UIViewController, UITableViewDataSource ,UITableViewDelegate, CLLocationManagerDelegate {
    
    var RequestsList : [Request] = []
    var donator : Request!
    //var addressName : String!
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "wallpaper.jpg")!)
        self.table.backgroundColor = UIColor.clear
        
        tabBarController?.navigationItem.title = tabBarItem.title
        
        let b = UIBarButtonItem(title: "התנתק", style: .plain, target: self, action: #selector(backcheck) )
        
        self.navigationItem.hidesBackButton = true
        tabBarController?.navigationItem.leftBarButtonItem = b
        
        let prefs = UserDefaults.standard
        if let token = prefs.string(forKey: "token"){
            RequestsList.removeAll()
            ServerConnections.getDoubleArrayAsync("/myrequests", [token], handler: {requests in
                if let reqs = requests{
                    for request in reqs{
                        self.RequestsList.append(Request(id: request[0], fullName: request[1], address: request[2], phoneNumber: request[3], notice: request[4], status: request[5], date: request[6]))
                    }
                    self.table.reloadData()
                }
            })
        } else {
            //Move back to the main page
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBOutlet weak var table: UITableView!
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "חזור", style: .plain, target: nil, action: nil)
        
        //Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        //For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    var currentLocation: CLLocationCoordinate2D!
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {
            return
        }
        if let curLoc = currentLocation{
            if curLoc.latitude != locValue.latitude && curLoc.longitude != locValue.longitude {
                currentLocation = locValue
                table.reloadData()
            }
        } else {
            currentLocation = locValue
            table.reloadData()
        }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    @objc func backcheck(){
        //let main = storyboard!.instantiateViewController(withIdentifier: "main")
        let alert =  UIAlertController(title:"יציאה מהמערכת", message: "האם אתה בטוח שברצונך להתנתק מהמערכת?", preferredStyle: .alert)
        
        func okHandler(alert: UIAlertAction!){
            navigationController?.popToRootViewController(animated: true)
            let prefs = UserDefaults.standard
            prefs.removeObject(forKey: "token")
        }
        alert.addAction(UIAlertAction(title: "ביטול", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "אישור", style: .default, handler: okHandler))
        let prefs = UserDefaults.standard
        prefs.removeObject(forKey: "token")
        
        present(alert, animated: true, completion: nil)
    }
    
    //table view methods//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RequestsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requests_list_ofDelivery") as! DeliveryRequestCell
        if(RequestsList.count > 0){
            cell.address.text = RequestsList[indexPath.row].getAddress()
            findDistanceBetweenPins(cell: cell)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let cell = tableView.cellForRow(at: indexPath) as! DeliveryRequestCell
        let next = storyboard?.instantiateViewController(withIdentifier: "statusPage") as! DonatorsStatusController
        
        if RequestsList.count > 0 {
            donator = RequestsList[indexPath.row]
            next.set(donator: donator,index: indexPath.row)
            show(next, sender: self)
            self.navigationItem.backBarButtonItem?.title = "חזור"
        }
    }
    ////
    
    func setDonatorObj(donator : Request){
        self.donator = donator
    }
    
    // find distance between to places
    func findDistanceBetweenPins(cell: DeliveryRequestCell){
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(cell.address.text!, completionHandler: { (placemarks, error) in
            if let pinLongitude = placemarks?.first?.location?.coordinate.longitude
            {
                if let pinLatitude = placemarks?.first?.location?.coordinate.latitude{
                    //My buddy's location
                    let pinLocation = CLLocation(latitude: pinLatitude, longitude: pinLongitude)
                    print(pinLocation)
                    if self.currentLocation != nil{
                        let myLoc = CLLocation(latitude: self.currentLocation.latitude, longitude: self.currentLocation.longitude )
                        let distance = myLoc.distance(from: pinLocation) / 1000
                        cell.km_label.text = String((round(100 * distance)/100)) + " ק״מ"
                        return
                    }
                }
            }
        })
    }

}
