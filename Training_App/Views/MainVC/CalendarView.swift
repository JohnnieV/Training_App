//
//  CalendarView.swift
//  Training_App
//
//  Created by Владимир Смирнов on 14.01.2023.
//

import UIKit

class CalendarView: UIView {
    
    // создаем коллекшн вью
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .red
        return collectionView
    }()
    
    private let idCalendarCell = "idCalendarCell"
    
    override init(frame: CGRect) { // используем границы вью
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: idCalendarCell) // регистрируем ячейку
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .specialGreen
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
    }
    
    private func setDelegates() {
        collectionView.delegate = self // делегатом будем мы сами(CalendarView)
        collectionView.dataSource = self
        
    }   
}
//MARK: - UICollectionViewDataSource
extension CalendarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7 // кол-во дней в календаре = items = 7. по сути писаться должно return 7, но так как 1 строка можно опустить return
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // создаем переиспользуемую ячейку
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCalendarCell, for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    
    
}

//MARK: - UICollectionViewDelegate

extension CalendarView: UICollectionViewDelegate { // подписали на протокол делегата
    // метод отвечающий за событие при нажатии на ячейку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collectionviewtapped")
    }
}



//MARK: - SetConstraints

extension CalendarView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 5), // от собственных внутр краев отступ 5(поэтому просто topanchor
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 105),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
