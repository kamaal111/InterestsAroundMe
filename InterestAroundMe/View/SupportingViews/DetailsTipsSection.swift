//
//  DetailsTipsSection.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 30/12/2021.
//

import SwiftUI
import IAMNetworker

struct DetailsTipsSection: View {
    let tips: [IAMNPlaceTip]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Tips")
                .font(.title3)
                .bold()
            ForEach(tips.enumerated().map(\.offset), id: \.self) { index in
                HStack(alignment: .top) {
                    Text("\(index + 1).")
                        .padding(.trailing, 2)
                    Text("\(tips[index].text)")
                }
            }
        }
    }
}

struct DetailsTipsSection_Previews: PreviewProvider {
    static var previews: some View {
        DetailsTipsSection(tips: [])
    }
}
