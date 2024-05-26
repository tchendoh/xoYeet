//
//  xoYeetApp.swift
//  xoYeet
//
//  Created by Eric Chandonnet on 2024-04-18.
//

import SwiftUI

@main
struct xoYeetApp: App {
    @State var gameViewModel = GameViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(gameViewModel)
        }
    }
}
