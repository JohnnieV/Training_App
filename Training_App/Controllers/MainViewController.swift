//
//  ViewController.swift
//  Training_App
//
//  Created by Владимир Смирнов on 14.01.2023.
//

import UIKit

class MainViewController: UIViewController {
    /* ШАБЛОН ЭЛЕМЕНТА
    в классе для добавления элементов(вьюшек будем использовать стандартную конструкцю
     let view = UIView() в зависимости от нужной вьюхи будет меняться
     сами свойства объекта(цвет, радиус и тд
     view.translatesAutoresizingMaskIntoConstraints = false - сами расставим констрэйнты
     return view
     */
    
    // сама конструкция начало
    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView() // внутреннее название вьюхи
        
        imageView.backgroundColor = #colorLiteral(red: 0.8044065833, green: 0.8044064641, blue: 0.8044064641, alpha: 1) // фон вьюхи(элемента)
        imageView.layer.borderWidth = 5 // рамка в 5 поинтов
        imageView.layer.borderColor = UIColor.white.cgColor // цвет рамки
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
//    private let calendarView: UIView = {
//        let view = UIView()
//
//        view.backgroundColor = .specialGreen
//        view.layer.cornerRadius = 10
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Vladimir Smirnov"
        label.textColor = .specialGray
        label.font = .robotoMedium24() // фонт из экстэншнов
        label.adjustsFontSizeToFitWidth = true // при большом тексе фонт будет уменьшаться чтобы влезть в лэйбл
        label.minimumScaleFactor = 0.5 // ограничиваем шрифт в зависимости от установленного размера(насколько может уменьшиться, если очень много букв. в данном случае шрифт 24 и может уменьшиться до 12, чтоб ограничить ситабельность лэбла
        //label.numberOfLines = 2 // перенос строки(2 строки) если 0 - бесконечное кол-во строк вниз
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addWorkoutButton: UIButton = {
        let button = UIButton(type: .system) // тип кнопки системный
        
        button.backgroundColor = .specialYellow
        button.layer.cornerRadius = 10
        button.setTitle("Add workout", for: .normal) // заголовок(имя) кнопки
        button.titleLabel?.font = .robotoMedium12()
        button.tintColor = .specialDarkGreen // цвет плюса кнопки переопределяем, потому что в системном типе цвет синий UIButton(type: .system)
        //располоение картинки от краев(доьбавляем как будто отступы)
        button.imageEdgeInsets = UIEdgeInsets(top: 0,
                                              left: 20,
                                              bottom: 15,
                                              right: 0)
        // расположение тайтла от краев
        button.titleEdgeInsets = UIEdgeInsets(top: 50,
                                              left: -40,
                                              bottom: 0,
                                              right: 0)
        button.setImage(UIImage(named: "addWorkout"), for: .normal) // картинка у кнопки по имени файла addWorkout
        // ставим таргет кнопке сэлф - потому что нажимаем на себя, селектор - метод addWorkoutButtonTapped, для обычного нажатия на кнопку
        button.addTarget(self, action: #selector(addWorkoutButtonTapped), for: .touchUpInside)
        button.addShadowOnView() // добавляем тень из экстэншна
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // создаем экземпляр класса
    private let calendarView = CalendarView()
    private let weatherView = WeatheView()
    
    
    // перерисовка лэйаута(метод) !!! РАЗОБРАТЬСЯ В НЕМ
    override func viewDidLayoutSubviews() {
        // именно для создания круга из квадрата скругление происходит делением ширины на 2(вне зависимости от возможного изменения ширины в будущем будет работать
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setConstraints()
       
    }
    // метод для настроек всех вьюх
    private func setUpViews() {
        view.backgroundColor = .specialBackground // цвет(название) из расширения цветов uicolor + extensions
        
        // порядок вьюх ниже важен(что идет первым, что над чем лежит)
        view.addSubview(calendarView)
        view.addSubview(userPhotoImageView) // добавляем нашу вьюху(название в скобках) в основную вьюху
        view.addSubview(userNameLabel)
        view.addSubview(addWorkoutButton)
        view.addSubview(weatherView)
        
    }
    
    @objc func addWorkoutButtonTapped() {
        print("addWorkoutButtonTapped")
    }


}

extension MainViewController {
    private func setConstraints() { // приват метод потому что не хотим чтоб вызывался извне
        // пропишем все констрэйнты которые надо активировать
        // вемсто того чтобы писать в каждом .isActive
        NSLayoutConstraint.activate([
            // от сэйф эриа отступ сверху ноль
            userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            // слева от основной вьюхи отступ 10
            userPhotoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            // высота
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            // ширина
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 100)
        
        ])
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            // !!!лэйбл имеет отступ слева от правой(трэйлинг) части юзер фото!!!
            userNameLabel.leadingAnchor.constraint(equalTo: userPhotoImageView.trailingAnchor, constant: 5),
            userNameLabel.bottomAnchor.constraint(equalTo: calendarView.topAnchor, constant: -10),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            addWorkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addWorkoutButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 5),
            addWorkoutButton.heightAnchor.constraint(equalToConstant: 80),
            addWorkoutButton.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            weatherView.leadingAnchor.constraint(equalTo: addWorkoutButton.trailingAnchor, constant: 10),
            weatherView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 5),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            weatherView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}

