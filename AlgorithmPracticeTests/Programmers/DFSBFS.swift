//
//  DFSBFS.swift
//  AlgorithmPracticeTests
//
//  Created by 최민섭 on 2021/03/07.
//  Copyright © 2021 최민섭. All rights reserved.
//

import Foundation
import XCTest
@testable import AlgorithmPractice

extension AlgorithmPracticeTests {
    func testTargetNumber2() {
        func solution(_ numbers:[Int], _ target:Int) -> Int {
            var ans = 0
            
            func dfs(depth: Int, sum: Int) {
                if depth == numbers.count {
                    if sum == target {
                        ans += 1
                    }
                    return
                }
                
                dfs(depth: depth+1, sum: sum+numbers[depth])
                dfs(depth: depth+1, sum: sum-numbers[depth])
            }
            
            dfs(depth: 0, sum: 0)
            
            return ans
        }
        
        print(solution([1,1,1,1,1], 3))
    }
    
    func testNetwork2() {
        func solution(_ n:Int, _ computers:[[Int]]) -> Int {
            
            var v = [Int](repeating: 0, count: n)
            var ans = 0
            
            func bfs(_ q: inout [[Int]]) {
                while !q.isEmpty {
                    let com = q.removeFirst()
                    for (j,c) in com.enumerated() {
                        if c == 1 && v[j] != 1 {
                            q.append(computers[j])
                            v[j] = 1
                        }
                    }
                }
            }
            
            for i in (0..<computers.count) {
                if v[i] == 1 { continue }
                
                var q = [computers[i]]
                v[i] = 1
                
                bfs(&q)
                
                ans += 1
            }
            
            return ans
        }
        
        print(solution(3, [[1, 1, 0], [1, 1, 1], [0, 1, 1]]))
    }
    
    func testTranslateWords() {
        func solution(_ begin:String, _ target:String, _ words:[String]) -> Int {
            var ans = Int.max
            var v = [Int](repeating: 0, count: words.count)
            
            func fetchTranslatable(a: String, b: String) -> Bool {
                zip(a, b).filter { $0 != $1 }.count == 1
            }
            
            func dfs(d: Int, word: String) {
                if d == words.count || word == target {
                    ans = min(ans, word == target ? d : Int.max)
                    return
                }
                
                for (i,w) in words.enumerated() {
                    if v[i] == 1 { continue }
                    if fetchTranslatable(a: word, b: w) {
                        v[i] = 1
                        dfs(d: d+1, word: w)
                        v[i] = 0
                    }
                }
            }
            
            dfs(d: 0, word: begin)
                
            return ans == Int.max ? 0 : ans
        }
        
        print(solution("hit", "cog", ["hot", "dot", "dog", "lot", "log"]    ))
    }
    
    func testTravelRoute() {
        func solution(_ tickets:[[String]]) -> [String] {
            var v = [Bool](repeating: false, count: tickets.count)
            var ans: [[String]] = []
            
            func dfs(d: Int, path: [String]) {
                if d == tickets.count {
                    ans.append(path)
                    return
                }
                
                for (i,t) in tickets.enumerated() {
                    if v[i] { continue }
                    if let last = path.last, t[0] == last {
                        v[i] = true
                        dfs(d: d+1, path: path+[t[1]])
                        v[i] = false
                    }
                }
            }
            
            dfs(d: 0, path: ["ICN"])
            
            return ans.sorted { $0.reduce("",+) < $1.reduce("",+)} [0]
        }
        
        print(solution([["ICN", "SFO"], ["ICN", "ATL"], ["SFO", "ATL"], ["ATL", "ICN"], ["ATL","SFO"]] ))
    }
}
