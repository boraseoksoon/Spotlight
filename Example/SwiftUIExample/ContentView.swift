//
//  ContentView.swift
//  SwiftUIExample
//
//  Created by Seoksoon Jang on 2019/12/02.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    var body: some View {
        TabView {
            ItemListView()
                .tabItem {
                    Image(systemName:"safari")
                    Text("Photos")
                }
            
            GridView()
                .tabItem {
                    Image(systemName: "grid")
                    Text("Grid")
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}
