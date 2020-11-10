//
//  PatientAPI.swift
//  eHealth
//
//  Created by George Mavroidis on 2020-11-10.
//

import Foundation
import SMART

class SMARTAPI{
    // Fetch the all patients using the SMART Client
    static func fetchPatients(finished: @escaping ([Patient]?, String?) -> ()){
        // Setup the client
        let smart = Client(
            baseURL: URL(string: "http://hapi.fhir.org/baseR4")!,
            settings: [
                //"client_id": "my_mobile_app",       // if you have one
                "redirect": "smartapp://callback",    // must be registered
            ]
        )
        // Search for all patients (The reuquest will return 20 in a bundle)
        Patient.search([])
            .perform(smart.server) { bundle, error in
                if nil != error {
                    // There was an error - return the message
                    finished(nil, error?.localizedDescription)
                }
                else {
                    // Map the request to Patient items
                    let patients = bundle?.entry?
                        .filter() { return $0.resource is Patient }
                        .map() { return $0.resource as! Patient }
                    
                    // Return the first 10 (as per the instructions)
                    let first10 = Array(patients!.prefix(10))
                    finished(first10, nil)
                    
                    
                }
            }
    }

}
