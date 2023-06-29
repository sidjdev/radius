//
//  Facility.swift
//  RadiusAgent
//
//  Created by Sidharth J Dev on 28/06/23.
//

import Foundation

class Facility: Codable {
    let facilityID: String
    let name: String
    var options: [FacilityOption]
    
    private enum CodingKeys: String, CodingKey {
        case facilityID = "facility_id"
        case name, options
    }
}

class FacilityOption: Codable {
    let name: String
    let icon: String
    let id: String
    var selected: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case name, icon, id
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        icon = try container.decode(String.self, forKey: .icon)
        id = try container.decode(String.self, forKey: .id)
        selected = false
    }
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
