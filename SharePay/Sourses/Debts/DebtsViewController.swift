//
//  DebtsViewCobtroller.swift
//  SharePay
//
//  Created by User on 17.04.2022.

import UIKit

final class DebtsViewController: UIViewController {
    
    struct Constants {
        static let headerHeight: CGFloat = 200
    }
    
///Верхняя полоска
    let topView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "BlueColor")
        return view
    }()
    
///Заголовок
    let mainTitle = UILabel(text: "SharePay", color: "WhiteColor", size: 24)
///Логотип
    let logoLabel: UILabel = {
        let label = UILabel()
        label.layer.borderColor = UIColor(named: "WhiteColor")?.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 6
        
    ///Создание градиента
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: 11, height: 11)
        layer.cornerRadius = 5
        layer.colors = [UIColor(named: "BlueColor")?.cgColor as Any, UIColor(named: "MagentaColor")?.cgColor as Any]
        layer.locations = [0.5, 0.5]
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))

        label.layer.insertSublayer(layer, at: 0)
        return label
    }()
///Уведомления
    let bellButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bell"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
///Сумма покупок
    let sumTitleLabel = UILabel(text: NSLocalizedString("DebtsViewController.Sum.Title", comment: ""), color: "WhiteColor", size: 24)
    
    let sumLabel = UILabel(text: "100098 \u{20BD}", color: "WhiteColor", size: 24)
    
///Констрейнты для паралакса
    var headerTopConstraint: NSLayoutConstraint!
    var headerHeightConstraint: NSLayoutConstraint!
    
///Хедер
    let headerContainerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "BlueColor")
        return view
    }()
    
///Меню
    let menuView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "WhiteColor")
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

///Кнопки
    
    let firstButton = UIButton(text: NSLocalizedString("PurchasesViewController.FirstButton.Title", comment: ""), width: 60)
    
    let secondButton = UIButton(text: NSLocalizedString("DebtsViewController.SecondButton.Title", comment: ""), width: 100)
    
    let thirdButton = UIButton(text: NSLocalizedString("DebtsViewController.ThirdButton.Title", comment: ""), width: 120)
  
    
///Таблица
    let tableView: UITableView = {
        let table = UITableView()
        table.register(DebtsTableViewCell.self, forCellReuseIdentifier: "cellD")
        table.backgroundColor = UIColor(named: "WhiteColor")
        table.separatorStyle = .none
        return table
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        arrangeConstraints()
        
    }
    
   //Установка констрэйнток
    func arrangeConstraints() {
        let stackView = UIStackView(arrangedSubviews: [firstButton,
                                                      secondButton,
                                                      thirdButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        let stackLabelView = UIStackView(arrangedSubviews: [sumTitleLabel, sumLabel])
        stackLabelView.axis = .horizontal
        
        view.addSubview(topView)
        topView.addSubview(mainTitle)
        topView.addSubview(logoLabel)
        topView.addSubview(bellButton)
        view.addSubview(tableView)
        view.addSubview(headerContainerView)
        headerContainerView.addSubview(stackLabelView)
        headerContainerView.addSubview(menuView)
        menuView.addSubview(stackView)
        
        [topView, mainTitle, logoLabel, bellButton, headerContainerView, stackLabelView, sumLabel, sumTitleLabel, menuView, stackView, tableView].forEach {
$0.translatesAutoresizingMaskIntoConstraints = false
}
        
        let topViewConstraints: [NSLayoutConstraint] = [
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 80)
        ]
        NSLayoutConstraint.activate(topViewConstraints)

        headerTopConstraint = headerContainerView.topAnchor.constraint(equalTo: topView.bottomAnchor)
        headerHeightConstraint = headerContainerView.heightAnchor.constraint(equalToConstant: Constants.headerHeight)
        let headerContainerViewConstraints: [NSLayoutConstraint] = [
            headerTopConstraint,
            headerContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
            headerHeightConstraint
        ]
        NSLayoutConstraint.activate(headerContainerViewConstraints)
        
      
        let tableViewConstraints: [NSLayoutConstraint] = [
            
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: Constants.headerHeight),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -47)
        ]
        NSLayoutConstraint.activate(tableViewConstraints)
        
        let menuViewConstraints: [NSLayoutConstraint] = [
            menuView.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor),
            menuView.widthAnchor.constraint(equalTo: tableView.widthAnchor),
            menuView.heightAnchor.constraint(equalToConstant: 56)
        ]
        NSLayoutConstraint.activate(menuViewConstraints)
        
        let stackViewConstraints: [NSLayoutConstraint] = [
            stackView.topAnchor.constraint(equalTo: menuView.topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: menuView.bottomAnchor, constant: -12)
        ]
        NSLayoutConstraint.activate(stackViewConstraints)
        
        let mainTitleConstraints: [NSLayoutConstraint] = [
            mainTitle.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -5),
            mainTitle.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
        ]
        NSLayoutConstraint.activate(mainTitleConstraints)
        
        let bellButtonConstraints: [NSLayoutConstraint] = [
            bellButton.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -10),
            bellButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16),
        ]
        NSLayoutConstraint.activate(bellButtonConstraints)
        
        let stackLabelConstraints: [NSLayoutConstraint] = [
            stackLabelView.bottomAnchor.constraint(equalTo: menuView.topAnchor, constant: -70),
            stackLabelView.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor, constant: 16),
        ]
        NSLayoutConstraint.activate(stackLabelConstraints)
        
        let sumLabelConstraints: [NSLayoutConstraint] = [
            sumLabel.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor, constant: -16),
        ]
        NSLayoutConstraint.activate(sumLabelConstraints)
        
        let logoLabelConstraints: [NSLayoutConstraint] = [
                                     logoLabel.widthAnchor.constraint(equalToConstant: 12),
                                     logoLabel.heightAnchor.constraint(equalToConstant: 12),
                                     logoLabel.leadingAnchor.constraint(equalTo: mainTitle.trailingAnchor, constant: 5),
                                     logoLabel.topAnchor.constraint(equalTo: mainTitle.topAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(logoLabelConstraints)
        
    }
}
