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
                        HStack {
                            Text(facility.options[optionIndex].name)
                            Spacer()
                            if facility.options[optionIndex].selected {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            homeVM.facilities[facilityIndex].options[optionIndex].selected.toggle()
                            refreshTrigger.toggle()
//                            facility.options[optionIndex].selected.toggle()
                        }
                    }
                }
            }
        }
        .listStyle(.grouped)
        .id(refreshTrigger)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
