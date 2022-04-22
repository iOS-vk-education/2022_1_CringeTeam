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
    
    
    var eventsCollectionView: UICollectionView?
    
    let eventLabel: UILabel = {
        let eventLabel: UILabel = UILabel()
        eventLabel.text = NSLocalizedString("DebtViewController.Label.Events" , comment: "")
        eventLabel.textAlignment = .left
        eventLabel.font = UIFont(name: "GTEestiProDisplay-Bold", size: 24)
        return eventLabel
    }()
    
    let paymentView = PaymentBadge()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectioView()
        setViews()
        setLayout()
        
        eventsCollectionView?.dataSource = self
        eventsCollectionView?.delegate =  self
    }
    
    func configureCollectioView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width, height: 70)
        
        eventsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        eventsCollectionView?.register(EventCell.self, forCellWithReuseIdentifier: "EventCell")
        eventsCollectionView?.backgroundColor = backgroundFillColor
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
        
        eventsCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            eventsCollectionView!.topAnchor.constraint(equalTo: eventLabel.bottomAnchor, constant: 8),
            eventsCollectionView!.widthAnchor.constraint(equalToConstant: view.frame.width),
            eventsCollectionView!.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            eventsCollectionView!.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
        
    }
    
    
    func setViews(){
        self.view.backgroundColor = backgroundFillColor
        
        self.view.addSubview(eventLabel)
        self.view.addSubview(paymentView)
        self.view.addSubview(eventsCollectionView!)
        
        eventLabel.textColor = labelColor
    }
}


extension DebtViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9 // TODO
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as? EventCell else {
            return UICollectionViewCell()
        }
        return eventCell // TODO
    }
}
