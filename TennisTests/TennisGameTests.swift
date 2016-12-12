//
//  TennisGameTests.swift
//  Tennis
//
//  Created by Laurent GAIDON on 12/12/2016.
//  Copyright © 2016 HINS. All rights reserved.
//

import XCTest
@testable import Tennis

extension Int {
    
    func times (f :()-> ()) {
        for _ in 1...self {
            f()
        }
    }
}

class TenisGameTests : XCTestCase {
    
    let player1Name = "Player1"
    let player2Name = "Player2"
    
    var game :TennisGame!
    
    override func setUp() {
        game = TennisGame()
    }
    
    func nameOf(_ player :Player) -> String {
        return player == .Player1 ? player1Name : player2Name
    }
    
    func scoreString () -> String {
        return game.scoreString(namePlayer1: player1Name, namePlayer2: player2Name)
    }
    
    func setDeuceScore () {
        3.times {game.score(player: .Player1)}
        3.times {game.score(player: .Player2)}
    }
    
    func assertScore (player1 :Int, player2 :Int) {
        XCTAssertEqual(scoreString(), "\(player1Name) : \(player1) - \(player2Name) : \(player2)")
    }
    
    func assertTieScore (score :Int) {
        XCTAssertEqual(game.scoreString(namePlayer1: player1Name, namePlayer2: player2Name), "\(score)A")
    }
    
    func assertDeuce () {
        XCTAssertEqual(game.scoreString(namePlayer1: player1Name, namePlayer2: player2Name), "Deuce")
    }
    
    func assertAdvantage (player :Player) {
        XCTAssertEqual(game.scoreString(namePlayer1: player1Name, namePlayer2: player2Name), "Adv \(nameOf(player))")
    }
    
    func assertWin(player :Player) {
        XCTAssertEqual(game.scoreString(namePlayer1: player1Name, namePlayer2: player2Name), "\(nameOf(player)) Wins !!!")
    }
}

class TennisGameTests_GameStart : TenisGameTests {
    
    func testGameStart_bothPlayersHaveZero () {
        assertScore(player1: 0, player2: 0)
    }
    
    func testGameStartPlayer1Scores_has15Points () {
        game.score(player: .Player1)
        assertScore(player1: 15, player2: 0)
    }
    
    func testGameStartPlayer1Scores3Times_has40Points () {
        3.times {game.score(player: .Player1)}
        assertScore(player1: 40, player2: 0)
    }
    
    func testGameStartPlayer2Scores_has15Points() {
        game.score(player: .Player2)
        assertScore(player1: 0, player2: 15)
    }
    
    func testGameStartBothPlayersScore_scoreIsTie () {
        game.score(player: .Player1)
        game.score(player: .Player2)
        assertTieScore(score: 15)
    }
    
    func testGameStartBothPlayersScore3Times_scoreIsDeuce () {
        setDeuceScore()
        assertDeuce()
    }
}

class TennisGameTests_GameEnd : TenisGameTests {
    
    override func setUp() {
        super.setUp()
        setDeuceScore()
    }
    
    func testDeucePlayer1Score_hasAdv (){
        game.score(player: .Player1)
        assertAdvantage(player: .Player1)
    }
    
    func testAdvPlayer1Andplayer2Scores_scoreIsDeuce () {
        game.score(player: .Player1)
        game.score(player: .Player2)
        assertDeuce()
    }
    
    func testAdvPlayer1Scores_Wins () {
        game.score(player: .Player1)
        game.score(player: .Player1)
        assertWin(player: .Player1)
    }
    
    func testAdvPlayer2Scores_Wins () {
        game.score(player: .Player2)
        game.score(player: .Player2)
        assertWin(player: .Player2)
    }
}
