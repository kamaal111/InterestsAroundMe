//
//  DetailsCategoriesSection.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 30/12/2021.
//

import SwiftUI
import IAMNetworker

struct DetailsCategoriesSection: View {
    let categories: [IAMNPlaceCategory]

    var body: some View {
        HStack {
            Text("Categories")
                .bold()
                .padding(.trailing, 4)
            ForEach(categories) { category in
                Text("# \(category.name)")
                    .foregroundColor(.secondary)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.secondary, lineWidth: 1))
                    .padding(.trailing, 4)
            }
        }
    }
}

struct DetailsCategoriesSection_Previews: PreviewProvider {
    static var previews: some View {
        DetailsCategoriesSection(categories: [])
    }
}
