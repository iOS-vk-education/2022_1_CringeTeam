//
//  TabBarController.swift
//  SharePay
//
//  Created by dekholod on 17.04.2022.
//
import UIKit

protocol TabView: AnyObject{
    
}

class TabViewController: UITabBarController {
    
    var presenter: TabViewPresenter
    
    init(presenter: TabViewPresenter){
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setApperrence()
        createTabBar()
        setupMiddleButton()
    }
    
    func createTabBar() {
        let purchasesViewController = presenter.getRouter().assembleBuilder?.createPurchasesViewController(router: presenter.getRouter()) ?? UIViewController()
        purchasesViewController.tabBarItem = UITabBarItem(title: "TabBarController.Type.FirstTab".localized(), image: UIImage(named: "firstTab"), tag: 1)
        let nav1 = UINavigationController(rootViewController: purchasesViewController)
        
        let debtsViewController =
            presenter.getRouter().assembleBuilder?.createDebtsViewController(router: presenter.getRouter()) ?? UIViewController()
        debtsViewController.tabBarItem = UITabBarItem(title: "TabBarController.Type.SecondTab".localized(), image: UIImage(named: "secondTab"), tag: 2)
        let nav2 = UINavigationController(rootViewController: debtsViewController)

        
        let nav3 = UINavigationController(rootViewController: presenter.getRouter().assembleBuilder?.createPurchasesViewController(router: presenter.getRouter()) ?? UIViewController())
        nav3.title = ""
        
        let transferViewController = presenter.getRouter().assembleBuilder?.createTrasnfersViewController(router: presenter.getRouter()) ?? UIViewController()
        transferViewController.tabBarItem = UITabBarItem(title: "TabBarController.Type.ThirdTab".localized(), image: UIImage(named: "thirdTab"), tag: 4)
        let nav4 = UINavigationController(rootViewController: transferViewController)

        let settingsViewController = presenter.getRouter().assembleBuilder?.createSettingsViewController(router: presenter.getRouter()) ?? UIViewController()
        settingsViewController.tabBarItem = UITabBarItem(title: "TabBarController.Type.ForthTab".localized(), image: UIImage(named: "forthTab"), tag: 5)
        let nav5 = UINavigationController(rootViewController: settingsViewController)
        
        viewControllers = [nav1, nav2, nav3, nav4, nav5]
    }
    
    func setApperrence() {
        self.tabBar.backgroundColor = UIColor(named: "SecondaryFill")
        self.tabBar.layer.borderWidth = 0.5
        self.tabBar.layer.borderColor = UIColor(named: "SecondaryFill")?.cgColor
        self.tabBar.tintColor = UIColor(named: "BlueColor")
        self.tabBar.unselectedItemTintColor = UIColor(named: "Label")
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "GTEestiProDisplay-Medium", size: 12)!], for: .normal)
    }

    func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 77, height: 77))
        var menuButtonFrame = menuButton.frame
        
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 10
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame

        menuButton.backgroundColor = UIColor(named: "MagentaColor")
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        view.addSubview(menuButton)

        menuButton.setTitle("+", for: .normal)
        menuButton.titleLabel?.font = UIFont(name: "GTEestiProDisplay-UltraBold", size: 70)
        menuButton.setTitleColor(UIColor(named: "Fill"), for: .normal)
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
    }

    @objc private func menuButtonAction(sender: UIButton) {
        selectedIndex = 2
        presenter.showNewPurchase()
    }
}

extension TabViewController: TabView{}
