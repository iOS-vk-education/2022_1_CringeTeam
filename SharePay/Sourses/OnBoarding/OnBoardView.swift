//
//  OnBoardView.swift
//  SharePay
//
//  Created by Денис Холод on 27.03.2022.
//

import UIKit

class OnBoardView: UIView {
    
    let enterButton = UIButton()
    let elipse = UILabel()
    let title = UILabel()
    let firstLineLabel = UILabel()
    let secondLineLabel = UILabel()
    let thirdLineLabel = UILabel()
    let forthLineLabel = UILabel()
    
    init() {
        super.init(frame: CGRect())
        backgroundColor = UIColor(named: "WhiteColor")
        setViews()
        setConstraints()
        
    }
    
    //Настройка внешнего вида элементов
    func setViews() {
        //Кнопка
        enterButton.backgroundColor = UIColor(named: "BlackColor")
        enterButton.setTitle("Вход", for: .normal)
        enterButton.layer.cornerRadius = 25
        enterButton.tintColor = UIColor(named: "WhiteColor")
        //Элипс
        elipse.layer.cornerRadius = 365
        elipse.layer.backgroundColor = UIColor(named: "BlueColor")?.cgColor
        //Название
        title.text = "SharePay"
        title.textColor = UIColor(named: "BlackColor")
        title.font = UIFont(name: "GTEestiProDisplay-UltraBold", size: 48)
        
        //1 строка
        firstLineLabel.text = "дели"
        firstLineLabel.textColor = UIColor(named: "BlueColor")
        firstLineLabel.font = UIFont(name: "GTEestiProDisplay-UltraBold", size: 42)
        firstLineLabel.textAlignment = .right
        
        //2 строка
        secondLineLabel.text = "счета"
        secondLineLabel.textColor = UIColor(named: "RedColor")
        secondLineLabel.font = UIFont(name: "GTEestiProDisplay-UltraBold", size: 42)
        secondLineLabel.textAlignment = .right
        
        //3 строка
        thirdLineLabel.text = "плати"
        thirdLineLabel.textColor = UIColor(named: "BlueColor")
        thirdLineLabel.font = UIFont(name: "GTEestiProDisplay-UltraBold", size: 42)
        thirdLineLabel.textAlignment = .right
        
        //4 строка
        forthLineLabel.text = "долги"
        forthLineLabel.textColor = UIColor(named: "RedColor")
        forthLineLabel.font = UIFont(name: "GTEestiProDisplay-UltraBold", size: 42)
        forthLineLabel.textAlignment = .right
    }
    //Настройка расположения на экране
    func setConstraints() {
        //Добавляем сабвью
        addSubview(enterButton)
        addSubview(elipse)
        addSubview(title)
        
        let fourLabels = UIStackView(arrangedSubviews: [firstLineLabel,
                                                  secondLineLabel,
                                                  thirdLineLabel,
                                                  forthLineLabel])
        fourLabels.axis = .vertical
        addSubview(fourLabels)
        //Отключаем маску автомасштабирования
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        
        elipse.translatesAutoresizingMaskIntoConstraints = false
        
        title.translatesAutoresizingMaskIntoConstraints = false
        
        fourLabels.translatesAutoresizingMaskIntoConstraints = false
        
        //Настраиваем констреинты
        //Кнопка
        enterButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        enterButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        enterButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26).isActive = true
        enterButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -28).isActive = true
        //Элипс
        elipse.widthAnchor.constraint(equalToConstant: 500).isActive = true
        
        elipse.heightAnchor.constraint(equalToConstant: 740 ).isActive = true
        
        elipse.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        elipse.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -340).isActive = true
        
       // elipse.topAnchor.constraint(equalTo: topAnchor, constant: 32).isActive = true
       
        //Название
        title.topAnchor.constraint(equalTo: topAnchor, constant: 56).isActive = true
        title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        //Стэк из 4 слов
        fourLabels.topAnchor.constraint(equalTo: topAnchor, constant: 170).isActive = true
        fourLabels.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
