//
//  CustomRecordButton.swift
//  SnapChat Camera
//
//  Created by 123456 on 12/28/21.
//

import Foundation
import UIKit

@IBDesignable
class CustomRecordButton: UIButton {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayout(){
        self.frame.size = CGSize(width: 60, height: 60)
        self.layer.cornerRadius = 30
        self.layer.borderWidth = 6
        self.layer.borderColor = UIColor.red.cgColor
        self.backgroundColor = .white
    }
    
}
