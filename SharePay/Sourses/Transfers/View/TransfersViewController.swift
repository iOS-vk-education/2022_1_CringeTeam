//
//  TransfersViewController.swift
//  SharePay
//
//  Created by User on 18.04.2022.
//
import UIKit

protocol TransfersView: AnyObject{
    func onSuccesssTransfersLoad()
    func onFailedTransfersLoad()
}

final class TransfersViewController: UIViewController {
    
    var presenter: TransfersViewPresenter!
    
    let allView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "SecondaryFill")
        return view
    }()
    
    let mainTitle = UILabel(text: "TransfersViewController.Label.transfersTitle".localized(), color: "Label", size: 24)
    let tableView: UITableView = {
        let table = UITableView()
        table.register(TransfersTableViewCell.self, forCellReuseIdentifier: "TransferCell")
        table.backgroundColor = UIColor(named: "SecondaryFill")
        table.separatorStyle = .none
        return table
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        arrangeConstraints()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        presenter.refresh()
    }
    
    @objc
    private func didPullToRefresh() {
        presenter.refresh()
    }
    
    func arrangeConstraints() {
        
        view.addSubview(allView)
        allView.addSubview(mainTitle)
        allView.addSubview(tableView)
    
        [allView, mainTitle, tableView].forEach {$0.translatesAutoresizingMaskIntoConstraints = false}
        
        let allViewConstraints: [NSLayoutConstraint] = [
            allView.topAnchor.constraint(equalTo: view.topAnchor),
            allView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            allView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            allView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -47)
        ]
        NSLayoutConstraint.activate(allViewConstraints)

        let tableViewConstraints: [NSLayoutConstraint] = [
            tableView.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -47)
        ]
        NSLayoutConstraint.activate(tableViewConstraints)
        
        let mainTitleConstraints: [NSLayoutConstraint] = [
            mainTitle.topAnchor.constraint(equalTo: allView.topAnchor, constant: 52),
            mainTitle.centerXAnchor.constraint(equalTo: allView.centerXAnchor),
        ]
        NSLayoutConstraint.activate(mainTitleConstraints)
    }
}


extension TransfersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.listTransfers().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransferCell", for: indexPath)  as? TransfersTableViewCell else {
            return UITableViewCell()
        }
        if indexPath.row >= self.presenter.listTransfers().count{
            return UITableViewCell()
        }
        cell.setData(transfer: self.presenter.listTransfers()[indexPath.row])
        return cell
    }
}


extension TransfersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

extension TransfersViewController: TransfersView {
    func onFailedTransfersLoad() {
        let alertController = UIAlertController(title:  "Common.Error".localized(), message:"TransfersViewController.Message.FailedLoadTransfer".localized(), preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title:  "Common.Ok".localized(), style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func onSuccesssTransfersLoad() {
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
}
