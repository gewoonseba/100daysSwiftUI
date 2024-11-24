//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Sebastian Stoelen on 21/11/2024.
//

import Foundation

extension EditView {
    @Observable
    class ViewModel {
        private var location: Location

        private var name: String
        private var description: String

        private var loadingState: LoadingSate = .loading
        private var pages = [Page]()
        
        init(location: Location, name: String, description: String, loadingState: LoadingSate, pages: [Page] = [Page]()) {
            self.location = location
            self.name = name
            self.description = description
            self.loadingState = loadingState
            self.pages = pages
        }
    }
}
