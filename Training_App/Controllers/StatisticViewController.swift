//
//  StatisticViewController.swift
//  Training_App
//
//  Created by Владимир Смирнов on 05.02.2023.
//

import UIKit

class StatisticViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var button2: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(test), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        
        view.addSubview(scrollView)
        scrollView.addSubview(button)
        scrollView.addSubview(button2)
        
        setConstraints()
    }
    
    @objc private func test() {
        print("tap")
    }
}

extension StatisticViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            button.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 60),
            button.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            button2.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 1000),
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button2.heightAnchor.constraint(equalToConstant: 60),
            button2.widthAnchor.constraint(equalToConstant: 150),
            button2.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
}

