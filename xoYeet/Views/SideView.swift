//
//  SideView.swift
//  xoYeet
//
//  Created by Eric Chandonnet on 2024-04-22.
//

import SwiftUI

struct SideView: View {
    @Environment(GameViewModel.self) private var gameViewModel: GameViewModel
    var isReversed: Bool = false

    
    var body: some View {
        VStack (spacing: 0) {
            VStack {
                ZStack {
                    if isReversed {
                        Color("TeamRed")
                    } else {
                        Color("TeamBlue")
                    }
                    
                    VStack {
                        if gameViewModel.gameStatus == .teamPicking {
                            SpinningCircleView(isReversed: isReversed)
                        } else {
                            if isReversed {
                                PlayerSideView(player: gameViewModel.playerTop)
                                
                            } else {
                                PlayerSideView(player: gameViewModel.playerBottom)
                            }
                        }
                    }
                    .padding(.top, 100)


                }
            }
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    VStack(spacing: 0) {
        SideView(isReversed : true)
            .rotationEffect(.degrees(180))
        SideView()
    }
    .environment(GameViewModel())

}
