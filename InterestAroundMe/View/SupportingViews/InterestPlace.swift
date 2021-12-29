//
//  InterestPlace.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 29/12/2021.
//

import SwiftUI
import SalmonUI
import IAMNetworker
import ShrimpExtensions

struct InterestPlace: View {
    let place: IAMNPlace
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "photo")
                    .size(.squared(40))
                VStack(alignment: .leading) {
                    Text(place.name)
                        .font(.headline)
                        .bold()
                    Text(place.location.address)
                    Text(place.location.dma)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct InterestPlace_Previews: PreviewProvider {
    static var previews: some View {
        InterestPlace(place: IAMNPlacesResult.preview.results.first!, action: { })
            .previewLayout(.sizeThatFits)
    }
}
