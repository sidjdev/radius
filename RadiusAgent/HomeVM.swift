//
//  HomeVM.swift
//  RadiusAgent
//
//  Created by Sidharth J Dev on 29/06/23.
//

import Foundation



class HomeViewModel: ObservableObject {
    
    @Published var facilities: [Facility] = []
    @Published var exclusions: [[Exclusion]] = []
    
    func fetchProperties() {
        NetworkManager.shared.fetchData(from: .facilityData, dataType: FacilityData.self) { [self] result in
            switch result {
            case .success(let facilityData):
                facilities = facilityData.facilities
                exclusions = facilityData.exclusions
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
