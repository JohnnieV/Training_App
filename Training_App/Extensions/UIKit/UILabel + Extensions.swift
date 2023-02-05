//
//  UILabel + Extensions.swift
//  Training_App
//
//  Created by Владимир Смирнов on 05.02.2023.
//

import UIKit

extension UILabel {
    convenience init(text: String = "") { // вспомогательный инит
        self.init()
        
        self.text = text
        self.font = .robotoMedium14()
        self.textColor = .specialLightBrown
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
