//
//  DebtViewController.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 21.04.2022.
//

import Foundation

import UIKit

protocol DebtView: AnyObject{
    func onCalculateTotalAmount(amount: Int, currency: String)
    func onLoadEvents()
}

final class DebtViewController: UIViewController{
    
    var presenter: DebtViewPresenter!
    
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
        self.hideKeyboardWhenTappedAround() 
        
        configureCollectioView()
        setViews()
        setLayout()
        
        eventsCollectionView?.dataSource = self
        eventsCollectionView?.delegate =  self
        
        presenter.loadData()
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
            paymentView.heightAnchor.constraint(equalToConstant: view.frame.height/5),
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
        
        paymentView.setActions(payCompletion: { [weak self] (amount)->Void in
            let payAlert = UIAlertController(title: NSLocalizedString("DebtViewController.Alert.Payment" , comment: ""), message: NSLocalizedString("DebtViewController.Alert.PayAcception" , comment: ""), preferredStyle: UIAlertController.Style.alert)

            payAlert.addAction(UIAlertAction(title: NSLocalizedString("Common.Ok" , comment: ""), style: .default, handler: { (action: UIAlertAction!) in
                self?.presenter.pay(amount: amount)
              }))

            payAlert.addAction(UIAlertAction(title: NSLocalizedString("Common.Cancel" , comment: ""), style: .cancel, handler: { (action: UIAlertAction!) in
              // NOP
              }))
            DispatchQueue.main.async{
                self?.present(payAlert, animated: true, completion: nil)
            }
        }, notifyCompletion: { [weak self] ()->Void in
            self?.presenter.notifyDebtor()
        })
    }
}


extension DebtViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.listEvents().count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as? EventCell else {
            return UICollectionViewCell()
        }
        eventCell.setData(event: presenter.listEvents()[indexPath.row])
        return eventCell
    }
}

extension DebtViewController: DebtView{
    
    func onCalculateTotalAmount(amount: Int, currency: String){
        paymentView.setAmount(amount: amount, currrency: currency)
    }
    
    func onLoadEvents() {
        self.eventsCollectionView?.reloadData()
    }
}
