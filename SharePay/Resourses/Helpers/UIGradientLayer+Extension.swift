//
//  UIGradientLayer+Extension.swift
//  SharePay
//
//  Created by Мехрафруз on 03.04.2022.
//

import UIKit

enum GradientPosition {
    case topToBottom
    case leftToRight
    case topLeftToBottomRight
    case topRightToBottomLeft
}

extension UIView {
    func applyGradient(colors: [UIColor],
                       cornerRadius: CGFloat? = nil,
                       position: GradientPosition = .leftToRight) {
        
        if let _ = layer.sublayers?.first as? CAGradientLayer {
            layer.sublayers?.first?.removeFromSuperlayer()
        }
        
        let gradientLayer = CAGradientLayer.createGradient(colors: colors,
                                                           cornerRadius: cornerRadius == nil ? self.layer.cornerRadius : cornerRadius,
                                                           position: position)
        
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func applyCuttingGradient(width: Int,
                       height: Int,
                       corner: CGFloat,
                       firstColor: String,
                       secondColor: String) {
        
        if let _ = layer.sublayers?.first as? CAGradientLayer {
            layer.sublayers?.first?.removeFromSuperlayer()
        }
        
        let gradientLayer = CAGradientLayer.createCuttingGradient(width: width,
                                                                  height: height,
                                                                  corner: corner,
                                                                  firstColor: firstColor,
                                                                  secondColor: secondColor)
        
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

}

extension CAGradientLayer {
    static func createGradient(colors: [UIColor],
                               cornerRadius: CGFloat? = nil,
                               position: GradientPosition = .leftToRight) -> CAGradientLayer {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        
        switch position {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        case .topLeftToBottomRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        case .topRightToBottomLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        
        gradientLayer.cornerRadius = cornerRadius ?? 0
        return gradientLayer
    }
    
    static func createCuttingGradient(width: Int,
                                      height: Int,
                                      corner: CGFloat,
                                      firstColor: String,
                                      secondColor: String) -> CAGradientLayer {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        gradientLayer.cornerRadius = corner
        gradientLayer.colors = [UIColor(named: firstColor)?.cgColor as Any, UIColor(named: secondColor)?.cgColor as Any]
        gradientLayer.locations = [0.5, 0.5]
        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        
        return gradientLayer
    }
    
}
