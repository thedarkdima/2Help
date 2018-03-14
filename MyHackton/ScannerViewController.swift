import UIKit
import AVFoundation

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureDevice:AVCaptureDevice?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var captureSession:AVCaptureSession?
    var failed = false
    var isbacktoPreviousScreen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        
//        captureDevice = AVCaptureDevice.default(for: .video)
//
//        // Check if captureDevice returns a value and unwrap it - check if there is a camera
//        if let captureDevice = captureDevice {
//
//            do {
//                //unrwap the input - the machine check if there is an input device(now input = video input(camera))
//                let input = try AVCaptureDeviceInput(device: captureDevice)
//
//                //an object that holds the input(camera) and the output of it (like - start the input(ex: camera) and gets its output(ex: barcode)
//                captureSession = AVCaptureSession()
//                guard let captureSession = captureSession else { return }
//                //captureSession get the input
//                captureSession.addInput(input)
//                //
//                let captureMetadataOutput = AVCaptureMetadataOutput()
//                captureSession.addOutput(captureMetadataOutput)
//
//                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: .main)
//                captureMetadataOutput.metadataObjectTypes = [.code128, .qr, .ean13,  .ean8, .code39] //AVMetadataObject.ObjectType
//
//                //start capturing data - the camera start to shoot
//                captureSession.startRunning()
//                //edit the properties of the view - the user can see what the camera is shooting in it.
//                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//                videoPreviewLayer?.videoGravity = .resizeAspectFill
//                videoPreviewLayer?.frame = view.layer.bounds
//
//                view.layer.addSublayer(videoPreviewLayer!)
//
//            } catch {
//                failed = true
//                print("alert for setting")
//            }
//
//        }
   
    }    
    

    func settingAlert(){
        //// setting  alert
        let alert = UIAlertController(title: "הרשאה", message: "תן הרשאה למצלמה בכדי להשתמש בברקוד", preferredStyle: .alert)
        let settingAction = UIAlertAction(title: "הגדרות", style: .default) { (success) in
            if let settingUrl = URL(string: UIApplicationOpenSettingsURLString)  {
                if UIApplication.shared.canOpenURL(settingUrl){
                    UIApplication.shared.open(settingUrl , completionHandler: nil)
                }
            }
        }
        let cancel = UIAlertAction(title: "ביטול", style: .cancel, handler:{_ in
           self.navigationController?.popViewController(animated: true)
            
            
        })
        alert.addAction(cancel)
        alert.addAction(settingAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if failed{
        settingAlert()
    
        }
        
        captureDevice = AVCaptureDevice.default(for: .video)
        
        // Check if captureDevice returns a value and unwrap it - check if there is a camera
        if let captureDevice = captureDevice {
            
            do {
                //unrwap the input - the machine check if there is an input device(now input = video input(camera))
                let input = try AVCaptureDeviceInput(device: captureDevice)
                
                //an object that holds the input(camera) and the output of it (like - start the input(ex: camera) and gets its output(ex: barcode)
                captureSession = AVCaptureSession()
                guard let captureSession = captureSession else { return }
                //captureSession get the input
                captureSession.addInput(input)
                //
                let captureMetadataOutput = AVCaptureMetadataOutput()
                captureSession.addOutput(captureMetadataOutput)
                
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: .main)
                captureMetadataOutput.metadataObjectTypes = [.code128, .qr, .ean13,  .ean8, .code39] //AVMetadataObject.ObjectType
                
                //start capturing data - the camera start to shoot
                captureSession.startRunning()
                //edit the properties of the view - the user can see what the camera is shooting in it.
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer?.videoGravity = .resizeAspectFill
                videoPreviewLayer?.frame = view.layer.bounds
                
                view.layer.addSublayer(videoPreviewLayer!)
                
            } catch {
                failed = true
                print("alert for setting")
            }
            
        }
    }
    
    
//    let codeFrame:UIView = {
//        let codeFrame = UIView()
//        codeFrame.layer.borderColor = UIColor.green.cgColor
//        codeFrame.layer.borderWidth = 2
//        codeFrame.frame = CGRect.zero
//        codeFrame.translatesAutoresizingMaskIntoConstraints = false
//        return codeFrame
//    }()
    
    //get new metadata object - new barcodes//
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            //print("No Input Detected")
            //codeFrame.frame = CGRect.zero
            //if there was no barcode found - show label that infroms it
            
            
            
            return
        }
        //gets the barcode as the camera output
        let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        //unwrap the metadataObjcet(his stringValue) - the barcode number
        guard let stringCodeValue = metadataObject.stringValue else { return }
        
       // view.addSubview(codeFrame)
        
     // guard let barcodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObject) else { return }
        //codeFrame.frame = barcodeObject.bounds
        //codeLabel.text = stringCodeValue
        
        // vibrate the phone when barcdoe found
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        
        // Stop capturing and hence stop executing metadataOutput function over and over again
        captureSession?.stopRunning()
        
        // show the donationsBasketController and pass the barcode string value we just detected
        moveToDonationBasketController(scannedCode: stringCodeValue)
       // print(stringCodeValue)
        
    }
    ////
    
    // show basket page with the barcode's related product
    func moveToDonationBasketController(scannedCode: String) {
        
        //print(scannedCode)
        //pass the codeNumber to the basketPage 
        //basketViewController.scannedCode = scannedCode
        ServerConnections.getDoubleArrayAsync("/barcode", [scannedCode], handler: { product in
            if let pr = product{
                let prefs = UserDefaults.standard
                var basket = prefs.dictionary(forKey: "basket") as! [String: [String]]
                if let item = basket[pr[0][0]]{
                    basket.updateValue([String(Int(pr[0][0])! + Int(item[0])!), pr[0][4]], forKey: pr[0][0])
                } else {
                    basket.updateValue([pr[0][0], pr[0][4]], forKey: pr[0][0])
                }
                prefs.set(scannedCode, forKey: "barcode")
            }
            self.dismiss(animated: true, completion: nil)
        })
//        if(self.navigationController?.isMovingFromParentViewController)!{
        //let basketViewController = storyboard?.instantiateViewController(withIdentifier: "basket") as! DonationsBasketController
            //self.navigationController?.pushViewController(basketViewController, animated: true)
        
//        } else {
//            let toDonatorController = storyboard?.instantiateViewController(withIdentifier: "collection")
//            self.navigationController?.popToViewController(toDonatorController!, animated: true)
//
//        }
    }
    
    
}
