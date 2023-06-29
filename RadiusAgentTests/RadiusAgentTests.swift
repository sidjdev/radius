//
//  RadiusAgentTests.swift
//  RadiusAgentTests
//
//  Created by Sidharth J Dev on 28/06/23.
//

import XCTest

@testable import RadiusAgent

final class RadiusAgentTests: XCTestCase {
    
    func testExclusionEquality() {
        let exclusion1 = Exclusion(facilityID: "A", optionsID: "X")
        let exclusion2 = Exclusion(facilityID: "B", optionsID: "Y")
        let exclusion3 = Exclusion(facilityID: "A", optionsID: "X")
        let exclusion4 = Exclusion(facilityID: "C", optionsID: "Z")
        
        XCTAssertEqual(exclusion1, exclusion3)
        XCTAssertNotEqual(exclusion1, exclusion2)
        XCTAssertNotEqual(exclusion1, exclusion4)
    }
    
    func testExclusionCoding() throws {
        let exclusion = Exclusion(facilityID: "A", optionsID: "X")
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(exclusion)
        
        let decoder = JSONDecoder()
        let decodedExclusion = try decoder.decode(Exclusion.self, from: data)
        
        XCTAssertEqual(exclusion, decodedExclusion)
    }
    
    func testIsSelectable() {
        let exclusion1 = Exclusion(facilityID: "A", optionsID: "X")
        let exclusion2 = Exclusion(facilityID: "A", optionsID: "X")
        let exclusion3 = Exclusion(facilityID: "B", optionsID: "Y")
        
        let vm = HomeViewModel()
        XCTAssertFalse(vm.isSelectable(itemOne: exclusion1, itemTwo: exclusion2))
        XCTAssertTrue(vm.isSelectable(itemOne: exclusion1, itemTwo: exclusion3))
    }
    
}


