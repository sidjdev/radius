//
//  HomeView.swift
//  RadiusAgent
//
//  Created by Sidharth J Dev on 29/06/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeVM: HomeViewModel
    
    init() {
        homeVM = HomeViewModel()
        homeVM.fetchProperties()
    }
    
    var body: some View {
        List {
            ForEach(homeVM.facilities, id: \.facilityID) { facility in
                Section(header: Text(facility.name)) {
                    ForEach(facility.options, id: \.id) { option in
                        Text(option.name)
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
