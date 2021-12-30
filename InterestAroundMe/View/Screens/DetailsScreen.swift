//
//  DetailsScreen.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 30/12/2021.
//

import SwiftUI
import IAMNetworker
import PopperUp
import SalmonUI

struct DetailsScreen: View {
    @EnvironmentObject
    private var popperUpManager: PopperUpManager
    @EnvironmentObject
    private var stackNavigator: StackNavigator

    @StateObject private var viewModel = ViewModel()

    let preview: Bool

    init(preview: Bool = false) {
        self.preview = preview
    }

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.photos, id: \.self) { photo in
                        Image(uiImage: UIImage(data: photo)!)
                            .cornerRadius(16)
                    }
                }
            }
            if let categories = viewModel.place?.categories, !categories.isEmpty {
                DetailsCategoriesSection(categories: categories)
                    .padding(.top, 8)
                    .padding(.leading, 4)
            }
            VStack(alignment: .leading) {
                
            }
            .padding(.vertical, 8)
        }
        .padding(.horizontal, 8)
        .padding(.top, 16)
        .ktakeSizeEagerly(alignment: .topLeading)
        .navigationTitle(Text(viewModel.place?.name ?? "Details"))
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: viewModel.error, perform: { newValue in
            guard let error = newValue else {
                popperUpManager.hidePopup()
                return
            }
            popperUpManager.showPopup(
                ofType: .error,
                title: "Sorry",
                description: error.errorDescription,
                timeout: 3)
        })
        .onAppear(perform: {
            viewModel.setPreview(preview)
            guard let place = stackNavigator.currentOptions?["place"] as? IAMNPlace else { return }
            print(place)
            viewModel.setPlace(place)
        })
    }
}

struct DetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailsScreen(preview: true)
            .environmentObject(StackNavigator())
    }
}
