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
import os.log

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
            if !viewModel.photos.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.photos, id: \.self) { photo in
                            Image(uiImage: UIImage(data: photo)!)
                                .cornerRadius(16)
                        }
                    }
                }
            }
            if let categories = viewModel.place?.categories, !categories.isEmpty {
                DetailsCategoriesSection(categories: categories)
                    .padding(.top, 8)
                    .padding(.leading, 4)
            }
            if !viewModel.tips.isEmpty {
                DetailsTipsSection(tips: viewModel.tips)
                    .padding(.top, 8)
                    .padding(.leading, 4)
            }
            if let location = viewModel.place?.location, viewModel.showLocationSection {
                DetailsLocationSection(location: location)
                    .padding(.vertical, 8)
                    .padding(.leading, 4)
            }
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
            guard let place = stackNavigator.currentOptions?["place"] as? IAMNPlace else {
                Logger.detailScreen.warning("place is not in current options; \(stackNavigator.currentOptions ?? [:])")
                return
            }
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
