import UIKit
import MapKit

class MapAddressController: UIViewController , MKMapViewDelegate {

    @IBOutlet weak var MyMap: MKMapView!
    var locationManager: CLLocationManager!
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = tabBarItem.title
        
        let b = UIBarButtonItem(title: "התנתק", style: .plain, target: self, action: #selector(backcheck) )
        
        tabBarController?.navigationItem.leftBarButtonItem = b
        self.navigationItem.hidesBackButton = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        locationManager =  CLLocationManager()  //initialize location manager
        locationManager.requestAlwaysAuthorization()  //prompt user current location
        MyMap.delegate = self
        MyMap.showsUserLocation = true // showing user current location
        MyMap.mapType = .standard // regular map 
        
        
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let newPlace = userLocation.coordinate
        MyMap.setRegion(MKCoordinateRegionMakeWithDistance(newPlace, 8000, 8000), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addMyMarkers(name:String, PinLatitude:Double, PinLongitude:Double ){
        let pin = MKPointAnnotation()
        pin.title = "\(name)"
        pin.coordinate = CLLocationCoordinate2D(latitude: PinLatitude, longitude: PinLongitude)
        MyMap.addAnnotation(pin) // add to map
    }
    
    //logout from the system
    @objc func backcheck(){
        //let main = storyboard!.instantiateViewController(withIdentifier: "main")
        let alert =  UIAlertController(title:"יציאה מהמערכת", message: "האם אתה בטוח שברצונך להתנתק מהמערכת?", preferredStyle: .alert)
        
        func okHandler(alert: UIAlertAction!){
            navigationController?.popToRootViewController(animated: true)
            
        }
        alert.addAction(UIAlertAction(title: "ביטול", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "אישור", style: .default, handler: okHandler))
        
        present(alert, animated: true, completion: nil)
        
        
    }

    

}
