//
//  DebtViewController.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 21.04.2022.
//

import Foundation

import UIKit

class DebtViewController: UIViewController{
    
    // Инициализация цветов
    let blueColor: UIColor? = UIColor(named: "BlueAccentColor")
    let labelColor: UIColor? = UIColor(named: "Label")
    let magentaColor: UIColor? = UIColor(named: "MagentaAccentColor")
    let greenColor: UIColor? = UIColor(named:"GreenAccentColor")
    let secondaryLabelColor: UIColor? = UIColor(named: "SecondaryLabel")
    let backgroundFillColor: UIColor? = UIColor(named: "Fill")
    let secondaryFillColor: UIColor? = UIColor(named: "SecondaryFill")
    let weakAccentColor: UIColor? = UIColor(named: "WeakAccentColor")
    
    let eventLabel: UILabel = {
        let eventLabel: UILabel = UILabel()
        eventLabel.text = NSLocalizedString("DebtViewController.Label.Events" , comment: "")
        eventLabel.textAlignment = .left
        eventLabel.font = UIFont(name: "GTEestiProDisplay-Bold", size: 24) // TODO define font size
        return eventLabel
    }()
    
    let paymentView = PaymentBadge()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setLayout()
    }
    
    
    
    func setLayout(){
        
        paymentView.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            paymentView.topAnchor.constraint(equalTo:  self.view.safeAreaLayoutGuide.topAnchor, constant: view.frame.width*0.05),
            paymentView.widthAnchor.constraint(equalToConstant: view.frame.width*0.9),
            paymentView.heightAnchor.constraint(equalToConstant: view.frame.height/4),
            paymentView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
           ])
        
        eventLabel.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            eventLabel.topAnchor.constraint(equalTo:  paymentView.bottomAnchor, constant: 8),
            eventLabel.widthAnchor.constraint(equalToConstant: view.frame.width*0.9),
            eventLabel.heightAnchor.constraint(equalToConstant: 40),
            eventLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
           ])
        
    }
    
    
    func setViews(){
        self.view.backgroundColor = backgroundFillColor
        
        self.view.addSubview(eventLabel)
        self.view.addSubview(paymentView)
        
        eventLabel.textColor = labelColor
    }
    
    
    
}
