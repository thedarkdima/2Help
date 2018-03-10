import UIKit
import AVFoundation
import AudioToolbox

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureDevice:AVCaptureDevice?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var captureSession:AVCaptureSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //create back button
        navigationItem.backBarButtonItem?.isEnabled = true
        navigationItem.backBarButtonItem?.title = "חזור"
        
        view.backgroundColor = .white
        
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
                codeLabel.text = "אין מצלמה במכשיר זה"//not showing...
                print("Error Device Input")
            }
            
        }
        
        //add label that will appear in case there is no outputs - barcodes
        view.addSubview(codeLabel)
        //set the location of the code label
        codeLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        codeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        codeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        codeLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
    }
    
    //customize code label
        let codeLabel:UILabel = {
        let codeLbl = UILabel()
        codeLbl.backgroundColor = .white
        codeLbl.translatesAutoresizingMaskIntoConstraints = false
        return codeLbl
    }()
    
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
            codeLabel.text = "לא נמצא ברקוד"
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
        
    }
    ////
    
    // show basket page with the barcode's related product
    func moveToDonationBasketController(scannedCode: String) {
        let basketViewController = storyboard!.instantiateViewController(withIdentifier: "basket") as! DonationsBasketController
        //pass the codeNumber to the basketPage
        basketViewController.scannedCode = scannedCode
        
        present(basketViewController, animated: true, completion: nil)
    }
}
