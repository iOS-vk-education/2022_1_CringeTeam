//
//  OnBoardView.swift
//  SharePay
//
//  Created by Денис Холод on 27.03.2022.
//

import UIKit

class OnBoardView: UIView {
    
    //Настройка внешнего вида элементов
    //Кнопка
    let enterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "BlackColor")
        button.setTitle("Вход", for: .normal)
        button.layer.cornerRadius = 25
        button.tintColor = UIColor(named: "WhiteColor")
        button.titleLabel?.font = UIFont(name: "GTEestiProDisplay-Medium", size: 16)
        return button
    }()
    
    //Элипс
    let elipse: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = UIScreen.main.bounds.size.height / 2.2
        label.layer.backgroundColor = UIColor(named: "BlueColor")?.cgColor
        return label
    }()
    
    //Название
    let title = UILabel(text: "SharePay", color: "BlackColor", size: 48)
    
    //1 строка
    let firstLineLabel = UILabel(text: "дели", color: "BlueColor")
    
    //2 строка
    let secondLineLabel = UILabel(text: "счета", color: "MagentaColor")
    
    //3 строка
    let thirdLineLabel = UILabel(text: "плати", color: "BlueColor")
    
    //4 строка
    let forthLineLabel = UILabel(text: "долги", color: "MagentaColor")
    
    //Нижний красный круг
    let bottomRedCircle: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 46
        label.layer.backgroundColor = UIColor(named: "MagentaColor")?.cgColor
        return label
    }()
        
    //Нижний синий круг
    let bottomBlueCircle: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 35
        label.layer.backgroundColor = UIColor(named: "BlueColorTransparent")?.cgColor
        return label
    }()
    
    //Верхний синий круг
    let topBlueCircle: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 55
        label.layer.backgroundColor = UIColor(named: "BlueColorTransparent20")?.cgColor
        return label
    }()
    
    //Логотип
    let logoLabel: UILabel = {
        let label = UILabel()
        label.layer.borderColor = UIColor(named: "WhiteColor")?.cgColor
        label.layer.borderWidth = 3
        label.layer.cornerRadius = 15
        
        //Создание градиента через extension
       // label.layer.insertSublayer(label.applyGradient(), at: 0)
        
        //Создание градиента обычным путем
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: 29, height: 29)
        layer.cornerRadius = 20
        layer.colors = [UIColor(named: "BlueColor")?.cgColor as Any, UIColor(named: "MagentaColor")?.cgColor as Any]
        layer.locations = [0.5, 0.5]
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))

        label.layer.insertSublayer(layer, at: 0)
        return label
    }()
    
    init() {
        super.init(frame: CGRect())
        backgroundColor = UIColor(named: "WhiteColor")
        setConstraints()
        
    }
    
    //Настройка расположения на экране
    func setConstraints() {
       
        //Добавляем сабвью
        let fourLabels = UIStackView(arrangedSubviews: [firstLineLabel,
                                                        secondLineLabel,
                                                        thirdLineLabel,
                                                        forthLineLabel])
        fourLabels.axis = .vertical
      
        [enterButton,
        elipse,
        title,
        fourLabels,
        bottomRedCircle,
        bottomBlueCircle,
        topBlueCircle,
        logoLabel].forEach {
            addSubview($0)
        }
        
        //Отключаем маску автомасштабирования
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        elipse.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        fourLabels.translatesAutoresizingMaskIntoConstraints = false
        bottomRedCircle.translatesAutoresizingMaskIntoConstraints = false
        bottomBlueCircle.translatesAutoresizingMaskIntoConstraints = false
        topBlueCircle.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //Настраиваем констреинты
        
        //Кнопка
        NSLayoutConstraint.activate([enterButton.centerXAnchor.constraint(equalTo:                                       centerXAnchor),
                                     enterButton.heightAnchor.constraint(equalToConstant: 52*(UIScreen.main.bounds.height/812)),
                                     enterButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26*(UIScreen.main.bounds.width/375)),
                                     enterButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -28*(UIScreen.main.bounds.height/812))])
        
        //Элипс
        NSLayoutConstraint.activate([elipse.widthAnchor.constraint(equalToConstant: 500),
                                     elipse.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     elipse.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -340),
                                     elipse.topAnchor.constraint(equalTo: topAnchor, constant: 32)])
        
        //Название
        NSLayoutConstraint.activate([title.topAnchor.constraint(equalTo: topAnchor,                                      constant: 56),
                                     title.centerXAnchor.constraint(equalTo: centerXAnchor)])
        
        //Стэк из 4 слов
        NSLayoutConstraint.activate([fourLabels.topAnchor.constraint(equalTo: topAnchor,                                 constant: 170),
                                     fourLabels.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)])
        
        //Нижний красный круг
        NSLayoutConstraint.activate([bottomRedCircle.bottomAnchor.constraint(equalTo:                                    enterButton.topAnchor, constant: -100),
                                     bottomRedCircle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                                     bottomRedCircle.widthAnchor.constraint(equalToConstant: 92),
                                     bottomRedCircle.heightAnchor.constraint(equalToConstant: 92)])
      
        
        //Нижний синий круг
        NSLayoutConstraint.activate([bottomBlueCircle.bottomAnchor.constraint(equalTo:                                   enterButton.topAnchor, constant: -80),
                                     bottomBlueCircle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 15),
                                     bottomBlueCircle.widthAnchor.constraint(equalToConstant: 70),
                                     bottomBlueCircle.heightAnchor.constraint(equalToConstant: 70)])
        
        //Верхний синий круг
        NSLayoutConstraint.activate([topBlueCircle.trailingAnchor.constraint(equalTo:                                    trailingAnchor, constant: 30),
                                     topBlueCircle.topAnchor.constraint(equalTo: topAnchor, constant: -30),
                                     topBlueCircle.widthAnchor.constraint(equalToConstant: 110),
                                     topBlueCircle.heightAnchor.constraint(equalToConstant: 110)])
        
        //Логотип
        NSLayoutConstraint.activate([logoLabel.widthAnchor.constraint(equalToConstant: 30),
                                     logoLabel.heightAnchor.constraint(equalToConstant: 30),
                                     logoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -55),
                                     logoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
