import UIKit
import MapKit
import CoreLocation

class MapAddressController: UIViewController , CLLocationManagerDelegate {

    @IBOutlet weak var MyMap: MKMapView!
    var locationManager = CLLocationManager()
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = tabBarItem.title
        
        let b = UIBarButtonItem(title: "התנתק", style: .plain, target: self, action: #selector(backcheck))
        
        tabBarController?.navigationItem.leftBarButtonItem = b
        self.navigationItem.hidesBackButton = true
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        MyMap.mapType = .standard // regular map
        addPlaceToMap(place_name: "התחיה 10 חולון")
        
    }
    
    func addPlaceToMap(place_name : String){
        let addressTry = place_name
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(addressTry, completionHandler: { (placemarks, error) in
            let longitude = placemarks?.first?.location?.coordinate.longitude
            let latitude = placemarks?.first?.location?.coordinate.latitude
      
            UIApplication.shared.isIdleTimerDisabled = true
            
            self.addMyMarkers(name: place_name, PinLatitude: latitude!, PinLongitude: longitude!)
            
        })
    }
    
    func addMyMarkers(name:String, PinLatitude:Double, PinLongitude:Double ){
        let pin = MKPointAnnotation()
        pin.title = "\(name)"
        pin.coordinate = CLLocationCoordinate2D(latitude: PinLatitude, longitude: PinLongitude)
        
        MyMap.addAnnotation(pin) // add to map
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        MyMap.setRegion(region, animated: true)
        MyMap.showsUserLocation = true
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
