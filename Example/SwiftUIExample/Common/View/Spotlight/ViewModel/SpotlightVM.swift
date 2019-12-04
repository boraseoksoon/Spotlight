//
//  SpotlightVM.swift
//  SwiftUIExample
//
//  Created by Seoksoon Jang on 2019/12/04.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Combine

typealias SearchResult = String

class SpotlightVM: ObservableObject {
    @Published var searchingText: String = ""
    @Published var founds: [String] = []

    var didChangeSearchText: (String) -> Void
    
    let model: SpotlightModel
    let searchResultSubject = PassthroughSubject<[SearchResult], SpotlightError>()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(searchKeywords: [String], didChangeSearchText: @escaping (String) -> Void) {
        self.didChangeSearchText = didChangeSearchText
        
        model = SpotlightModel(searchKeywords: searchKeywords,
                               searchResultSubject:searchResultSubject)
        bind()
    }
}

// MARK: - Private Methods
extension SpotlightVM {
    private func bind() {
        _ = $searchingText
                .dropFirst(1)
                .debounce(for: .seconds(0.0),
                          scheduler: DispatchQueue.main)
                .sink(receiveValue: {
                    print("$0 : ", $0)
                    self.didChangeSearchText($0)
                    self.model.searchItems(forKeyword:$0)
                })
                .store(in: &cancellables)

        searchResultSubject
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                switch $0 {
                    case .failure(let error):
                        print("searchResultSubject error : \(error)")
                    case .finished:
                        break
                }
            }, receiveValue: {
                    self.founds = $0
            })
            .store(in: &cancellables)
    }

}
