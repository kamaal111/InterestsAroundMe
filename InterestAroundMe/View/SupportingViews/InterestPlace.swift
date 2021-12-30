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
    let imageData: Data?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                if let categoryIconImage = self.categoryIconImage {
                    categoryIconImage
                        .size(.squared(40))
                } else {
                    Image(systemName: "photo")
                        .size(.squared(40))
                        .foregroundColor(.secondary)
                }
                VStack(alignment: .leading) {
                    Text(place.name)
                        .font(.headline)
                        .bold()
                        .foregroundColor(.primary)
                    Text(place.location.address)
                        .foregroundColor(.primary)
                    Text(place.location.dma)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
    }

    private var categoryIconImage: Image? {
        guard let imageData = self.imageData, let uiImage = UIImage(data: imageData) else { return nil }
        return Image(uiImage: uiImage)
    }
}

struct InterestPlace_Previews: PreviewProvider {
    static var previews: some View {
        InterestPlace(
            place: IAMNPlacesResult.preview.results.first!,
            imageData: UIImage(named: "hotel_bg_32")?.pngData(),
            action: { })
            .previewLayout(.sizeThatFits)
    }
}
