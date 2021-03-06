//
//  Kakao2020Intern.swift
//  AlgorithmPracticeTests
//
//  Created by 최민섭 on 2020/09/08.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

import XCTest
@testable import AlgorithmPractice

extension AlgorithmPracticeTests {
    
    func testKeypad() {
        let numbers: [Int] = [1, 3, 4, 5, 8, 2, 1, 4, 5, 9, 5]
        let hand: String = "right"
        
        let dic = [1:0, 2:0, 3:0,
                   4:1, 5:1, 6:1,
                   7:2, 8:2, 9:2,
                   10:3, 0:3, 11:3
        ]
        
        func isLeft(number: Int) -> Bool { [1,4,7,10].contains(number) }
        func isRight(number: Int) -> Bool { [3,6,9,11].contains(number) }
        func isCenter(number: Int) -> Int { [2,5,8,0].contains(number) ? 0 : 1 }
       
        var left = 10, right = 11
        
        var ans = ""
        
        numbers.forEach {
            if isLeft(number: $0) {
                left = $0
                ans += "L"
                return
            } else if isRight(number: $0) {
                right = $0
                ans += "R"
                return
            }
            
            let distLeft = isCenter(number: left) + abs(dic[left]! - dic[$0]!)
            let distRight = isCenter(number: right) + abs(dic[right]! - dic[$0]!)
            
            if distLeft > distRight {
                right = $0
                ans += "R"
            } else if distLeft < distRight {
                left = $0
                ans += "L"
            } else {
                if hand == "right" {
                    ans += "R"
                    right = $0
                } else {
                    ans += "L"
                    left = $0
                }
            }
        }
        
        print(ans)
    }
        
    func testMaximizeFunction() throws {
        let expression: String = "14-10+20*30"

        let operators = expression
            .filter { ["*", "+", "-"].contains(String($0)) }
            .map { String($0) }
        let numbers = expression.components(separatedBy: CharacterSet(charactersIn: operators.reduce("",+)))
        var ans = 0
        var weight: [String:Int] = [:]
        
        func calc(_ stack: [String], limit: Int) -> [String] {
            var stack = stack
            var res = Int(stack.removeLast())!
            while !stack.isEmpty {
                if weight[stack.last!]! < limit {
                    break
                }
                let op = stack.removeLast()
                let number = Int(stack.removeLast())!
                if op == "+" { res = number + res }
                else if op == "-" { res = number - res }
                else { res = number * res }
            }
            stack.append(String(res))
            return stack
        }
        
        func maximize() {
            var stack: [String] = []
            
            for i in 0..<operators.count {
                stack.append(numbers[i])
                                
                if stack.count > 1 && weight[stack[stack.count-2]]! >= weight[operators[i]]! {
                    stack = calc(stack, limit: weight[operators[i]]!)
                }
                
                stack.append(operators[i])
            }
            
            stack.append(numbers.last!)
            ans = max(ans, abs(calc(stack, limit: 0).map { Int($0)! }.reduce(0,+)))
        }
        
        let priorities = [
            ("*", "-", "+"),
            ("*", "+", "-"),
            ("+", "*", "-"),
            ("+", "-", "*"),
            ("-", "*", "+"),
            ("-", "+", "*")
        ]
        
        for priority in priorities {
            weight[priority.0] = 0
            weight[priority.1] = 1
            weight[priority.2] = 2
            
            maximize()
        }
        
        print(Int64(ans))
    }
    
    func testTreasureShopping() {
        let gems = ["AA", "AB", "AC", "AA", "AC"]
        
        let gemTypes = Set(gems)
        var ans = (0,gems.count)
        var left = 0, right = 0
        var dict: [String:Int] = [:]
        dict[gems[0]] = 1
        
        while left < gems.count && right < gems.count {
            if dict.count == gemTypes.count {
                ans = ans.1-ans.0 <= right-left ? ans : (left,right)
                dict[gems[left], default: 0] -= 1
                if dict[gems[left]] == 0 { dict.removeValue(forKey: gems[left]) }
                left += 1
                if left >= gems.count || left >= right { break }
            } else {
                right += 1
                if right >= gems.count { break }
                dict[gems[right],default: 0] += 1
            }
        }
        
        print(ans.0+1, ans.1+1)
    }
    
    func testRaceBuilding() throws {
        let board:[[Int]] = [[0,0,1,0],[0,0,0,0],[0,1,0,1],[1,0,0,0]]
        let n = board.count
        let dir = [[1,0],[0,1],[-1,0],[0,-1]]
        var visited = board
        struct Road { let x,y,cost: Int; let dir: [Int] }
        var queue: [Road] = [Road(x: 0, y: 0, cost: 0, dir: [-1,-1])]
        var ans = Int.max
        
        visited[0][0] = 1
        
        while !queue.isEmpty {
            let temp = queue.removeFirst()
            
            if temp.x == n-1 && temp.y == n-1 {
                ans = min(ans, temp.cost)
                continue
            }
            
            dir.forEach { d in
                let next = (x: temp.x+d[0], y: temp.y+d[1])
                
                if next.x >= 0
                    && next.x < n
                    && next.y >= 0
                    && next.y < n
                    && visited[next.x][next.y] != 1 {
                    
                    var cost = temp.cost
                    
                    if temp.dir == d || temp.dir == [-1,-1] {
                        cost += 100
                    } else {
                        cost += 600
                    }
                    
                    if visited[next.x][next.y] == 0 || visited[next.x][next.y] >= cost {
                        visited[next.x][next.y] = cost
                        queue.insert(Road(x: next.x, y: next.y, cost: cost, dir: d), at: 0)
                    }
                }
            }
        }
        
        print(ans)
    }
}
