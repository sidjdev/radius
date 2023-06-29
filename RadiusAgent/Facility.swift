//
//  Facility.swift
//  RadiusAgent
//
//  Created by Sidharth J Dev on 28/06/23.
//

import Foundation

struct Facility: Codable {
    let facilityID: String
    let name: String
    let options: [FacilityOption]
    
    private enum CodingKeys: String, CodingKey {
        case facilityID = "facility_id"
        case name, options
    }
}

struct FacilityOption: Codable {
    let name: String
    let icon: String
    let id: String
}

struct Exclusion: Codable {
    let facilityID: String
    let optionsID: String
    
    private enum CodingKeys: String, CodingKey {
        case facilityID = "facility_id"
        case optionsID = "options_id"
    }
}

struct FacilityData: Codable {
    let facilities: [Facility]
    let exclusions: [[Exclusion]]
}
