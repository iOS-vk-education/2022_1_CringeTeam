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
    
    var presenter: TabViewPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        setApperrence()
        createTabBar()
        setupMiddleButton()
    }
    
    func createTabBar() {
        let purchasesViewController = PurchasesViewController()
        purchasesViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("TabBarController.Type.FirstTab", comment: ""), image: UIImage(named: "firstTab"), tag: 1)
        let nav1 = UINavigationController(rootViewController: purchasesViewController)
        
        let debtsViewController = DebtsViewController()
        debtsViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("TabBarController.Type.SecondTab", comment: ""), image: UIImage(named: "secondTab"), tag: 2)
        let nav2 = UINavigationController(rootViewController: debtsViewController)

        let plusViewController = PurchasesViewController()
        let nav3 = UINavigationController(rootViewController: plusViewController)
        nav3.title = ""

        let transferViewController = TransfersViewController()
        transferViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("TabBarController.Type.ThirdTab", comment: ""), image: UIImage(named: "thirdTab"), tag: 4)
        let nav4 = UINavigationController(rootViewController: transferViewController)

        let settingsViewController = SettingsViewController()
        settingsViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("TabBarController.Type.ForthTab", comment: ""), image: UIImage(named: "forthTab"), tag: 5)
        let nav5 = UINavigationController(rootViewController: settingsViewController)
        
        viewControllers = [nav1, nav2, nav3, nav4, nav5]
    }
    
    func setApperrence() {
        self.tabBar.backgroundColor = UIColor(named: "WhiteColor")
        self.tabBar.layer.borderWidth = 0.5
        self.tabBar.layer.borderColor = UIColor(named: "GreyColor")?.cgColor
        self.tabBar.tintColor = UIColor(named: "BlueColor")
        self.tabBar.unselectedItemTintColor = UIColor(named: "DarkBlueColor")
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
        menuButton.setTitleColor(UIColor(named: "WhiteColor"), for: .normal)
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
    }

    @objc private func menuButtonAction(sender: UIButton) {
        selectedIndex = 2
        presenter.newPurchase()
    }
}

extension TabViewController: TabView{
    
}
