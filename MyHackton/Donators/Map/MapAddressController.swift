import UIKit
import MapKit
import CoreLocation

class MapAddressController: UIViewController , CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var MyMap: MKMapView!
    var locationManager = CLLocationManager()
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "בחר את המשלוחים שברצונך לקחת"
        
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
        //MyMap.showsUserLocation = true //maybe unnecessary
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
        let pin1 = MKPointAnnotation()
        pin1.title = "\(name)"
        pin1.coordinate = CLLocationCoordinate2D(latitude: PinLatitude, longitude: PinLongitude)
        
        
        let pin2 = MKPointAnnotation()
        pin2.title = "pini"
        pin2.coordinate = CLLocationCoordinate2D(latitude: 32.4, longitude: 34.9)
        
        MyMap.addAnnotation(pin1) // add pin1 to map
        MyMap.addAnnotation(pin2) // add pin2 to map
    }
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        pin.canShowCallout = true
        pin.leftCalloutAccessoryView = UIButton(type: .contactAdd)
        
        return pin
    }
    
    // button on annotation is pressed
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let currentAnnotation = view.annotation
        
        MyMap.removeAnnotation(currentAnnotation!)
        //navigationController?.pushViewController(displayPage, animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        MyMap.setRegion(region, animated: true)
        MyMap.userLocation.title = "המיקום שלי"
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
