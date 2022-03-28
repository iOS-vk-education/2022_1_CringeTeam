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
    }
    //Настройка расположения на экране
    func setConstraints() {
    //Добавляем сабвью
        addSubview(enterButton)
        addSubview(elipse)
        addSubview(title)
    //Отключаем маску автомасштабирования
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        
        elipse.translatesAutoresizingMaskIntoConstraints = false
        
        title.translatesAutoresizingMaskIntoConstraints = false
        
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
