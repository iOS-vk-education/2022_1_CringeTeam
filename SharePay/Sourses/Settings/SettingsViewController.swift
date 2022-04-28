
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
    let mainTitle = UILabel(text: NSLocalizedString("SettingsViewController.Label.mainTitle", comment: ""), color: "DarkBlueColor", size: 24)
 
///Язык интерфейса
    let langTitle = UILabel(text: NSLocalizedString("SettingsViewController.Label.langTitle", comment: ""), color:"DarkBlueColor", size: 20, alignment: .left)
///Push уведомления
    let pushTitle = UILabel(text: NSLocalizedString("SettingsViewController.Label.pushTitle", comment: ""), color: "DarkBlueColor", size: 20)
    
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
        view.layer.cornerRadius = UIScreen.main.bounds.size.width / 16
        view.layer.borderColor = UIColor(named: "DarkBlueColor")?.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    
///Флаг русский
    let russianLogo = UILabel(text: "🇷🇺", color: "DarkBlueColor", size: 24)
    
    
///Флаг английский
    let englishLogo = UILabel(text: "🇺🇸", color: "DarkBlueColor", size: 24)
    
    
///Русский язык
    let russianTitle = UILabel(text: NSLocalizedString("SettingsViewController.Label.russianTitle", comment: ""), color: "DarkBlueColor", size: 18, name: "GTEestiProDisplay-Regular")
    
    
///Английский язык
    let englishTitle = UILabel(text: NSLocalizedString("SettingsViewController.Label.englishTitle", comment: ""), color: "DarkBlueColor", size: 18, name: "GTEestiProDisplay-Regular")
    
    
///Метка русский язык
    let russianTag = UILabel(text: "✔️", color: "DarkBlueColor", size: 20)
    
    
///Метка английский язык
    let englishTag = UILabel(text: "✔️", color: "WhiteColor", size: 0)
    
    
///Линия разделения языков
    let langSeparatedView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(named: "GreyColor")?.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    
///Новый счет
    let newBillTitle = UILabel(text: NSLocalizedString("SettingsViewController.Label.newBillTitle", comment: ""), color: "DarkBlueColor", size: 18, name: "GTEestiProDisplay-Regular")
    
    
///Новая оплата
    let newPayTitle = UILabel(text: NSLocalizedString("SettingsViewController.Label.newPayTitle", comment: ""), color: "DarkBlueColor", size: 18, name: "GTEestiProDisplay-Regular")
    
    
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
    let versionTitle = UILabel(text: NSLocalizedString("SettingsViewController.Label.versionTitle", comment: "") + " 1.0.0", color: "GreyColor", size: 12, name: "GTEestiProDisplay-Regular")
    
    
///Количество пользователей
    let usersTitle = UILabel(text: NSLocalizedString("SettingsViewController.Label.usersTitle", comment: ""), color: "GreyColor", size: 12, name: "GTEestiProDisplay-Regular")
    
    
///Метка разработано
    let developTitle = UILabel(text: NSLocalizedString("SettingsViewController.Label.developTitle", comment: ""), color: "DarkBlueColor", size: 12, name: "GTEestiProDisplay-Regular")
    
    
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

        allView.addSubview(pushTitle)
        allView.addSubview(bottomView)
        bottomView.addSubview(newBillTitle)
        bottomView.addSubview(billSwitch)
        bottomView.addSubview(pushSeparatedView)
        bottomView.addSubview(newPayTitle)
        bottomView.addSubview(paySwitch)

        allView.addSubview(versionTitle)
        allView.addSubview(usersTitle)
        allView.addSubview(developTitle)
        allView.addSubview(teamTitle)
        
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
        
        let pushTitleConstraints: [NSLayoutConstraint] = [
            pushTitle.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20),
            pushTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            pushTitle.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(pushTitleConstraints)
        
        let bottomViewConstraints: [NSLayoutConstraint] = [
            bottomView.topAnchor.constraint(equalTo: pushTitle.bottomAnchor, constant: 8),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            bottomView.heightAnchor.constraint(equalToConstant: 108)
        ]
        NSLayoutConstraint.activate(bottomViewConstraints)
        
        let newBillTitleConstraints: [NSLayoutConstraint] = [
            newBillTitle.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 18),
            newBillTitle.leadingAnchor.constraint(equalTo: russianLogo.trailingAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(newBillTitleConstraints)
        
        let billSwitchConstraints: [NSLayoutConstraint] = [
            billSwitch.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16),
            billSwitch.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(billSwitchConstraints)
        
        let pushSeparatedViewConstraints: [NSLayoutConstraint] = [
            pushSeparatedView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            pushSeparatedView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            pushSeparatedView.leadingAnchor.constraint(equalTo: newBillTitle.leadingAnchor),
            pushSeparatedView.heightAnchor.constraint(equalToConstant: 1)
        ]
        NSLayoutConstraint.activate(pushSeparatedViewConstraints)
        
        let newPayTitleConstraints: [NSLayoutConstraint] = [
            newPayTitle.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -18),
            newPayTitle.leadingAnchor.constraint(equalTo: russianLogo.trailingAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(newPayTitleConstraints)
        
        let paySwitchConstraints: [NSLayoutConstraint] = [
            paySwitch.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -16),
            paySwitch.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(paySwitchConstraints)
        
        let versionTitleConstraints: [NSLayoutConstraint] = [
            versionTitle.bottomAnchor.constraint(equalTo: allView.bottomAnchor, constant: -130),
            versionTitle.centerXAnchor.constraint(equalTo: allView.centerXAnchor)
        ]
        NSLayoutConstraint.activate(versionTitleConstraints)
        
        let usersTitleConstraints: [NSLayoutConstraint] = [
            usersTitle.bottomAnchor.constraint(equalTo: allView.bottomAnchor, constant: -115),
            usersTitle.centerXAnchor.constraint(equalTo: allView.centerXAnchor)
        ]
        NSLayoutConstraint.activate(usersTitleConstraints)
        
        let developTitleConstraints: [NSLayoutConstraint] = [
            developTitle.bottomAnchor.constraint(equalTo: allView.bottomAnchor, constant: -90),
            developTitle.centerXAnchor.constraint(equalTo: allView.centerXAnchor, constant: -36)
        ]
        NSLayoutConstraint.activate(developTitleConstraints)
        
        let teamTitleConstraints: [NSLayoutConstraint] = [
            teamTitle.bottomAnchor.constraint(equalTo: allView.bottomAnchor, constant: -90),
            teamTitle.centerXAnchor.constraint(equalTo: allView.centerXAnchor, constant: 36)
        ]
        NSLayoutConstraint.activate(teamTitleConstraints)
        
    }
}
