//
//  ViewController.swift
//  SnapChat Camera
//
//  Created by 123456 on 12/27/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //capture session
    var session:AVCaptureSession?
    //photo outlet
    //video output
    var output:AVCapturePhotoOutput = AVCapturePhotoOutput()
    
    var preview:AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer()
    //shutter button

    private let shutterButton:RecordButton = {
        let button = RecordButton(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
//        button.layer.cornerRadius = 100
//        button.layer.borderWidth = 3
//        button.layer.borderColor = UIColor.white.cgColor
//        button.backgroundColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
        view.layer.addSublayer(preview)
        view.addSubview(shutterButton)
        
        checkCameraPermissions()
        
        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        preview.frame = view.bounds
        shutterButton.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height - 200)
    }
    
    private func checkCameraPermissions(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .notDetermined:
            //request permission
            AVCaptureDevice.requestAccess(for: .video) { [weak self] permission in
                guard permission, let self = self else {return}
                DispatchQueue.main.async {
                    self.setUpCamera()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setUpCamera()
        @unknown default:
            break
        }
    }
    
    private func setUpCamera(){
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video){
            do{
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input){
                    session.addInput(input)
                }
                
                if session.canAddOutput(output){
                    session.addOutput(output)
                }
                
                
                preview.videoGravity = .resizeAspectFill
                preview.session = session
                
                session.stopRunning()
                self.session = session
            }
            catch{
                print()
            }
        }
    }
    
    @objc func didTapTakePhoto(){
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }

}

extension ViewController:AVCapturePhotoCaptureDelegate{
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else{
            return
        }
        
        session?.stopRunning()
        
        let image = UIImage(data: data)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.frame
        view.addSubview(imageView)
    }
}
