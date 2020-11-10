//
//  ListModel.swift
//  HBO
//
//  Created by George Mavroidis on 2020-10-14.
//

import Foundation
import UIKit
import SMART

struct PatientModel: Hashable {
    let name: String?
    let gender: String?
    let birthday: String?
    
    init(_ patient: Patient){
        
        self.name = patient.humanName
        let birthday: String
        
        if let ns_birthday = patient.birthDate?.nsDate{
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, Y"
            birthday = formatter.string(from: ns_birthday)
        }else{
            birthday = "{No birthday information}"
        }
        self.birthday = birthday
        
        let gender: String
        if(patient.gender == nil){
            gender = "{No gender information}"
        }else{
            gender =  patient.gender!.rawValue
        }
        self.gender = gender
        
    }
}
