//
//  EpisodeViewModel.swift
//  HBO
//
//  Created by George Mavroidis on 2020-10-14.
//

import Foundation
import UIKit

protocol PatientViewModelProtocol: class {
    var view: PatientViewProtocol? { get set }
    var dataSource: PatientDataSource { get }
    func reloadData()
}
protocol PatientViewProtocol: UIViewController {
    var viewModel: PatientViewModelProtocol { get }
    func reloadData()
    func showAlert(_ message: String)
}

final class PatientViewModel: PatientViewModelProtocol {
    
    var dataSource = PatientDataSource()
    
    var view: PatientViewProtocol?
    
    init() {
        
        SMARTAPI.fetchPatients { patients, error in
            
            if let error = error{
                self.view?.showAlert(error)
            }
            guard let patients = patients else {
                self.view?.showAlert("There was a problem fetching the data.")
                return
            }
            // Map the returned Patient objects to the PatientModels for the TableView
            let models = patients.map { (patient) -> PatientModel in
                let model = PatientModel(patient)
                return model
            }
            
            self.dataSource.setModel(models) // Set the datasource
            self.reloadData()
            
        }
    }
    
    func reloadData(){
        self.view?.reloadData()
    }
}
