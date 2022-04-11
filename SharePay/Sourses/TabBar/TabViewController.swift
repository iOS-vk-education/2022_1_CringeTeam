//
//  TabBarController.swift
//  SharePay
//
//  Created by dekholod on 17.04.2022.
//
import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setApperrence()
        createTabBar()
        setupMiddleButton()
    }
    
    func createTabBar() {
        let controller1 = PurchasesViewController()
        controller1.tabBarItem = UITabBarItem(title: NSLocalizedString("TabBarController.Type.FirstTab", comment: ""), image: UIImage(named: "firstTab"), tag: 1)
        let nav1 = UINavigationController(rootViewController: controller1)
        
        let controller2 = DebtsViewController()
        controller2.tabBarItem = UITabBarItem(title: NSLocalizedString("TabBarController.Type.SecondTab", comment: ""), image: UIImage(named: "secondTab"), tag: 2)
        let nav2 = UINavigationController(rootViewController: controller2)

        let controller3 = PurchasesViewController()
        let nav3 = UINavigationController(rootViewController: controller3)
        nav3.title = ""

        let controller4 = ViewController()
        controller4.tabBarItem = UITabBarItem(title: NSLocalizedString("TabBarController.Type.ThirdTab", comment: ""), image: UIImage(named: "thirdTab"), tag: 4)
        let nav4 = UINavigationController(rootViewController: controller4)

        let controller5 = ViewController()
        controller5.tabBarItem = UITabBarItem(title: NSLocalizedString("TabBarController.Type.ForthTab", comment: ""), image: UIImage(named: "forthTab"), tag: 5)
        let nav5 = UINavigationController(rootViewController: controller5)
        
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
        
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 45
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
        let tap = PurchaseViewController()
        present(tap, animated: true, completion: nil)
    }
}
