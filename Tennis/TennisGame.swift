//
//  TennisGame.swift
//  Tennis
//
//  Created by Laurent GAIDON on 12/12/2016.
//  Copyright © 2016 HINS. All rights reserved.
//

import Foundation

enum Player {
    case Player1
    case Player2
}

class TennisGame {
    
    enum Score {
        case Point(player1 :Int, player2 :Int)
        case Adv(player :Player)
        case Win(player :Player)
        
        func increment (scorer :Player) -> Score {
            switch self {
            
            case .Adv(let player) where scorer == player:
                return .Win(player: scorer)
                
            case .Adv(let player) where scorer != player:
                return .Point(player1: 40, player2: 40)
                
            case .Point(40,40):
                return .Adv(player: scorer)
                
            case let .Point(v1,v2) where scorer == .Player1:
                return .Point(player1: nextPoint(v1), player2: v2)
                
            case let .Point(v1,v2) where scorer == .Player2:
                return .Point(player1: v1, player2: nextPoint(v2))
                
            default:
                return self
            }
        }
        
        func nextPoint (_ p :Int) -> Int {
            return p < 30 ? p + 15 : p + 10
        }
    }
    
    var history = [Player]()
    
    var currentScore :Score {
        return history.reduce(Score.Point(player1: 0, player2: 0), {$0.increment(scorer :$1)})
    }
    
    func score (player :Player) {
        history.append(player)
    }
}

extension TennisGame {
    
    func scoreString (namePlayer1 :String, namePlayer2 :String) -> String {
        
        let nameOf = {$0 == Player.Player1 ? namePlayer1 : namePlayer2}
        
        switch currentScore {
            
        case .Point(40,40):
            return "Deuce"
            
        case let .Point(v1,v2) where v1 == v2 && v1 > 0:
            return "\(v1)A"
            
        case let .Point(player1Score,player2Score):
            return "\(namePlayer1) : \(player1Score) - \(namePlayer2) : \(player2Score)"
            
        case .Adv(let player):
            return "Adv \(nameOf(player))"
            
        case .Win(let player):
            return "\(nameOf(player)) Wins !!!"
            
        }
    }
}
