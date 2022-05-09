//
// Created by Pudovkin Dmitriy Olegovich on 08.04.2022.
//

import Foundation
import UIKit
import EmojiPicker
import ContactsUI


protocol PurchaseView: AnyObject {
    func onUnableAddPurchaseParticipant()
    func onUpdatePurchaseParticipants()
    func onFailSavePurchase()
    func onFailGetPurchase()
    func onUpdatePurchase()
    func onInvalidPurchase() // Unable to save
}


final class PurchaseViewController: UIViewController, UICollectionViewDelegate{
    
    // Ссылка на presenter
    var presenter: PurchaseViewPresenter!

    // Инициализация цветов
    let blueColor: UIColor? = UIColor(named: "BlueAccentColor")
    let labelColor: UIColor? = UIColor(named: "Label")
    let magentaColor: UIColor? = UIColor(named: "MagentaAccentColor")
    let greenColor: UIColor? = UIColor(named:"GreenAccentColor")
    let secondaryLabelColor: UIColor? = UIColor(named: "SecondaryLabel")
    let backgroundFillColor: UIColor? = UIColor(named: "Fill")
    let secondaryFillColor: UIColor? = UIColor(named: "SecondaryFill")
    let weakAccentColor: UIColor? = UIColor(named: "WeakAccentColor")

    var participantCollectionView: UICollectionView?
    let emojiPickerVC = EmojiPicker.viewController

    let namePurchaseLabel: UILabel = {
        let namePurchaseLabel: UILabel = UILabel()
        namePurchaseLabel.text = NSLocalizedString("PurchaseViewController.Label.NamePurchase", comment: "")
        namePurchaseLabel.textAlignment = .left
        namePurchaseLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 16)
        return namePurchaseLabel
    }()

    let totalLabel: UILabel = {
        let totalPurchaseLabel: UILabel = UILabel()
        totalPurchaseLabel.text = NSLocalizedString("PurchaseViewController.Label.TotalPurchase", comment: "")
        totalPurchaseLabel.textAlignment = .left
        totalPurchaseLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 16)
        return totalPurchaseLabel
    }()

    let iconLabel: UILabel = {
        let iconLabel: UILabel = UILabel()
        iconLabel.text = NSLocalizedString("PurchaseViewController.Label.Icon", comment: "")
        iconLabel.textAlignment = .center
        iconLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 16)
        return iconLabel
    }()
    
    let emojiSelectLabel: UILabel = {
        let emojiSelectLabel: UILabel = UILabel()
        emojiSelectLabel.text = "✈️"
        emojiSelectLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 20)
        emojiSelectLabel.textAlignment = .center
        emojiSelectLabel.layer.cornerRadius = 20
        emojiSelectLabel.layer.borderWidth = 1.0
        emojiSelectLabel.layer.masksToBounds = true
        return emojiSelectLabel
    }()
    
    let nameTextField: UITextField = {
        let nameTextField: UITextField = UITextField(cornerRadius: 20)
        nameTextField.font = UIFont(name: "GTEestiProDisplay-Medium", size: 18)
        return nameTextField
    }()
    
    let totalTextField: UITextField = {
        let totalTextField: UITextField = UITextField(cornerRadius: 20)
        totalTextField.font = UIFont(name: "GTEestiProDisplay-Medium", size: 18)
        totalTextField.keyboardType = .numberPad
        return totalTextField
    }()
    
    let participantLabel: UILabel = {
        let participantLabel: UILabel = UILabel()
        participantLabel.text = NSLocalizedString("PurchaseViewController.Label.Participant", comment: "")
        participantLabel.textAlignment = .left
        participantLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 16)
        return participantLabel
    }()
    
    let addParticipantButton: UIButton = {
        let addParticipantButton: UIButton = UIButton()
        addParticipantButton.setTitle(NSLocalizedString("PurchaseViewController.Button.AddParticipant", comment: ""), for: .normal)
        addParticipantButton.layer.cornerRadius = 20
        addParticipantButton.titleLabel?.font = UIFont(name: "GTEestiProDisplay-Medium", size: 16)
        return addParticipantButton
    }()
    
    let equalSplitButton: UIButton = {
        let equalSplitButton: UIButton = UIButton()
        equalSplitButton.setTitle(NSLocalizedString("PurchaseViewController.Button.EqualSplit", comment: ""), for: .normal)
        equalSplitButton.layer.cornerRadius = 20
        equalSplitButton.titleLabel?.font = UIFont(name: "GTEestiProDisplay-Medium", size: 16)
        return equalSplitButton
    }()
    
    let saveButton: UIButton = {
        let saveButton: UIButton = UIButton()
        saveButton.setTitle(NSLocalizedString("PurchaseViewController.Button.Save", comment: ""), for: .normal)
        saveButton.layer.cornerRadius = 25
        saveButton.titleLabel?.font = UIFont(name: "GTEestiProDisplay-Medium", size: 16)
        return saveButton
    }()
    
    let infoTextLabel: UILabel = {
        let textLabel: UILabel = UILabel()
        textLabel.text = NSLocalizedString("PurchaseViewController.Label.InfoText", comment: "")
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 2
        textLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 14)
        return textLabel
    }()
    
    let datePurchaseLabel: UILabel = {
        let datePurchaseLabel: UILabel = UILabel()
        datePurchaseLabel.text = NSLocalizedString("PurchaseViewController.Label.DatePurchase", comment: "")
        datePurchaseLabel.textAlignment = .left
        datePurchaseLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 14)
        return datePurchaseLabel
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    let applyBillLabel: UILabel = {
        let applyBillLabel: UILabel = UILabel()
        applyBillLabel.text = NSLocalizedString("PurchaseViewController.Label.ApplyBill", comment: "")
        applyBillLabel.numberOfLines = 2
        applyBillLabel.textAlignment = .left
        applyBillLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 14)
        return applyBillLabel
    }()
    
    let billSwitch: UISwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayoutCollectionView()
        setView()
        setLayout()
        
        participantCollectionView?.dataSource = self
        participantCollectionView?.delegate = self
        
        //Выбор эмоджи
        let tap = UITapGestureRecognizer(target: self, action: #selector(PurchaseViewController.selectEmoji))
        emojiSelectLabel.isUserInteractionEnabled = true
        emojiSelectLabel.addGestureRecognizer(tap)
        
        // Добавление нового участника
        addParticipantButton.addTarget(self, action:#selector(PurchaseViewController.addParticipant),  for: .touchUpInside)
        
        // Разбиение покупки поровну
        equalSplitButton.addTarget(self, action: #selector(PurchaseViewController.splitEqual), for:.touchUpInside)
        
        // Сохранение покупки
        saveButton.addAction{ [weak self] in
            self?.presenter.savePurchase()
        }
        
        // Обновление данных о покупке
        nameTextField.addTarget(self, action: #selector(PurchaseViewController.updatePurchase), for: .editingChanged)
        totalTextField.addTarget(self, action: #selector(PurchaseViewController.updatePurchase), for: .editingChanged)
        billSwitch.addTarget(self, action: #selector(PurchaseViewController.updatePurchase), for: .valueChanged)
        datePicker.addTarget(self, action: #selector(PurchaseViewController.updatePurchase), for: .valueChanged)
        
        // Сообщем презентеру что мы готовы
        presenter.ready()
    }
    
    @objc func updatePurchase(){
        presenter.updatePurchase(name: nameTextField.text ?? "",
                                 amount: Int(totalTextField.text ?? "") ?? 0,
                                 emoji: emojiSelectLabel.text ?? "",
                                 draft: !billSwitch.isOn,
                                 created_at: datePicker.date)
    }
    
    @objc func selectEmoji(sender:UITapGestureRecognizer) {
        present(emojiPickerVC, animated: true, completion: nil)
        print("click")
    }
    
    @objc func addParticipant(){
        let contactPickerVC = CNContactPickerViewController()
        contactPickerVC.delegate = self
        present(contactPickerVC, animated: true)
    }
    
    @objc func splitEqual(){
        presenter.splitEqualPurchase()
    }
    
    func configureLayoutCollectionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width, height: 50)
        
        participantCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        participantCollectionView?.register(ParticipantCell.self, forCellWithReuseIdentifier: "ParticipantCell")
        participantCollectionView?.backgroundColor = backgroundFillColor
    }

    func setLayout(){
        
        let rootView = view!
        let contentWidth = rootView.frame.width
        
        // Row #1
        namePurchaseLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            namePurchaseLabel.widthAnchor.constraint(equalToConstant: contentWidth*0.7),
            namePurchaseLabel.heightAnchor.constraint(equalToConstant: 24),
            namePurchaseLabel.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: 12),
            namePurchaseLabel.topAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.topAnchor, constant: 8)
        ])
        
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconLabel.widthAnchor.constraint(equalToConstant: 60),
            iconLabel.heightAnchor.constraint(equalToConstant: 24),
            iconLabel.leftAnchor.constraint(equalTo: namePurchaseLabel.rightAnchor, constant: 4),
            iconLabel.topAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.topAnchor, constant: 8)
        ])
        
        // Row #2
        nameTextField.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            nameTextField.widthAnchor.constraint(equalToConstant: contentWidth*0.7),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            nameTextField.leftAnchor.constraint(equalTo:  rootView.leftAnchor, constant: 12),
            nameTextField.topAnchor.constraint(equalTo: namePurchaseLabel.bottomAnchor, constant: 4)
        ])
        
        emojiSelectLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emojiSelectLabel.widthAnchor.constraint(equalToConstant: 40),
            emojiSelectLabel.heightAnchor.constraint(equalToConstant: 40),
            emojiSelectLabel.leftAnchor.constraint(equalTo: namePurchaseLabel.rightAnchor, constant: 16),
            emojiSelectLabel.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 4)
        ])
        
        // Row #3
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalLabel.widthAnchor.constraint(equalToConstant: contentWidth*0.7),
            totalLabel.heightAnchor.constraint(equalToConstant: 24),
            totalLabel.leftAnchor.constraint(equalTo:  rootView.leftAnchor, constant: 12),
            totalLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8)
        ])
    
        // Row #4
        totalTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalTextField.widthAnchor.constraint(equalToConstant: contentWidth*0.7),
            totalTextField.heightAnchor.constraint(equalToConstant: 40),
            totalTextField.leftAnchor.constraint(equalTo:  rootView.leftAnchor, constant: 12),
            totalTextField.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 4)
        ])
        
        // Row #5
        participantLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            participantLabel.widthAnchor.constraint(equalToConstant: contentWidth*0.7),
            participantLabel.heightAnchor.constraint(equalToConstant: 24),
            participantLabel.leftAnchor.constraint(equalTo:  rootView.leftAnchor, constant: 12),
            participantLabel.topAnchor.constraint(equalTo: totalTextField.bottomAnchor, constant: 8)
        ])
        
        // Row #6
        participantCollectionView?.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            participantCollectionView!.topAnchor.constraint(equalTo:  participantLabel.bottomAnchor, constant: 4),
            participantCollectionView!.widthAnchor.constraint(equalToConstant: view.frame.width),
            participantCollectionView!.heightAnchor.constraint(equalToConstant: view.frame.height/4),
            participantCollectionView!.leftAnchor.constraint(equalTo: rootView.leftAnchor)
           ])
        
        
        // Row #6
        addParticipantButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addParticipantButton.topAnchor.constraint(equalTo: participantCollectionView!.bottomAnchor,constant: 16),
            addParticipantButton.widthAnchor.constraint(equalToConstant: rootView.frame.width/3),
            addParticipantButton.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: 12),
            addParticipantButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        equalSplitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            equalSplitButton.topAnchor.constraint(equalTo: participantCollectionView!.bottomAnchor,constant: 16),
            equalSplitButton.widthAnchor.constraint(equalToConstant: rootView.frame.width/4),
            equalSplitButton.rightAnchor.constraint(equalTo: rootView.rightAnchor, constant: -48),
            equalSplitButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        // Row #7
        datePurchaseLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePurchaseLabel.widthAnchor.constraint(equalToConstant: contentWidth*0.7),
            datePurchaseLabel.heightAnchor.constraint(equalToConstant: 24),
            datePurchaseLabel.leftAnchor.constraint(equalTo:  rootView.leftAnchor, constant: 12),
            datePurchaseLabel.topAnchor.constraint(equalTo: addParticipantButton.bottomAnchor, constant: 8)
        ])
        
        // Row #8
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.heightAnchor.constraint(equalToConstant: 40),
            datePicker.leftAnchor.constraint(equalTo:  rootView.leftAnchor, constant: 12),
            datePicker.topAnchor.constraint(equalTo: datePurchaseLabel.bottomAnchor, constant: 4)
        ])
        
        // Row #9
        applyBillLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            applyBillLabel.widthAnchor.constraint(lessThanOrEqualToConstant: rootView.frame.width*0.8),
            applyBillLabel.heightAnchor.constraint(equalToConstant: 32),
            applyBillLabel.leftAnchor.constraint(equalTo:  rootView.leftAnchor, constant: 12),
            applyBillLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 4)
        ])
        
        billSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            billSwitch.rightAnchor.constraint(equalTo:  rootView.rightAnchor, constant: -12),
            billSwitch.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 4)
            ])
        
        // # Bottom
        infoTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoTextLabel.widthAnchor.constraint(equalToConstant: rootView.frame.width/1.2),
            infoTextLabel.heightAnchor.constraint(equalToConstant: 40),
            infoTextLabel.centerXAnchor.constraint(equalTo: rootView.centerXAnchor),
            infoTextLabel.bottomAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.widthAnchor.constraint(equalToConstant: view.frame.width/2),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: infoTextLabel.topAnchor, constant: -8)
        ])
    }

    func setView(){
        self.view.backgroundColor = backgroundFillColor
    
        [emojiSelectLabel,
         iconLabel,
         totalLabel,
         namePurchaseLabel,
         nameTextField,
         totalTextField,
         addParticipantButton,
         equalSplitButton,
         participantLabel,
         saveButton,
         infoTextLabel,
         datePurchaseLabel,
         datePicker,
         applyBillLabel,
         billSwitch,
         participantCollectionView!].forEach{view.addSubview($0)}

        // Установка цвета для label
        iconLabel.textColor = labelColor
        totalLabel.textColor = labelColor
        namePurchaseLabel.textColor = labelColor
        emojiSelectLabel.textColor = labelColor
        datePurchaseLabel.textColor = labelColor
        applyBillLabel.textColor = labelColor
        
        // Установка цвета для secondaryLabel
        infoTextLabel.textColor = secondaryLabelColor
        
        // Установка цвета для textField
        nameTextField.textColor = labelColor
        totalTextField.textColor = labelColor
        
        // Установка цветов для кнопок
        addParticipantButton.backgroundColor = greenColor
        equalSplitButton.backgroundColor = blueColor
        saveButton.backgroundColor = blueColor
        
        emojiSelectLabel.backgroundColor = secondaryFillColor
        emojiSelectLabel.layer.borderColor = weakAccentColor?.cgColor
        
        emojiPickerVC.delegate = self
        emojiPickerVC.size = CGSize(width: 300, height: 400)
        emojiPickerVC.dismissAfterSelected = true
    }
}

extension PurchaseViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.listParticipants().count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let participantCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ParticipantCell", for: indexPath) as? ParticipantCell else {
            return UICollectionViewCell()
        }
        let item = self.presenter.listParticipants()[indexPath.row]
        participantCell.setData(name: item.name, amount: item.amount)
        participantCell.setDeleteAction {
            self.presenter.deletePurchaseParticipant(phoneNumber: item.phoneNumber)
        }
        participantCell.setEditAction{ (amount: String) -> Void in
            let amountNum: Int? = Int(amount)
            self.presenter.setPurchaseParticapantAmount(phoneNumber: item.phoneNumber, amount: amountNum ?? 0)
        }
        return participantCell
    }
}

// Выбор иконки эмоджи
extension PurchaseViewController: EmojiPickerViewControllerDelegate{
    func emojiPickerViewController(_ controller: EmojiPickerViewController, didSelect emoji: String) {
        emojiSelectLabel.text = emoji
        updatePurchase()
    }
}

// Выбор иконки контакта
extension PurchaseViewController: CNContactPickerDelegate{
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        self.presenter.addPurchaseParticipant(name: "\(contact.familyName) \(contact.givenName)", phoneNumber: contact.phoneNumbers[0].value.stringValue)
    }
}

// Реализация view протокола
extension PurchaseViewController: PurchaseView{
    
    func onUnableAddPurchaseParticipant() {
        DispatchQueue.main.async{
            let alertController = UIAlertController(title:  NSLocalizedString("Common.Error", comment: ""), message:
            NSLocalizedString("PurchaseViewController.Message.UnableToAddParticipant", comment: ""), preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title:  NSLocalizedString("Common.Ok", comment: ""), style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func onFailSavePurchase(){
        DispatchQueue.main.async{
            let alertController = UIAlertController(title:  NSLocalizedString("Common.Error", comment: ""), message:
            NSLocalizedString("PurchaseViewController.Message.UnableToSavePurchase", comment: ""), preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title:  NSLocalizedString("Common.Ok", comment: ""), style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func onUpdatePurchaseParticipants() {
        self.participantCollectionView?.reloadData()
    }
    
    func onUpdatePurchase() {
        let purchase: Purchase = presenter.getPurchase()
        DispatchQueue.main.async{ [weak self] in
            self?.nameTextField.text = purchase.name
            self?.emojiSelectLabel.text = purchase.emoji
            self?.totalTextField.text =  String(purchase.amount)
            self?.datePicker.setDate(purchase.created_at, animated: true)
            self?.billSwitch.setOn(!purchase.draft, animated: true)
            
            // TODO Исправить
            // Некорректное поведение при выставлении флага для уже созданной покупки перед сохранением
            if !purchase.draft && purchase.id != 0 {
                // Когда счет выставлены необходимо отключить возможности редактирования
                self?.nameTextField.isEnabled =  false
                self?.emojiSelectLabel.isEnabled = false
                self?.totalTextField.isEnabled = false
                self?.saveButton.isEnabled = false
                self?.addParticipantButton.isEnabled = false
                self?.datePicker.isEnabled = false
                self?.saveButton.setTitle(NSLocalizedString("Common.Ok", comment: ""), for: .normal)
                self?.infoTextLabel.text = NSLocalizedString("PurchaseViewController.Label.InfoTextNotEdit", comment: "")
                self?.billSwitch.isEnabled = false
                return
            }
            
            // В режиме черновика доступна возможность редактирования
            self?.nameTextField.isEnabled =  true
            self?.emojiSelectLabel.isEnabled = true
            self?.totalTextField.isEnabled = true
            self?.saveButton.isEnabled = true
            self?.addParticipantButton.isEnabled = true
            self?.datePicker.isEnabled = true
            self?.saveButton.setTitle(NSLocalizedString("PurchaseViewController.Button.Save", comment: ""), for: .normal)
            self?.infoTextLabel.text = NSLocalizedString("PurchaseViewController.Label.InfoText", comment: "")
            self?.billSwitch.isEnabled = true
        }
    }
    
    func onFailGetPurchase(){
        DispatchQueue.main.async{
            let alertController = UIAlertController(title:  NSLocalizedString("Common.Error", comment: ""), message:
            NSLocalizedString("PurchaseViewController.Message.UnableToGetPurchase", comment: ""), preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title:  NSLocalizedString("Common.Ok", comment: ""), style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func onInvalidPurchase() {
        DispatchQueue.main.async{
            let alertController = UIAlertController(title:  NSLocalizedString("Common.Error", comment: ""), message:
            NSLocalizedString("PurchaseViewController.Message.OnInvalidPurchase", comment: ""), preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title:  NSLocalizedString("Common.Ok", comment: ""), style: .default))
            self.present(alertController, animated: true, completion: nil) // TODO
        }
    }
    
}
