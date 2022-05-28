//
//  OnBoardView.swift
//  SharePay
//
//  Created by Денис Холод on 27.03.2022.
//

import UIKit

class OnBoardView: UIViewController {
    
    //Настройка внешнего вида элементов
    //Кнопка
    let enterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Label")
        button.setTitle("OnBoardViewController.Label.Enter".localized(), for: .normal)
        button.layer.cornerRadius = 25
        button.tintColor = UIColor(named: "Fill")
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
    let titleMain = UILabel(text: "SharePay", color: "Label", size: 48)
    
    //1 строка
    let firstLineLabel = UILabel(text: "OnBoardViewController.Label.Text1".localized(), color: "BlueColor")
    
    //2 строка
    let secondLineLabel = UILabel(text: "OnBoardViewController.Label.Text2".localized(), color: "MagentaColor")
    
    //3 строка
    let thirdLineLabel = UILabel(text: "OnBoardViewController.Label.Text3".localized(), color: "BlueColor")
    
    //4 строка
    let forthLineLabel = UILabel(text: "OnBoardViewController.Label.Text4".localized(), color: "MagentaColor")
    
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
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "SecondaryFill")
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
        titleMain,
        fourLabels,
        bottomRedCircle,
        bottomBlueCircle,
        topBlueCircle,
        logoLabel].forEach {
            view.addSubview($0)
        }
        
        //Отключаем маску автомасштабирования
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        elipse.translatesAutoresizingMaskIntoConstraints = false
        titleMain.translatesAutoresizingMaskIntoConstraints = false
        fourLabels.translatesAutoresizingMaskIntoConstraints = false
        bottomRedCircle.translatesAutoresizingMaskIntoConstraints = false
        bottomBlueCircle.translatesAutoresizingMaskIntoConstraints = false
        topBlueCircle.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //Настраиваем констреинты
        
        //Кнопка
        NSLayoutConstraint.activate([enterButton.centerXAnchor.constraint(equalTo:                                       view.centerXAnchor),
                                     enterButton.heightAnchor.constraint(equalToConstant: 52*(UIScreen.main.bounds.height/812)),
                                     enterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26*(UIScreen.main.bounds.width/375)),
                                     enterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -28*(UIScreen.main.bounds.height/812))])
        
        //Элипс
        NSLayoutConstraint.activate([elipse.widthAnchor.constraint(equalToConstant: 500),
                                     elipse.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     elipse.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -340),
                                     elipse.topAnchor.constraint(equalTo: view.topAnchor, constant: 32)])
        
        //Название
        NSLayoutConstraint.activate([titleMain.topAnchor.constraint(equalTo: view.topAnchor,                                      constant: 56),
                                     titleMain.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        //Стэк из 4 слов
        NSLayoutConstraint.activate([fourLabels.topAnchor.constraint(equalTo: view.topAnchor,                                 constant: 170),
                                     fourLabels.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)])
        
        //Нижний красный круг
        NSLayoutConstraint.activate([bottomRedCircle.bottomAnchor.constraint(equalTo:                                    enterButton.topAnchor, constant: -100),
                                     bottomRedCircle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
                                     bottomRedCircle.widthAnchor.constraint(equalToConstant: 92),
                                     bottomRedCircle.heightAnchor.constraint(equalToConstant: 92)])
      
        
        //Нижний синий круг
        NSLayoutConstraint.activate([bottomBlueCircle.bottomAnchor.constraint(equalTo:                                   enterButton.topAnchor, constant: -80),
                                     bottomBlueCircle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 15),
                                     bottomBlueCircle.widthAnchor.constraint(equalToConstant: 70),
                                     bottomBlueCircle.heightAnchor.constraint(equalToConstant: 70)])
        
        //Верхний синий круг
        NSLayoutConstraint.activate([topBlueCircle.trailingAnchor.constraint(equalTo:                                    view.trailingAnchor, constant: 30),
                                     topBlueCircle.topAnchor.constraint(equalTo: view.topAnchor, constant: -30),
                                     topBlueCircle.widthAnchor.constraint(equalToConstant: 110),
                                     topBlueCircle.heightAnchor.constraint(equalToConstant: 110)])
        
        //Логотип
        NSLayoutConstraint.activate([logoLabel.widthAnchor.constraint(equalToConstant: 30),
                                     logoLabel.heightAnchor.constraint(equalToConstant: 30),
                                     logoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -55),
                                     logoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40)])
    }
    
}
