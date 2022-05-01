//
//  TransfersViewController.swift
//  SharePay
//
//  Created by User on 18.04.2022.
//
import UIKit

final class TransfersViewController: UIViewController {
    
///Подложка
    let allView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "WhiteColor")
        return view
    }()
    
///Заголовок
    let mainTitle = UILabel(text: "Переводы", color: "DarkBlueColor", size: 24)

///Таблица
    let tableView: UITableView = {
        let table = UITableView()
        table.register(TransfersTableViewCell.self, forCellReuseIdentifier: "cellT")
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
        
        view.addSubview(allView)
        allView.addSubview(mainTitle)
        allView.addSubview(tableView)
    
        [allView, mainTitle, tableView].forEach {
$0.translatesAutoresizingMaskIntoConstraints = false
}
        
        let allViewConstraints: [NSLayoutConstraint] = [
            allView.topAnchor.constraint(equalTo: view.topAnchor),
            allView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            allView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            allView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -47)
        ]
        NSLayoutConstraint.activate(allViewConstraints)

      
        let tableViewConstraints: [NSLayoutConstraint] = [
            
            tableView.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -47)
        ]
        NSLayoutConstraint.activate(tableViewConstraints)
        
        let mainTitleConstraints: [NSLayoutConstraint] = [
            mainTitle.topAnchor.constraint(equalTo: allView.topAnchor, constant: 52),
            mainTitle.centerXAnchor.constraint(equalTo: allView.centerXAnchor),
        ]
        NSLayoutConstraint.activate(mainTitleConstraints)
        
    }
}
