//
//  File.swift
//  SharePay
//
//  Created by Denis Kholod on 09.04.2022.
import UIKit

protocol PurchasesView: AnyObject{
    func onSuccessLoad()
    func onFailesLoad()
}

final class PurchasesViewController: UIViewController {
    
    let blueColor: UIColor? = UIColor(named: "BlueAccentColor")
    let labelColor: UIColor? = UIColor(named: "Label")
    let magentaColor: UIColor? = UIColor(named: "MagentaAccentColor")
    let greenColor: UIColor? = UIColor(named:"GreenAccentColor")
    let secondaryLabelColor: UIColor? = UIColor(named: "SecondaryLabel")
    let backgroundFillColor: UIColor? = UIColor(named: "Fill")
    let secondaryFillColor: UIColor? = UIColor(named: "SecondaryFill")
    let weakAccentColor: UIColor? = UIColor(named: "WeakAccentColor")
    
    var presenter: PurchasesViewPresenter
    
    init(presenter: PurchasesViewPresenter){
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct Constants {
        static let headerHeight: CGFloat = 200
    }
    
// Верхняя полоска
    let topView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "BlueColor")
        return view
    }()
    
// Заголовок
    let mainTitle = UILabel(text: "SharePay", color: "WhiteColor", size: 24)
// Логотип
    let logoLabel: UILabel = {
        let label = UILabel()
        label.layer.borderColor = UIColor(named: "WhiteColor")?.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 6
        
    // Создание градиент
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: 11, height: 11)
        layer.cornerRadius = 5
        
        layer.colors = [UIColor(named: "BlueColor")?.cgColor ?? UIColor.blue.cgColor, UIColor(named: "MagentaColor")?.cgColor ?? UIColor.red.cgColor]
        layer.locations = [0.5, 0.5]
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))

        label.layer.insertSublayer(layer, at: 0)
        return label
    }()
// Уведомления
    let bellButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bell"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
// Сумма покупок
    let sumTitleLabel = UILabel(text: "PurchasesViewController.Sum.Title".localized(), color: "WhiteColor", size: 24)
    
    let sumLabel = UILabel(text: "", color: "WhiteColor", size: 24)
    
// Констрейнты для паралакса
    var headerTopConstraint: NSLayoutConstraint!
    var headerHeightConstraint: NSLayoutConstraint!
    
// Хедер
    let headerContainerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "BlueColor")
        return view
    }()
    
// Меню
    let menuView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "SecondaryFill")
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

// Кнопки
    let allButton: UIButton = {
        let button = UIButton(text: "PurchasesViewController.FirstButton.Title".localized(), width: 60)
        button.backgroundColor =  UIColor(named: "BlueAccentColor") // кнопка по умолчанию
        button.setTitleColor(UIColor(named: "White"), for: .normal)
        return button
    }()
    
    
    let draftButton: UIButton = {
        let button =  UIButton(text: "PurchasesViewController.SecondButton.Title".localized(), width: 100)
        button.backgroundColor =  UIColor(named: "DarkFillColor")
        button.setTitleColor(UIColor(named: "Label"), for: .normal)
        return button
    }()
    
    let confirmedButton: UIButton = {
        let button = UIButton(text: "PurchasesViewController.ThirdButton.Title".localized(), width: 150)
        button.backgroundColor =  UIColor(named: "DarkFillColor")
        button.setTitleColor(UIColor(named: "Label"), for: .normal)
        return button
    }()
  
    
// Таблица
    let tableView: UITableView = {
        let table = UITableView()
        table.register(PurchasesTableViewCell.self, forCellReuseIdentifier: "PurchaseItemCell")
        table.backgroundColor = UIColor(named: "SecondaryFill")
        table.separatorStyle = .none
        return table
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        arrangeConstraints()
        setFilterButtonsActions()
    }
    
    func setFilterButtonsActions(){
        allButton.addAction { [weak self] in
            self?.allButton.backgroundColor = UIColor(named: "BlueAccentColor")
            self?.confirmedButton.backgroundColor = UIColor(named: "DarkFillColor")
            self?.draftButton.backgroundColor = UIColor(named: "DarkFillColor")
            
            self?.allButton.setTitleColor(UIColor(named: "WhiteColor"), for: .normal)
            self?.confirmedButton.setTitleColor(UIColor(named: "Label"), for: .normal)
            self?.draftButton.setTitleColor(UIColor(named: "Label"), for: .normal)
            
            self?.presenter.setFilter(filter: .all)
            self?.tableView.reloadData()
        }
        
        confirmedButton.addAction { [weak self] in
            self?.allButton.backgroundColor = UIColor(named: "DarkFillColor")
            self?.confirmedButton.backgroundColor =  UIColor(named: "BlueAccentColor")
            self?.draftButton.backgroundColor = UIColor(named: "DarkFillColor")
            
            self?.allButton.setTitleColor(UIColor(named: "Label"), for: .normal)
            self?.confirmedButton.setTitleColor(UIColor(named: "WhiteColor"), for: .normal)
            self?.draftButton.setTitleColor(UIColor(named: "Label"), for: .normal)
            
            self?.presenter.setFilter(filter: .billed)
            self?.tableView.reloadData()
        }
        
        draftButton.addAction { [weak self] in
            self?.allButton.backgroundColor = UIColor(named: "DarkFillColor")
            self?.confirmedButton.backgroundColor =  UIColor(named: "DarkFillColor")
            self?.draftButton.backgroundColor = UIColor(named: "BlueAccentColor")
            
            self?.allButton.setTitleColor(UIColor(named: "Label"), for: .normal)
            self?.confirmedButton.setTitleColor(UIColor(named: "Label"), for: .normal)
            self?.draftButton.setTitleColor(UIColor(named: "WhiteColor"), for: .normal)
            
            self?.presenter.setFilter(filter: .draft)
            self?.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter.refresh()
    }
    
    @objc func didPullToRefresh(){
        presenter.refresh()
    }
    
   // Установка констрэйнток
    func arrangeConstraints() {
        let stackView = UIStackView(arrangedSubviews: [allButton,
                                                      draftButton,
                                                    confirmedButton])
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

extension PurchasesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0.0 {
            headerHeightConstraint?.constant = Constants.headerHeight - scrollView.contentOffset.y
            
            if scrollView.refreshControl == nil {
                        let refreshControl = UIRefreshControl()
                        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
                        scrollView.refreshControl = refreshControl
            }
            
        } else {

        }
    }
}

extension PurchasesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter.listPurchases().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let purchaseCell = tableView.dequeueReusableCell(withIdentifier: "PurchaseItemCell", for: indexPath) as? PurchasesTableViewCell else{
            return UITableViewCell()
        }
        purchaseCell.isUserInteractionEnabled = true
        purchaseCell.setData(purchase: presenter.listPurchases()[indexPath.row])
        return purchaseCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showPurchase(purchase_id: presenter.listPurchases()[indexPath.row].id)
    }
}

extension PurchasesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

extension PurchasesViewController: PurchasesView{
    func onSuccessLoad() {
        self.tableView.reloadData()
        self.sumLabel.text = "\(self.presenter.getTotalAmount()) \(self.presenter.getCurrency().toCurrencySign())"
    }
    
    func onFailesLoad() {
        let alertController = UIAlertController(title:  "Common.Error".localized(), message:
                                                    "PurchasesViewController.Alert.FailLoad".localized(), preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title:  "Common.Ok".localized(), style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
}
