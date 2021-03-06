//
//  Line2020.swift
//  AlgorithmPracticeTests
//
//  Created by 최민섭 on 2020/09/13.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation
import XCTest
@testable import AlgorithmPractice

extension AlgorithmPracticeTests {
    func testMatchBox() {
        let boxes = [[1, 2], [2, 1], [3, 3], [4, 5], [5, 6], [7, 8]]
        var sorted = boxes.flatMap { $0 }.sorted()
        var left: [Int] = []
        var ans = 0
        var pre = 0
                
        while !sorted.isEmpty {
            let item = sorted.removeFirst()
            if pre == item { pre = 0 }
            else {
                if pre != 0 { left.append(pre) }
                pre = item
            }
        }
        
        if pre != 0 { left.append(pre) }
        
        print(left)
    }
    
    func testOrderedCircle() {
        let ball = [11, 2, 9, 13, 24]
        let order = [9, 2, 13, 24, 11]
        
        var stack = ball
        var result: [Int] = []
        var hold: [Int] = []
        
        for o in order {
            var removed: [Int] = []
            if stack.first == o {
                removed.append(stack.removeFirst())
                while !stack.isEmpty {
                    if let item = stack.first, hold.contains(item) {
                        hold.removeAll{ $0 == item }
                        stack.removeFirst()
                        removed.append(item)
                    } else { break }
                }
            }
            else if stack.last == o {
                removed.append(stack.removeLast())
                while !stack.isEmpty {
                    if let item = stack.last, hold.contains(item) {
                        hold.removeAll{ $0 == item }
                        stack.removeLast()
                        removed.append(item)
                    } else { break }
                }
            }
            else { hold.append(o); continue }
            
            result.append(contentsOf: removed)
        }
        
        print(result)
    }
    
    func testLeftWall() {
        let maze = [[0, 1, 0, 0, 0, 0], [0, 1, 0, 1, 1, 0], [0, 1, 0, 0, 1, 0], [0, 1, 1, 1, 1, 0], [0, 1, 0, 0, 0, 0], [0, 0, 0, 1, 1, 0]]
        let n = maze.count
        var pos: (x: Int, y: Int) = (0,0)
        var d: (x: Int, y: Int) = (1,0)
        var answer = 0
        
        func nextDirections() -> [(x: Int, y: Int)]{
            if d.y == 0 {
                return [(d.y,d.x), (d.x,d.y), (d.y,-d.x), (-d.x, d.y)]
            } else {
                return [(-d.y,d.x), (d.x,d.y), (d.y,d.x), (d.x, -d.y)]
            }
        }
        
        while !(pos.x == n-1 && pos.y == n-1) {
            let choices: [(x: Int, y: Int)] = nextDirections()
            for c in choices {
                let nextX = pos.x + c.x
                let nextY = pos.y + c.y
                if nextX < 0 || nextX >= n || nextY < 0 || nextY >= n { continue }
                if maze[nextX][nextY] == 1 { continue }
                
                pos = (nextX, nextY)
                d = c
                answer += 1
                break
            }
        }
        
        
        print(answer)
    }
    
    func testBlackJack() {
        let cards = [10, 13, 10, 1, 2, 3, 4, 5, 6, 2]

        var cardStack = cards.map { $0 >= 10 ? 10 : $0 }
        var opened: [Int] = []
        var userCards: [Int] = []
        var dealerCards: [Int] = []
        var winner: Int = 0
        
        func calcSum(_ cards: [Int]) -> Int {
            var temp: Int = 0
            var sum = cards
                .filter { card in
                    if card == 1 { temp += 1; return false }
                    return true }
                .reduce(0,+)
            
            if temp > 0 && sum <= 10 {
                sum += 11+temp-1+sum > 21 ? temp : 11+temp-1
            }
            
            return sum
        }
        
        while !cardStack.isEmpty {
            if opened.count == 0 {
                userCards.removeAll()
                dealerCards.removeAll()
                if cardStack.count < 4 { break }
                userCards.append(cardStack.removeFirst())
                dealerCards.append(cardStack.removeFirst())
                userCards.append(cardStack.removeFirst())
                dealerCards.append(cardStack.removeFirst())
                
                let userSum = calcSum(userCards)
                let dealerSum = calcSum(dealerCards)
                opened.append(contentsOf: dealerCards)
                
                // sum is 21 in 2turns
                if userSum == 21 {
                    opened.removeAll()
                    if dealerSum == 21 { continue }
                    winner += 3
                    continue
                } else if dealerSum == 21 {
                    opened.removeAll()
                    winner -= 2
                    continue
                }
                
                if cardStack.isEmpty {
                    if userSum == dealerSum { }
                    else if userSum > dealerSum { winner += 2 }
                    else { winner -= 2 }
                    opened.removeAll()
                }
            } else {
                var userSum = calcSum(userCards)
                if opened.contains { $0 == 4 || $0 == 5 || $0 == 6 } && userSum < 17 {
                    
                } else if opened.contains { $0 == 1 || $0 >= 7 } && userSum < 17 {
                    userCards.append(cardStack.removeFirst())
                    if cardStack.count > 0 { continue }
                } else if opened.contains { $0 == 2 || $0 == 3 } && userSum < 12 {
                    userCards.append(cardStack.removeFirst())
                    if cardStack.count > 0 { continue }
                }
                
                userSum = calcSum(userCards)
                if userSum > 21 { winner -= 2; opened.removeAll(); continue } // dealer win
                
                let dealerSum = calcSum(dealerCards)
                if dealerSum < 17 {
                    dealerCards.append(cardStack.removeFirst())
                    
                }
                
                if cardStack.count > 0 && dealerSum < 17 { continue }
                
                if dealerSum > 21 {
                    winner += 2
                    opened.removeAll()
                } else {
                    if userSum == dealerSum { }
                    else if userSum == 21 { winner += 3 }
                    else if userSum > dealerSum { winner += 2 }
                    else { winner -= 2 }
                    opened.removeAll()
                }
            }
        }
                
        print(winner)
    }
}
