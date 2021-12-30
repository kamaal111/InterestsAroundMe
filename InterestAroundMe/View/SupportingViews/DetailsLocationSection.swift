//
//  DetailsLocationSection.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 30/12/2021.
//

import SwiftUI
import IAMNetworker

struct DetailsLocationSection: View {
    let location: IAMNLocation

    var body: some View {
        VStack(alignment: .leading) {
            Text("Location")
                .font(.title3)
                .bold()
            if let address = location.address {
                Text("Address: \(address)")
            }
            if let city = location.locality {
                Text("City: \(city)")
            }
            if let neighborhood = location.neighborhood, !neighborhood.isEmpty {
                Text("Neighborhood: \(neighborhood.commaSperated)")
            }
            if let region = location.region {
                Text("Region: \(region)")
            }
        }
    }
}

// struct DetailsLocationSection_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsLocationSection()
//    }
// }
