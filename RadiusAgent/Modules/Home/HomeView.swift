//
//  HomeView.swift
//  RadiusAgent
//
//  Created by Sidharth J Dev on 29/06/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeVM: HomeViewModel
    @State private var refreshTrigger = false
    
    
    @State var currentExclusions: [Exclusion] = []
    @State var selectedExclusions: [Exclusion] = []
    
    init() {
        homeVM = HomeViewModel()
        homeVM.fetchProperties()
    }
    
    var body: some View {
        List {
            ForEach(homeVM.facilities.indices, id: \.self) { facilityIndex in
                let facility = homeVM.facilities[facilityIndex]
                Section(header: Text(facility.name)) {
                    ForEach(facility.options.indices, id: \.self) { optionIndex in
                        let option = facility.options[optionIndex]
                        let exclusion = Exclusion(facilityID: facility.facilityID, optionsID: option.id)
                        HStack {
                            Image(option.icon)
                                .padding(4)
                            Text(option.name)
                                .foregroundColor(isItemExcluded(exclusion) ? .red : .black)
                            Spacer()
                            if option.selected {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .frame(height: 50)
                        .opacity(isItemExcluded(exclusion) ? 0.2 : 1.0)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if !isItemExcluded(exclusion) {
                                homeVM.facilities[facilityIndex].options[optionIndex].selected.toggle()
                                let selectedExclusion = Exclusion(facilityID: facility.facilityID, optionsID: option.id)
                                if selectedExclusions.contains(selectedExclusion) {
                                    selectedExclusions.removeAll {  $0 == selectedExclusion }
                                } else {
                                    selectedExclusions.append(selectedExclusion)
                                }
                                updateExclusions()
                                refreshTrigger.toggle()
                            }
                            
                        }
                    }
                }
            }
        }
        .listStyle(.grouped)
        .id(refreshTrigger)
    }
    
    private func isItemExcluded(_ item: Exclusion) -> Bool {
        if currentExclusions.contains(item) {
            return true
        }
        return false
    }
    
    private func updateExclusions() {
        currentExclusions = []
        selectedExclusions.forEach { exclusion in
            if let excludedList = homeVM.exclusionMap[exclusion] {
                currentExclusions.append(contentsOf: excludedList)
            }
        }
    }
  
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
