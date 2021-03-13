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
    
    func testStringCompressiong() {
        func solution(_ s:String) -> Int {
            var ans = s
            
            if s.count == 1 { return 1}
            
            for i in (1...s.count/2) {
                var pre = ""
                var cnt = 0
                var res = ""
                var _s = s
                while _s.count >= i {
                    if pre == _s.prefix(i) {
                        cnt += 1
                    } else {
                        res += (cnt <= 1 ? "" : "\(cnt)") + pre
                        pre = String(_s.prefix(i))
                        cnt = 1
                    }
                    _s = String(_s.dropFirst(i))
                }
                
                res += (cnt==1 ? "" : "\(cnt)") + pre + _s
                ans = ans.count < res.count ? ans : res
            }

            return ans.count
        }
        
        print(solution("a"))
    }
    
    func testSearchRanking() {
        func solution(_ info:[String], _ query:[String]) -> [Int] {
            
            var scores: [String:[Int]] = [:]
            let jocker = "-"
            var ans: [Int] = []
            
            for inf in info.map { $0.split(separator: " ") } {
                var pre: [String] = [""]
                for (i,e) in inf.enumerated() {
                    var temp: [String] = []
                    for p in pre {
                        if i == inf.count-1, let score = Int(e) {
                            scores[p, default: []].append(score)
                            continue
                        }
                        
                        let a = (p + " " + String(e)).trimmingCharacters(in: .whitespacesAndNewlines)
                        let b = (p + " " + jocker).trimmingCharacters(in: .whitespacesAndNewlines)
                        temp.append(a)
                        temp.append(b)
                    }
                    pre = temp
                }
            }
            
            let _query = query
                .map { $0.replacingOccurrences(of: "and", with: "").replacingOccurrences(of: "  ", with: " ") }
                .map { $0.split(separator: " ") }
            
            for _q in _query {
                guard let last = _q.last else { return [] }
                let minScore = String(last)
                let q = _q.dropLast().reduce("") { $0 + " " + $1 }.trimmingCharacters(in: .whitespacesAndNewlines)

                if minScore == jocker {
                    ans.append(scores[q, default: []].count)
                } else {
                    ans.append(scores[q, default: []].filter { $0 >= Int(minScore)! }.count)
                }
            }
            
            return ans
        }
        
        print(solution(["java backend junior pizza 150","python frontend senior chicken 210","python frontend senior chicken 150","cpp backend senior pizza 260","java backend junior chicken 80","python backend senior chicken 50"], ["java and backend and junior and pizza 100","python and frontend and senior and chicken 200","cpp and - and senior and pizza 250","- and backend and senior and - 150","- and - and - and chicken 100","- and - and - and - 150"]))
    }
    
    func testQuadCompression() {
        func solution(_ arr:[[Int]]) -> [Int] {
            var ans = [0,0]
            func fetchCompression(_ arr: [[Int]]) {
                switch arr.flatMap{ $0 }.filter { $0 == 1 }.count {
                case 0:
                    ans[0] += 1
                case Int(pow(Double(arr.count),Double(2))):
                    ans[1] += 1
                default:
                    let n = arr.count
                    fetchCompression((0..<n/2).map { Array(arr[$0][0..<n/2]) })
                    fetchCompression((0..<n/2).map { Array(arr[$0][n/2..<n]) })
                    fetchCompression((n/2..<n).map { Array(arr[$0][0..<n/2]) })
                    fetchCompression((n/2..<n).map { Array(arr[$0][n/2..<n]) })
                }
            }
            
            fetchCompression(arr)
            
            return ans
        }
        
        print(solution([[1,1,1,1,1,1,1,1],[0,1,1,1,1,1,1,1],[0,0,0,0,1,1,1,1],[0,1,0,0,1,1,1,1],[0,0,0,0,0,0,1,1],[0,0,0,0,0,0,0,1],[0,0,0,0,1,0,0,1],[0,0,0,0,1,1,1,1]]    ))
    }
    
    func testBiggestRectangle() {
        func solution(_ board:[[Int]]) -> Int
        {
            var answer:Int = 0
            
            var dp: [[Int]] = Array(arrayLiteral: [Int](repeating: 0, count: board[0].count+1)) + board.map { [0] + $0 }
            
            for i in 1..<dp.count {
                for j in 1..<dp[0].count {
                    if dp[i][j] != 1 { continue }
                    dp[i][j] = min(dp[i-1][j], dp[i][j-1], dp[i-1][j-1]) + 1
                    answer = max(dp[i][j], answer)
                }
            }

            return answer*answer
        }
        
        print(solution([[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0]]    ))
    }
    
    func testAppropriateClosure() {
        func solution(_ s:String) -> Bool
        {
            var cnt = 0
            
            for _s in s {
                cnt += _s == "(" ? 1 : -1
                if cnt < 0 { return false }
            }
            
            return cnt == 0
        }
        
        print(solution("(())()"))
    }
    
    func testNextBiggerNumber() {
        func solution(_ n:Int) -> Int
        {
            var n = n
            let target = String(n, radix:2).map { $0 }.filter { $0 == "1" }.count
            while true {
                n += 1
                if target == String(n, radix:2).map { $0 }.filter { $0 == "1" }.count { return n }
            }
            
            return 0
        }
        
        print(solution(1000000))
    }
}
