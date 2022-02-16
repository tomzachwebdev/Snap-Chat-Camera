//
//  CustomRecordController.swift
//  SnapChat Camera
//
//  Created by 123456 on 12/28/21.
//

import Foundation
import UIKit

class CustomRecordButtonController:UIViewController{
    
    let recordButton = CustomRecordButton()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(recordButton)
        
        recordButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        recordButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        recordButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        recordButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        recordButton.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
        recordButton.addTarget(self, action: #selector(recordButtonTouchDown), for: .touchDown)
        
        
        let longpress = UILongPressGestureRecognizer(target: self, action:#selector(longPressActivated))
        recordButton.addGestureRecognizer(longpress)
    }
    
    @objc func longPressActivated(){
        print("long press activated")
//        recordButton.touchDown(sender: recordButton)
//        recordButton.touchUpInside(sender: recordButton)
        
    }
    
    @objc func recordButtonTapped(){
//        recordButton.touchDown(sender: recordButton)
     
//        recordButton.touchUpInside(sender: self.recordButton)
        print("record button tapped")
    }
    
    @objc func recordButtonTouchDown(){
//        recordButton.touchUpInside(sender: self.recordButton)
//        recordButton.touchDown(sender: self.recordButton)
        print("record button touch down")
    }
    
}
