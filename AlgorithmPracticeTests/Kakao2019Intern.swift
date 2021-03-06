//
//  Kakao2019Intern.swift
//  AlgorithmPracticeTests
//
//  Created by 최민섭 on 2020/09/12.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation
import XCTest
@testable import AlgorithmPractice

extension AlgorithmPracticeTests {
    func testCrane() throws {
        let board = [[0,0,0,0,0],[0,0,1,0,3],[0,2,5,0,1],[4,2,4,4,2],[3,5,1,3,1]]
        let moves = [1,5,3,5,1,2,1,4]
        
        var dolls: [Int: [Int]] = [:]
        var result: [Int] = []
        var ans = 0
        
        for b in board {
            for (i,doll) in b.enumerated() {
                if doll == 0 { continue }
                dolls[i+1, default: []].insert(doll, at: 0)
            }
        }
                
        moves.forEach {
            if dolls[$0]!.count == 0 { return }
            let doll = dolls[$0]!.removeLast()
            var blasted = 0
            
            while !result.isEmpty && result.last == doll {
                blasted += 1
                result.removeLast()
            }
            
            if blasted == 0 { result.append(doll) }
            else { ans += blasted + 1 }
        }
        
        print(ans)
    }
    
    func testTuple() throws {
        let s = "{{2},{2,1},{2,1,3},{2,1,3,4}}"
        var map: [String:Int] = [:]
        
        s
            .replacingOccurrences(of: "}", with: "")
            .replacingOccurrences(of: "{", with: "")
            .split(separator: ",")
            .forEach {
                map[String($0), default: 0] += 1
        }
        
        print(map
            .sorted { $0.value > $1.value }
            .map { Int($0.key) })
    }
    
    func testBlackList() throws {
        let user_id = ["frodo", "fradi", "crodo", "abc123", "frodoc"]
        let banned_id = ["*rodo", "*rodo", "******"]
        
        var map: [String: [String]] = [:]
        var ans: [[String]] = []
        
        for banned in banned_id {
            for user in user_id {
                if banned.count != user.count { continue }
                var count = 0
                zip(banned, user).forEach { b, u in
                    if b == "*" || b == u { count += 1 }
                }
                if count == banned.count {
                    map[banned, default: []].append(user)
                }
            }
        }
                        
        func dfs(depth: Int, _str: [String]) {
            if depth == banned_id.count {
                if Set(_str).count == _str.count { ans.append(_str) }
                return
             }
            
            for m in Set(map[banned_id[depth], default: []]) {
                var str = _str
                str.append(m)
                dfs(depth: depth+1, _str: str)
            }
        }
        
        dfs(depth: 0, _str: [])
            
        print(Set(ans.map { $0.sorted() }).count)
    }
}

