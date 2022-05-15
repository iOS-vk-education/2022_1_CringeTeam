//
//  Extensions.swift
//  SharePay
//
//  Created by User on 31.03.2022.
//

import Foundation
import UIKit

//Градиент
extension UILabel {
    func applyGradient(width: Int, height: Int, corner: Int, firstColor: String, secondColor: String) -> CAGradientLayer {
        
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        layer.cornerRadius = CGFloat(corner)
        layer.colors = [UIColor(named: "String")?.cgColor as Any, UIColor(named: "String")?.cgColor as Any]
        layer.locations = [0.5, 0.5]
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        return layer
    }
    
}

//Onboard
extension UILabel {
    convenience init(text: String, color: String, size: Int = 42, name: String = "GTEestiProDisplay-UltraBold", alignment: NSTextAlignment = .right) {
        self.init()
        self.text = text
        self.textColor = UIColor(named: color)
        self.font = UIFont(name: name, size: CGFloat(size))
        self.textAlignment = alignment
    }
}

//Purchases UIbutton
extension UIButton {
    convenience init(text: String, width: CGFloat) {
        self.init()
        self.titleLabel?.font = UIFont(name: "GTEestiProDisplay-Regular", size: 16)
        self.backgroundColor = self.isSelected ? UIColor(named: "BlueColor") : UIColor(named: "LightGreyColor")
        self.setTitle(text, for: .normal)
        self.setTitleColor(self.isSelected ? UIColor(named: "WhiteColor") : UIColor(named: "GreyColor"), for: .normal)
        self.layer.cornerRadius = 16
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        
    }
    
}

extension UITextField {
    
    convenience init(cornerRadius: CGFloat){
        self.init()
        
        let secondaryLabelColor: UIColor? = UIColor(named: "WeakAccentColor")
        let backgroundSecondaryFillColor: UIColor? = UIColor(named: "SecondaryFill")
        self.textAlignment = .center
        self.backgroundColor = backgroundSecondaryFillColor
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = secondaryLabelColor?.cgColor
        self.layer.borderWidth = 1.0
    }

}
//Паралах эффект
extension PurchasesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0.0 {

            headerHeightConstraint?.constant = Constants.headerHeight - scrollView.contentOffset.y
            print(scrollView.contentOffset.y)

        } else {

        }
    }
}
//Purchases Таблица делегаты
extension PurchasesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PurchasesTableViewCell

        return cell
    }
}

//Purchases Таблица делегаты
extension PurchasesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }

}


//DEBT Паралах эффект
extension DebtsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0.0 {

            headerHeightConstraint?.constant = Constants.headerHeight - scrollView.contentOffset.y
            print(scrollView.contentOffset.y)

        } else {

        }
    }
}
//DEBT Таблица делегаты
extension DebtsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellD", for: indexPath) as! DebtsTableViewCell

        return cell
    }
}

//Debt Таблица делегаты
extension DebtsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }

}

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        addAction(UIAction { (action: UIAction) in closure() }, for: controlEvents)
    }
}

// Прячем клавиатуры при нажатии на свободную область экрана
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension String{
    
    func parseRFC3339Date() -> Date{
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "yyyy-dd-MM'T'HH:mm:ss.SSS'Z'"
        guard let date = newFormatter.date(from: self) else {
            return Date.init(timeIntervalSince1970: TimeInterval(0))
        }
        return date
    }
    
    func toDefaultPhoneFormat() -> String{
        return self.filter {!($0.isWhitespace || $0=="+" || $0=="-" || $0==")" || $0=="(")}
    }
}

extension Date{
    func decodeToRussianString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        return dateFormatter.string(from: self)
    }
}

