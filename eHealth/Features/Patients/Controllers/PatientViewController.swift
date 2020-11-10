//
//  ListViewController.swift
//  HBO
//
//  Created by George Mavroidis on 2020-10-14.


import Foundation
import UIKit

final class PatientViewController: UIViewController, PatientViewProtocol {
    
    public var viewModel: PatientViewModelProtocol
    private let tableView = UITableView()
    
    public init(viewModel: PatientViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.view = self
        self.title = "Patients";
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubviews()
        setupStyles()
        setupLayouts()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupStyles() {
        Style.for(UIView.self)
            .backgroundColor(.clear)
            .apply(on: view)
        
        Style.for(UITableView.self)
            .translatesAutoresizingMaskIntoConstraints(false)
            .register(PatientTableViewCell.self, forCellReuseIdentifier: PatientDataSource.cellIdentifierPatient)
            .separatorStyle(.none)
            .backgroundColor(.black)
            .apply(on: tableView)
        
        tableView.dataSource = viewModel.dataSource
        tableView.delegate = viewModel.dataSource
    }
    
    private func setupLayouts() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    public func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.reloadData()
    }
    
    func showAlert(_ message: String) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle:.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.navigationController?.present(alert, animated: true, completion: nil)
        }
    }
}
