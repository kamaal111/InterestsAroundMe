//
//  DetailsPhotosSection.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 30/12/2021.
//

import SwiftUI

struct DetailsPhotosSection: View {
    let photos: [Data]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(photos, id: \.self) { photo in
                    Image(uiImage: UIImage(data: photo)!)
                        .cornerRadius(16)
                }
            }
        }
    }
}

struct DetailsPhotosSection_Previews: PreviewProvider {
    static var previews: some View {
        DetailsPhotosSection(photos: [])
    }
}
