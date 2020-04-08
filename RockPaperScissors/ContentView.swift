//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Yuri Ramocan on 4/8/20.
//  Copyright © 2020 Yuri Ramocan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private let maxRounds = 10
    private let moves: [RPSMove] = [.rock, .paper, .scissors]

    @State private var computerChoice = RPSMove(rawValue: Int.random(in: 0...2))!
    @State private var gameHasEnded = false
    @State private var round = 1
    @State private var shouldWin = Bool.random()
    @State private var score = 0

    var body: some View {
        VStack(spacing: 30) {
            VStack {
                if gameHasEnded {
                    Text("Score: \(score)")
                } else {
                    Text(computerChoice.displayName)
                        .font(.title)

                    Text("You should \(shouldWin ? "win" : "lose").")
                }
            }

            if gameHasEnded {
                Button(action: {
                    self.restart()
                }) {
                    Text("Restart")
                }
            } else {
                VStack(spacing: 16) {
                    ForEach(0 ..< moves.count) { idx in
                        Button(action: {
                            self.handleScoring(for: self.moves[idx])
                            self.playRound()
                        }) {
                            Text(self.moves[idx].displayName)
                        }
                        .disabled(self.round > self.maxRounds)
                    }
                }
            }
        }
    }

    private func handleScoring(for choice: RPSMove) {
        if shouldWin && choice == computerChoice.weakness {
            score += 1
        }

        if !shouldWin && choice.weakness == computerChoice {
            score += 1
        }
    }

    private func playRound() {
        round += 1

        guard round <= maxRounds else {
            gameHasEnded = true
            return
        }

        computerChoice = RPSMove(rawValue: Int.random(in: 0...2))!
        shouldWin = Bool.random()
    }

    private func restart() {
        round = 1
        score = 0
        gameHasEnded = false
    }
}

enum RPSMove: Int {
    case rock
    case paper
    case scissors

    var displayName: String {
        switch self {
        case .rock:
            return "Rock"
        case .paper:
            return "Paper"
        case .scissors:
            return "Scissors"
        }
    }

    var weakness: RPSMove {
        switch self {
        case .rock:
            return .paper
        case .paper:
            return .scissors
        case .scissors:
            return .rock
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
