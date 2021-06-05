//
//  ViewController.swift
//  IntercorpChallenge
//
//  Created by David Diego Gomez on 04/06/2021.
//

import UIKit

class RegisterListViewController: UIViewController {
    var alert: DDAlert!
    @IBOutlet weak var tableview: UITableView!
    var viewModel: RegisterListViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 10
        tableview.register(RegisterTableViewCell.nib, forCellReuseIdentifier: RegisterTableViewCell.identifier)
        alert = DDAlert()
        viewModel = RegisterListViewModel(withView: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        viewModel.loadRegisters()
    }
    
    @IBAction func powerButtonPressed(_ sender: Any) {
        alert.DoubleButton(title: "Sign Out", body: "Are you sure to sign out?", leftButtonTitle: "Cancel", rightButtonTitle: "Sign Out") {}
            rightButtonCompletion: {
                AuthManager.shared.signOut()
            }
    }
    
    @IBAction func createNewRegisterButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewRegisterViewController") as! NewRegisterViewController
        navigationController?.show(viewController, sender: nil)
    }
}

extension RegisterListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RegisterTableViewCell.identifier) as? RegisterTableViewCell
        let item = viewModel.getItems()[indexPath.row]
        cell?.setup(register: item)
        return cell ?? UITableViewCell()
    }
}

extension RegisterListViewController: RegisterListViewProtocol {
    func showSuccess() {
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    
    func showError(_ message: String) {
        alert.SingleButton(title: "Error", body: message, buttonTitle: "Ok")
    }
}
