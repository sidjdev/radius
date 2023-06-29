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
    
    var allExclusions: [Exclusion] = []
    
    var exclusionMap: [Exclusion : [Exclusion]] = [:]
    
    func fetchProperties() {
        NetworkManager.shared.fetchData(from: .facilityData, dataType: FacilityData.self) { [self] result in
            switch result {
            case .success(let facilityData):
                DispatchQueue.main.async { [self] in
                    facilities = facilityData.facilities
                    exclusions = facilityData.exclusions
                    allExclusions = exclusions.flatMap { $0 }
            
                    mapExclusions()
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func isSelectable(itemOne: Exclusion, itemTwo: Exclusion) -> Bool {
        return !(itemOne == itemTwo)
    }
    
    private func mapExclusions() {
        exclusionMap = exclusions.reduce(into: [Exclusion : [Exclusion]]()) { partialResult, pair in
            guard let key = pair.first, let value = pair.last else { return }
            
            partialResult[key, default: []].append(value)
            partialResult[value, default: []].append(key)
        }
    }
}
