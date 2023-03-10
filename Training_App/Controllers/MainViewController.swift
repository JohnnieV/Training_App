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
    
    private lazy var addWorkoutButton: UIButton = {
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
    
    private let workoutTodayLabel: UILabel = {
        let label = UILabel()
        label.text = "Workout today"
        label.textColor = .specialLightBrown
        label.font = .robotoMedium14()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        tableView.bounces = false // убираем оттяжку таблицы вниз
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        return tableView
        
    }()
    
    private let noWorkoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noWorkout")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = false // прячем изображение
        return imageView
    }()
    
    // создаем экземпляр класса
    private let calendarView = CalendarView()
    private let weatherView = WeatheView()
    
    private let idWorkoutTableViewCell = "idWorkoutTableViewCell"
    
    
    // перерисовка лэйаута(метод) !!! РАЗОБРАТЬСЯ В НЕМ
    override func viewDidLayoutSubviews() {
        // именно для создания круга из квадрата скругление происходит делением ширины на 2(вне зависимости от возможного изменения ширины в будущем будет работать
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setConstraints()
        setDelegate()
        tableView.register(WorkoutTableViewCell.self, forCellReuseIdentifier: idWorkoutTableViewCell) // регистрируем ячейку таблицы
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
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
        view.addSubview(workoutTodayLabel)
        view.addSubview(tableView)
        view.addSubview(noWorkoutImageView)
        
    }
    
    @objc func addWorkoutButtonTapped() {
        let newWorkoutViewController = NewWorkoutViewController()
        
        newWorkoutViewController.modalPresentationStyle = .fullScreen // открывается в полный экран, а не как модальное окно по умолчанию
        newWorkoutViewController.modalTransitionStyle = .flipHorizontal // горизонтальный переворот вьюхи при появлении
        present(newWorkoutViewController, animated: true) // переход ко второму вью контроллеру
        
    }


}

//MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10 // кол-во строк в таблице
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //создаем переиспользуемую ячейку
        let cell = tableView.dequeueReusableCell(withIdentifier: idWorkoutTableViewCell, for: indexPath) as! WorkoutTableViewCell
        return cell
    }
}

//MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100 // высота ячейки
    }
}

//MARK: - Set Constraints

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
        
        NSLayoutConstraint.activate([
            workoutTodayLabel.topAnchor.constraint(equalTo: addWorkoutButton.bottomAnchor, constant: 10),
            workoutTodayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            noWorkoutImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            noWorkoutImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            noWorkoutImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1), // высота картинки = ширина вьюхи * 1
            noWorkoutImageView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor, constant: 0)
        ])
    }
}

