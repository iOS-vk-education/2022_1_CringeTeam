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
    convenience init(text: String, color: String, size: Int = 42) {
        self.init()
        self.text = text
        self.textColor = UIColor(named: color)
        self.font = UIFont(name: "GTEestiProDisplay-UltraBold", size: CGFloat(size))
        self.textAlignment = .right
    }
}

