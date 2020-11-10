//
//  ListViewDataSource.swift
//  HBO
//
//  Created by George Mavroidis on 2020-10-14.
//

import Foundation
import UIKit
import SMART

// DataSource for the "Episodes" tableView and the "Favorites" tableView
public class PatientDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    static let cellIdentifierPatient = "PatientTableViewCell"
    var patientModels: [PatientModel] = []
    
    
    // Set model for show and for episodes (inherits from show)
    func setModel(_ models: [PatientModel]){
        
        self.patientModels = models
    }
    func getPatient(index: Int) -> PatientModel {
        return patientModels[index]
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientModels.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PatientDataSource.cellIdentifierPatient,
                                                       for: indexPath) as? PatientTableViewCell else {
            return UITableViewCell()
        }
        let model = getPatient(index: indexPath.row)
        cell.set(model)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model:  PatientModel
        model = patientModels[indexPath.row]
        
    }
    
   
}
