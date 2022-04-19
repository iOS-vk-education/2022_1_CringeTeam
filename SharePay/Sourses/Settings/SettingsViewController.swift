//
//  SettingsViewController.swift
//  SharePay
//
//  Created by User on 18.04.2022.
//

import UIKit

final class SettingsViewController: UIViewController {
    
///Подложка
    let allView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "WhiteColor")
        return view
    }()
    
///Заголовок
    let mainTitle = UILabel(text: "Настройки", color: "DarkBlueColor", size: 24)
 
///Язык интерфейса
    let langTitle = UILabel(text: "Язык интерфейса", color:"DarkBlueColor", size: 20, alignment: .left)
///Push уведомления
    let pushTitle = UILabel(text: "Push-уведомления", color: "DarkBlueColor", size: 20)
    
///Верхний View
    let topView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = UIScreen.main.bounds.size.width / 16
        view.layer.borderColor = UIColor(named: "DarkBlueColor")?.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    
///Нижний View
    let bottomView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = view.bounds.width / 2
        view.layer.borderColor = UIColor(named: "DarkBlueColor")?.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    
///Флаг русский
    let russianLogo = UILabel(text: "🇷🇺", color: "DarkBlueColor", size: 24)
    
    
///Флаг английский
    let englishLogo = UILabel(text: "🇺🇸", color: "DarkBlueColor", size: 24)
    
    
///Русский язык
    let russianTitle = UILabel(text: "Русский", color: "DarkBlueColor", size: 18, name: "GTEestiProDisplay-Regular")
    
    
///Английский язык
    let englishTitle = UILabel(text: "Английский", color: "DarkBlueColor", size: 18, name: "GTEestiProDisplay-Regular")
    
    
///Метка русский язык
    let russianTag = UILabel(text: "✔️", color: "DarkBlueColor", size: 20)
    
    
///Метка английский язык
    let englishTag = UILabel(text: "✔️", color: "WhiteColor", size: 20)
    
    
///Линия разделения языков
    let langSeparatedView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(named: "GreyColor")?.cgColor
        view.layer.borderWidth = 0.2
        return view
    }()
    
    
///Новый счет
    let newBillTitle = UILabel(text: "Новый счет", color: "DarkBlueColor", size: 18, name: "GTEestiProDisplay-Regular")
    
    
///Новая оплата
    let newPayTitle = UILabel(text: "Новая оплата", color: "DarkBlueColor", size: 18, name: "GTEestiProDisplay-Regular")
    
    
///Toggle счет
    let billSwitch: UISwitch = UISwitch()
    
    
///Toggle Оплата
    let paySwitch: UISwitch = UISwitch()
    
    
///Линия разделения push
    let pushSeparatedView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(named: "GreyColor")?.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    
///Версия приложения
    let versionTitle = UILabel(text: "Версия 1.0.0", color: "GreyColor", size: 12, name: "GTEestiProDisplay-Regular")
    
    
///Количество пользователей
    let usersTitle = UILabel(text: "Всего пользователей 700", color: "GreyColor", size: 12, name: "GTEestiProDisplay-Regular")
    
    
///Метка разработано
    let developTitle = UILabel(text: "Разработано ", color: "DarkBlueColor", size: 12, name: "GTEestiProDisplay-Regular")
    
    
///Название команды
    let teamTitle = UILabel(text: "CringeTeam", color: "DarkBlueColor", size: 12, name: "GTEestiProDisplay-UltraBold")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrangeConstraints()
        
    }
    
   ///Установка констрэйнток
    func arrangeConstraints() {
        
        view.addSubview(allView)
        allView.addSubview(mainTitle)
        
        allView.addSubview(langTitle)
        allView.addSubview(topView)
        topView.addSubview(russianLogo)
        topView.addSubview(russianTitle)
        topView.addSubview(russianTag)
        topView.addSubview(langSeparatedView)
        topView.addSubview(englishLogo)
        topView.addSubview(englishTitle)
        topView.addSubview(englishTag)
//        
//        allView.addSubview(pushTitle)
//        allView.addSubview(bottomView)
//        bottomView.addSubview(newBillTitle)
//        bottomView.addSubview(billSwitch)
//        bottomView.addSubview(pushSeparatedView)
//        bottomView.addSubview(newPayTitle)
//        bottomView.addSubview(paySwitch)
//        
//        allView.addSubview(versionTitle)
//        allView.addSubview(usersTitle)
//        allView.addSubview(developTitle)
//        allView.addSubview(teamTitle)
        
        [allView, mainTitle, langTitle, topView, russianLogo, russianTitle, russianTag, langSeparatedView, englishLogo, englishTitle, englishTag, pushTitle, bottomView, newBillTitle, billSwitch, pushSeparatedView, newPayTitle, paySwitch, versionTitle, usersTitle, developTitle, teamTitle].forEach {
$0.translatesAutoresizingMaskIntoConstraints = false
}
        
        let allViewConstraints: [NSLayoutConstraint] = [
            allView.topAnchor.constraint(equalTo: view.topAnchor),
            allView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            allView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            allView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -47)
        ]
        NSLayoutConstraint.activate(allViewConstraints)
        
        let mainTitleConstraints: [NSLayoutConstraint] = [
            mainTitle.topAnchor.constraint(equalTo: allView.topAnchor, constant: 52),
            mainTitle.centerXAnchor.constraint(equalTo: allView.centerXAnchor)
        ]
        NSLayoutConstraint.activate(mainTitleConstraints)
        
        let langTitleConstraints: [NSLayoutConstraint] = [
            langTitle.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 20),
            langTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            langTitle.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(langTitleConstraints)
        
        let topViewConstraints: [NSLayoutConstraint] = [
            topView.topAnchor.constraint(equalTo: langTitle.bottomAnchor, constant: 8),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            topView.heightAnchor.constraint(equalToConstant: 108)
        ]
        NSLayoutConstraint.activate(topViewConstraints)
        
        let russianLogoConstraints: [NSLayoutConstraint] = [
            russianLogo.topAnchor.constraint(equalTo: topView.topAnchor, constant: 16),
            russianLogo.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20),
        ]
        NSLayoutConstraint.activate(russianLogoConstraints)
        
        let russianTitleConstraints: [NSLayoutConstraint] = [
            russianTitle.topAnchor.constraint(equalTo: topView.topAnchor, constant: 18),
            russianTitle.leadingAnchor.constraint(equalTo: russianLogo.trailingAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(russianTitleConstraints)
        
        let russianTagConstraints: [NSLayoutConstraint] = [
            russianTag.topAnchor.constraint(equalTo: topView.topAnchor, constant: 16),
            russianTag.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(russianTagConstraints)
        
        let langSeparatedViewConstraints: [NSLayoutConstraint] = [
            langSeparatedView.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            langSeparatedView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            langSeparatedView.leadingAnchor.constraint(equalTo: russianTitle.leadingAnchor),
            langSeparatedView.heightAnchor.constraint(equalToConstant: 1)
        ]
        NSLayoutConstraint.activate(langSeparatedViewConstraints)
        
        let englishLogoConstraints: [NSLayoutConstraint] = [
            englishLogo.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -16),
            englishLogo.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20),
        ]
        NSLayoutConstraint.activate(englishLogoConstraints)
        
        let englishTitleConstraints: [NSLayoutConstraint] = [
            englishTitle.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -18),
            englishTitle.leadingAnchor.constraint(equalTo: russianLogo.trailingAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(englishTitleConstraints)
        
        let englishTagConstraints: [NSLayoutConstraint] = [
            englishTag.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -16),
            englishTag.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(englishTagConstraints)
        
        
        
        
        
    }
}
