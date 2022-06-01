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
        self.setTitleColor(self.isSelected ? UIColor(named: "WhiteColor") : UIColor(named: "Fill"), for: .normal)
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
        var newFormatter = DateFormatter()
        newFormatter.dateFormat = "yyyy-dd-MM'T'HH:mm:ss.SSS'Z'"
        guard let date = newFormatter.date(from: self) else {
            newFormatter = DateFormatter()
            newFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            guard let date = newFormatter.date(from: self) else {
                return Date.init(timeIntervalSince1970: TimeInterval(0))
            }
            return date
        }
        return date
    }
    
    // Конвертация в clean phone format
    func toDefaultPhoneFormat() -> String{
        return self.filter {!($0.isWhitespace || $0=="+" || $0=="-" || $0==")" || $0=="(")}
    }
    
    // Возвращаем знак валюты по наименованию
    func toCurrencySign() -> String {
        let currencyNameSignMap: [String: String] = [
            "rub" : "₽"
        ]
        guard let sign = currencyNameSignMap[self] else {
            return ""
        }
        return sign
    }
    
    func localized() -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.localizedBundle(), value: "", comment: "")
    }

    func localizeWithFormat(arguments: CVarArg...) -> String{
        return String(format: self.localized(), arguments: arguments)
    }
}

extension Date{
    func decodeToRussianString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        return dateFormatter.string(from: self)
    }
}

extension Bundle {
    private static var bundle: Bundle!

    public static func localizedBundle() -> Bundle! {
        if bundle == nil {
            let appLang = UserDefaults.standard.string(forKey: "app_lang") ?? "ru"
            let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
            bundle = Bundle(path: path!)
        }

        return bundle;
    }

    public static func setLanguage(lang: String) {
        UserDefaults.standard.set(lang, forKey: "app_lang")
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        bundle = Bundle(path: path!)
    }
    
    public static func getLanguage() -> String {
        guard let langCode = UserDefaults.standard.string(forKey: "app_lang") else {
            setLanguage(lang: Locale.current.languageCode ?? "ru")
            return Locale.current.languageCode ?? "ru"
        }
        return langCode
    }

}

