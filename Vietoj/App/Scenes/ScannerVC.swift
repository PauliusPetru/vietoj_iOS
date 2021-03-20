import AVFoundation
import UIKit

final class ScannerVC: UIViewController {
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!

    @IBOutlet private weak var scannerView: UIView!
    
    private var scannerVM: ScannerVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCapture()
        scannerVM = ScannerVM()
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)

    }

    @objc
    private func willEnterForeground() {
        if previewLayer == nil {
            checkForCamera()
        }
        
        if captureSession?.isRunning == false {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
    }
    
    func onFound(code: String) {
        scannerVM?.fetchInfo(for: code, completion: { [weak self] in
            //TODO: pass data model ass sender
            self?.performSegue(withIdentifier: "ConfirmationVC", sender: nil)
        })
    }
    
    private func checkForCamera() {
        AVCaptureDevice.requestAccess(for: .video) { success in
          if success {
            DispatchQueue.main.async {
                self.setupCapture()
            }
          } else {
            let alert = UIAlertController(title: "Camera",
                                          message: "Camera access is absolutely necessary to use this app",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: { _ in
                                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true)
            }
          }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let confirmationVC = (segue.destination as? ConfirmationVC) {
            confirmationVC.onDissmis = { [weak self] in
                self?.captureSession.startRunning()
            }
            //TODO: replace placeholders
//            confirmationVC.dataModel = sender as? DataModel
        }
    }
}

extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            onFound(code: stringValue)
        }
    }
    
    func setupCapture() {
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        scannerView.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }
    
    private func failed() {
        let ac = UIAlertController(title: "Scanning not supported",
                                   message: "Your device does not support scanning a code from an item. Please use a device with a camera.",
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
