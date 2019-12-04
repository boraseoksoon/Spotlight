//
//  ItemList.swift
//  Spotlight
//
//  Created by boraseoksoon on 11/18/2019.
//  Copyright (c) 2019 boraseoksoon. All rights reserved.
//

import SwiftUI

struct ItemList: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @ObservedObject var viewModel: ItemListViewModel
    @State private var isSearching = false
    
    init(viewModel: ItemListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Spotlight(founds:viewModel.searchableItems,
                  isSearching:$isSearching) {
            self.navigationView
        }
    }
}

// MARK: - Views
extension ItemList {
    var navigationView: some View {
        NavigationView {
            listView
                .navigationBarTitle("Spotlight")
                .navigationBarItems(trailing:
                    Button(action: {
                        //
                        print("search click!")
                        
                        self.isSearching.toggle()
                        
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                )
        }
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text(viewModel.errorMessage))
        }
    }

    var listView: some View {
        List(viewModel.items, id: \.id) { item in
            ItemRow(item: item).onAppear {
                self.viewModel.appearItem(id:item.id)
            }
        }
        .navigationBarTitle(Text("Photos"))
    }
}
