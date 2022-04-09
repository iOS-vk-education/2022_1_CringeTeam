//
//  File.swift
//  SharePay
//
//  Created by Denis Kholod on 09.04.2022.

import UIKit

final class PurchaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct Constants {
        static fileprivate let headerHeight: CGFloat = 200
    }

    private var tableView: UITableView!
    private var headerContainerView: UIView!
    private var headerTopConstraint: NSLayoutConstraint!
    private var headerHeightConstraint: NSLayoutConstraint!
    private var firstButton: UIButton!
    private var secondButton: UIButton!
    private var thirdButton: UIButton!
    
    private var topView: UIView!
    private var menuView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topView = createTopView()
        tableView = createTableView()
        headerContainerView = createHeaderContainerView()
        menuView = createMenuView()
        firstButton = createButton(text: "Все", flag: false)
        secondButton = createButton(text: "Черновик", flag: false)
        thirdButton = createButton(text: "Подтвержденные", flag: false)
    
        view.addSubview(topView)
        view.addSubview(tableView)
        
        view.addSubview(headerContainerView)
        headerContainerView.addSubview(menuView)
        menuView.addSubview(firstButton)
      //  menuView.addSubview(secondButton)
       // menuView.addSubview(thirdButton)
        
        
        arrangeConstraints()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello"
        return cell
    }
}

private extension PurchaseViewController {
    //Внешний вид
    func createTableView() -> UITableView {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        //table.showsVerticalScrollIndicator = false
        return table
    }

    func createTopView() -> UIView {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        return view
    }

    func createHeaderContainerView() -> UIView {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        return view
    }
    
    func createMenuView() -> UIView {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }
    
    func createButton(text: String, flag: Bool) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.backgroundColor = flag ? .systemBlue : .systemGray
        button.tintColor = .white
        button.titleLabel?.text = "000"
        button.layer.cornerRadius = 10
        return button
    }
    
    
   //Установка констрэйнток
    func arrangeConstraints() {
        
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
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
        ]
        NSLayoutConstraint.activate(tableViewConstraints)
        
        let menuViewConstraints: [NSLayoutConstraint] = [
            menuView.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor),
            menuView.widthAnchor.constraint(equalTo: tableView.widthAnchor),
            menuView.heightAnchor.constraint(equalToConstant: 52)
        ]
        NSLayoutConstraint.activate(menuViewConstraints)
        
        let firstButtonConstraints: [NSLayoutConstraint] = [
            firstButton.topAnchor.constraint(equalTo: menuView.topAnchor, constant: 12),
            firstButton.leadingAnchor.constraint(equalTo: menuView.leadingAnchor, constant: 18),
            firstButton.widthAnchor.constraint(equalToConstant: 50),
            firstButton.bottomAnchor.constraint(equalTo: menuView.bottomAnchor, constant: -12)
           
            
            
        ]
        NSLayoutConstraint.activate(firstButtonConstraints)
        
    }
}
//Эффект паралах
extension PurchaseViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0.0 {
            
            headerHeightConstraint?.constant = Constants.headerHeight - scrollView.contentOffset.y
            print(scrollView.contentOffset.y)
           
        } else {

        }
    }
}
