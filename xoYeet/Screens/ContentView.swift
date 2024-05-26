//
//  ContentView.swift
//  xoYeet
//
//  Created by Eric Chandonnet on 2024-04-18.
//

import SwiftUI

struct ContentView: View {
    @Environment(GameViewModel.self) private var gameViewModel: GameViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                SideView(isReversed : true)
                    .rotationEffect(.degrees(180))
                SideView()
            }
            BoardView()
            if gameViewModel.gameStatus == .teamPicking {
                VStack {
                    Spacer()
                    Button(action: {
                        gameViewModel.startGame()
                    }) {
                        Text("bypass")
                            .foregroundStyle(.white)
                            .underline()
                            .padding(.bottom)
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
        .environment(GameViewModel())
}
