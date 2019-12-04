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

let KEY_FOUNDS = "founds"
let KEY_SEARCHING_TEXT = "SEARCHING_TEXT"

class SpotlightVM: ObservableObject {
    @Published var searchingText: String = UserDefaults.standard.string(forKey: KEY_SEARCHING_TEXT) ?? ""
    @Published var founds: [String] = UnArchiveFromUserDefault(key: KEY_FOUNDS)

    var didChangeSearchText: (String) -> Void
    
    let model: SpotlightModel
    let searchResultSubject = PassthroughSubject<[SearchResult], SpotlightError>()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(searchKeywords: [String], didChangeSearchText: @escaping (String) -> Void) {
        UserDefaults.standard.removeObject(forKey: KEY_FOUNDS)
        UserDefaults.standard.removeObject(forKey: KEY_SEARCHING_TEXT)
        
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
                    print("?1")
                    UserDefaults.standard.set($0, forKey: KEY_SEARCHING_TEXT)
                    
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
                print("?0")
                let archive = try? NSKeyedArchiver.archivedData(withRootObject: $0,
                                                           requiringSecureCoding: true)
                UserDefaults.standard.set(archive, forKey: KEY_FOUNDS)

                
                // self.founds = $0
            })
            .store(in: &cancellables)
    }

}

func UnArchiveFromUserDefault(key: String) -> [String] {
    if let data = UserDefaults.standard.object(forKey: key) as? Data {
        if let res = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String] {
            return res
        } else {
            return []
        }
    } else {
        return []
    }
}

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

