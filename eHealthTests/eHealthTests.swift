//
//  eHealthTests.swift
//  eHealthTests
//
//  Created by George Mavroidis on 2020-11-09.
//

import XCTest
import SMART
@testable import eHealth

class eHealthTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func test_patientToPatientModel() throws{
        let patients  = SMARTAPI.fetchPatients { (patients, error) in
            if let patients = patients{
                let patient = PatientModel(patients[0])
                XCTAssertNotNil(patient.birthday)
                XCTAssertNotNil(patient.name)
                XCTAssertNotNil(patient.gender)
            }
        }
    }
    
}
