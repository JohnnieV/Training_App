//
//  UIStackView + Extensions.swift
//  Training_App
//
//  Created by Владимир Смирнов on 14.01.2023.
//

import UIKit
//let stackView = UIStackView() // определяем стэкВью
//stackView.addArrangedSubview(YourView) // добавляем элемени в стэквью
//stackView.addArrangedSubview(YourView2) // добавляем 2й элемени в стэквью
//stackView.axis = .horizontal // указываем направление стэкВью
//stackView.spacing = 10 // устанавливаем расстояние между элементами
//stackView.translatesAutoresizingMaskIntoConstraints = false // говорим, что констрэйнты мы са ми пропишем

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
