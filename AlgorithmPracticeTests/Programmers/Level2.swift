//
//  Level2.swift
//  AlgorithmPracticeTests
//
//  Created by 최민섭 on 2021/03/07.
//  Copyright © 2021 최민섭. All rights reserved.
//

import Foundation
import XCTest
@testable import AlgorithmPractice

extension AlgorithmPracticeTests {
    func testNormalRectangle() {
        func solution(_ w:Int, _ h:Int) -> Int64{
            func fetchGCD(_ a: Int, _ b: Int) -> Int64 {
                if a == 0 { return Int64(b) }
                return fetchGCD(b%a, a)
            }
            
            let gcd = fetchGCD(w, h)
            let w64 = Int64(w)
            let h64 = Int64(h)
            return w64*h64 - w64 - h64 + gcd
        }
        
        print(solution(8, 12))
    }
    
    func testSkillTree() {
        func solution(_ skill:String, _ skill_trees:[String]) -> Int {
            
//            var dic: [String: Int] = [:]
//            for (i,s) in skill.enumerated() {
//                dic[String(s)] = i
//            }
//
//            return skill_trees
//                .map { $0.map { String($0) } }
//                .map { $0.filter { dic[$0, default: -1] != -1 } }
//                .filter { $0.enumerated().filter { dic[$0.element] != $0.offset }.count == 0 }
//                .count
            
            return skill_trees
                .filter { skill.starts(with: $0.filter { skill.contains($0) })  }
                .count
        }
        
        print(solution("CBD"    , ["BACDE", "CBADF", "AECB", "BDA"]    ))
    }
    
    func testTriSnail() {
        func solution(_ n:Int) -> [Int] {
            var arr: [[Int]] = Array(repeating: [Int](repeating: 0, count: n), count: n)
            let tail = n*(n+1)/2
            var state = 0
            var curr = (r: 0,c: 0)
            arr[0][0] = 1
            if n == 1 { return [1]}
            
            func fetchNext() -> (Int, Int) {
                let d = [[1,0], [0,1], [-1,-1]]
                for _ in 0..<d.count {
                    let next = (r: curr.r + d[state][0], c: curr.c + d[state][1])
                    if next.r < n && next.c < n, arr[next.r][next.c] == 0 { return next }
                    state = (state+1) % d.count
                }
                return (0,0)
            }
            
            (2...tail).forEach {
                curr = fetchNext()
                arr[curr.r][curr.c] = $0
            }
            
            return arr.flatMap { $0.filter { $0 != 0 } }
        }
        (1...22).forEach {
            print(solution($0))
        }
        
    }
}
