
//  SettingsViewController.swift
//  SharePay
//
//  Created by User on 18.04.2022.
//
import UIKit
import RadioGroup


protocol SettingView: AnyObject{
    
}

final class SettingsViewController: UIViewController {
    
    // Инициализация цветов
    let blueColor: UIColor? = UIColor(named: "BlueAccentColor")
    let labelColor: UIColor? = UIColor(named: "Label")
    let magentaColor: UIColor? = UIColor(named: "MagentaAccentColor")
    let greenColor: UIColor? = UIColor(named:"GreenAccentColor")
    let secondaryLabelColor: UIColor? = UIColor(named: "SecondaryLabel")
    let backgroundFillColor: UIColor? = UIColor(named: "Fill")
    let secondaryFillColor: UIColor? = UIColor(named: "SecondaryFill")
    let weakAccentColor: UIColor? = UIColor(named: "WeakAccentColor")
    
    var presenter: SettingViewPresenter
    
    init(presenter: SettingViewPresenter){
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
///Подложка
    let allView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "SecondaryFill")
        return view
    }()
    
///Заголовок
    let mainTitle = UILabel(text: "SettingsViewController.Label.mainTitle".localized(), color: "Label", size: 24)
 
///Язык интерфейса
    let langTitle = UILabel(text: "SettingsViewController.Label.langTitle".localized(), color:"Label", size: 20, alignment: .left)
///Push уведомления
    let pushTitle = UILabel(text: "SettingsViewController.Label.pushTitle".localized(), color: "Label", size: 20)
    
///Верхний View
    let topView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "WhiteColor")
        view.layer.cornerRadius = UIScreen.main.bounds.size.width / 16
        view.layer.borderColor = UIColor(named: "Label")?.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    
///Нижний View
    let bottomView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "WhiteColor")
        view.layer.cornerRadius = UIScreen.main.bounds.size.width / 16
        view.layer.borderColor = UIColor(named: "Label")?.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    
///Новый счет
    let newBillTitle = UILabel(text: "SettingsViewController.Label.newBillTitle".localized(), color: "Label", size: 18, name: "GTEestiProDisplay-Regular")
    
    
///Новая оплата
    let newPayTitle = UILabel(text: "SettingsViewController.Label.newPayTitle".localized(), color: "Label", size: 18, name: "GTEestiProDisplay-Regular")
    
    
///Toggle счет
    let billSwitch: UISwitch = UISwitch()
    
    
///Toggle Оплата
    let paySwitch: UISwitch = UISwitch()
    
    
///Линия разделения push
    let pushSeparatedView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(named: "DarkBlueLabel")?.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    
///Версия приложения
    let versionTitle = UILabel(text: "SettingsViewController.Label.versionTitle".localized() + " 1.0.0", color: "Label", size: 12, name: "GTEestiProDisplay-Regular")
    
    
///Количество пользователей
    let usersTitle = UILabel(text: "SettingsViewController.Label.usersTitle".localized(), color: "Label", size: 12, name: "GTEestiProDisplay-Regular")
    
    
///Метка разработано
    let developTitle = UILabel(text: "SettingsViewController.Label.developTitle".localized(), color: "Label", size: 12, name: "GTEestiProDisplay-Regular")
    
    
///Название команды
    let teamTitle = UILabel(text: "CringeTeam", color: "Label", size: 12, name: "GTEestiProDisplay-UltraBold")
    
    let radioGroup: RadioGroup = {
        let radioGroup = RadioGroup(titles: [])
        radioGroup.translatesAutoresizingMaskIntoConstraints = false
        radioGroup.selectedIndex = 0
        radioGroup.titleAlignment = .left
        radioGroup.isButtonAfterTitle = true
        radioGroup.titleFont = UIFont(name: "GTEestiProDisplay-Regular", size: 20)
        return radioGroup
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        arrangeConstraints()
        
        radioGroup.addTarget(self, action: #selector(self.languageSelected), for: .valueChanged)
        radioGroup.titles = presenter.listLanguageItems().map{$0.name}
        radioGroup.selectedIndex = calculateSelectedIndex(langCode: presenter.getSelectedLanguageCode())
    }
    
    func calculateSelectedIndex(langCode: String) -> Int{
        let items = presenter.listLanguageItems()
        for (idx, item) in items.enumerated(){
            if item.code == langCode{
                return idx
            }
        }
        return 0
    }
    
    @objc func languageSelected(){
        presenter.selectLanguage(lang: presenter.listLanguageItems()[radioGroup.selectedIndex].code)
    }
    
    
    func setView(){
        topView.backgroundColor = backgroundFillColor
        bottomView.backgroundColor = backgroundFillColor
        
        radioGroup.backgroundColor = backgroundFillColor
        radioGroup.selectedTintColor = magentaColor
        radioGroup.tintColor = magentaColor
    }
    
   ///Установка констрэйнток
    func arrangeConstraints() {
        
        view.addSubview(allView)
        allView.addSubview(mainTitle)
        
        allView.addSubview(langTitle)
        allView.addSubview(topView)
        topView.addSubview(radioGroup)


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
        
        [allView, mainTitle, langTitle, topView, pushTitle, bottomView, newBillTitle, billSwitch, pushSeparatedView, newPayTitle, paySwitch, versionTitle, usersTitle, developTitle, teamTitle].forEach {
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
        
        NSLayoutConstraint.activate([
            radioGroup.topAnchor.constraint(equalTo: topView.topAnchor, constant: 10),
            radioGroup.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 16),
            radioGroup.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -16),
            radioGroup.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -10)
        ])
        
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
            newBillTitle.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20)
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
            newPayTitle.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20)
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

extension SettingsViewController: SettingView{
    
}
