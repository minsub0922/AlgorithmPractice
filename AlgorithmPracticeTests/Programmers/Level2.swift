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
            
            var db: [String:[Int]] = [:]
            let jocker = "-"
            var ans: [Int] = []
            
            for i in info {
                let arr = i.components(separatedBy: " ")
                let language = [arr[0], jocker]
                let job = [arr[1], jocker]
                let career = [arr[2], jocker]
                let food = [arr[3], jocker]
                let score = Int(arr[4])!
                
                for l in language {
                    for j in job {
                        for c in career {
                            for f in food {
                                let key = "\(l)\(j)\(c)\(f)"
                                db[key, default: []].append(score)
                            }
                        }
                    }
                }
            }
            
            //ready for binary search
            db = db.mapValues { $0.sorted() }
            
            for q in query {
                var arr = q.components(separatedBy: " ").filter { $0 != "and" }
                guard
                    let last = arr.popLast(),
                    let score = Int(last)
                    else { continue }
                let key = arr.reduce("",+)
                guard
                    let scores = db[key]
                    else {
                        ans.append(0)
                        continue }
                                
                var l = 0, r = scores.count-1
                var mid = 0
                while l <= r {
                    mid = (l+r)/2
                    if scores[mid] < score {
                        l = mid+1
                    } else {
                        r = mid-1
                    }
                }
                ans.append(scores.count - l)
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
    
    /**/
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
    
    // **
    func testGetMyRegion() {
        func solution(_ land:[[Int]]) -> Int{
            var dp: [[Int]] = land
            
            for i in 0..<dp.count-1 {
//                (0..<4).forEach { j in
//                    dp[i+1][j] += (1...3).map { (j+$0)%4 }.max()
//                }
                dp[i+1][0] += max(dp[i][1], dp[i][2], dp[i][3])
                dp[i+1][1] += max(dp[i][0], dp[i][2], dp[i][3])
                dp[i+1][2] += max(dp[i][0], dp[i][1], dp[i][3])
                dp[i+1][3] += max(dp[i][0], dp[i][1], dp[i][2])
            }
            
            return dp.last?.max() ?? 0
        }
        
        print(solution([[1,2,3,5],[5,6,7,8],[4,3,2,1]]))
    }
    
    func testVisitedLength() {
        func solution(_ dirs:String) -> Int {
            var v: [String: Bool] = [:]
            var state = (0,0)
            var cnt = 0
            
            func format(_ a: (Int, Int), _ b: (Int, Int)) -> (String, String) {
                return ("\(a)->\(b)","\(b)->\(a)")
            }
            
            for d in dirs {
                var nextState = state
                switch d {
                case "U":
                    nextState = (state.0, state.1+1)
                case "L":
                    nextState = (state.0-1, state.1)
                case "R":
                    nextState = (state.0+1, state.1)
                case "D":
                    nextState = (state.0, state.1-1)
                default:
                    continue
                }
                
                if nextState.0 < -5 || nextState.0 > 5 || nextState.1 < -5 || nextState.1 > 5 {
                    continue
                }
                
                
                let path = format(state, nextState)
                state = nextState
                
                cnt += (v[path.0, default: false] || v[path.1, default: false]) ? 0 : 1
                v[path.0] = true
                v[path.1] = true
            }
            
            return cnt
        }
        
        print(solution("ULURRDLLU"))
    }
    
    func testRecursiveBinary() {
        func solution(_ s:String) -> [Int] {
            var s = s
            var cnt = 0, zeros = 0
            while s.count > 1 {
                let len = s.count
                s = s.replacingOccurrences(of: "0", with: "")
                zeros += len - s.count
                s = String(s.count, radix: 2)
                cnt += 1
            }
            
            return [cnt, zeros]
        }
        
        print(solution("110010101001"))
    }
    
    func testMaxMin() {
        func solution(_ s:String) -> String {
            do {
                let components = s.components(separatedBy: " ").map { Int($0)! }
                return "\(components.min()!) \(components.max()!)"
            } catch {
                return ""
            }
        }
        
        print(solution("-1 -2 -3 -4"    ))
    }
    
    func testMinValue() {
        func solution(_ A:[Int], _ B:[Int]) -> Int
        {
            return zip(A.sorted(), B.sorted().reversed()).reduce(0) { $0 + $1.0 * $1.1 }
        }
        
        print(solution([1,4,2], [5,4,4]))
    }
    
    func testFibonachi() {
        func solution(_ n:Int) -> Int {
            let mod = 1234567
            var f: [Int] = [Int](repeating: 0, count: n+1)
            f[0] = 0
            f[1] = 1
            
            (2...n).forEach {
                f[$0] = (f[$0-2] % mod + f[$0-1] % mod) % mod
            }
            
            return f[n]
        }
        
        print(solution(99999))
    }
    
    func testMultiplyIndex() {
        func solution(_ arr1:[[Int]], _ arr2:[[Int]]) -> [[Int]] {
            
            var ans: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: arr2[0].count), count: arr1.count)
            
            for i in 0..<arr1.count {
                for k in 0..<arr2[0].count {
                    var sum = 0
                    for j in 0..<arr1[i].count {
                        sum += arr1[i][j] * arr2[j][k]
                    }
                    ans[i][k] = sum
                }
            }
            
            return ans
        }
        
        print(solution([[1, 4], [3, 2], [4, 1]]    , [[3, 3], [3, 3]]    ))
    }
    
    func testDelivery() {
        func solution(_ N:Int, _ road:[[Int]], _ k:Int) -> Int {
            var dic: [Int: [(node: Int, weight: Int)]] = [:]
            var weights: [Int] = [Int](repeating: 0, count: N+1)
            
            road.forEach {
                dic[$0[0], default: []].append(($0[1], $0[2]))
                dic[$0[1], default: []].append(($0[0], $0[2]))
            }
                    
            var q: [Int] = [1]
            weights[1] = 0
        
            while !q.isEmpty {
                let node = q.removeFirst()
                for n in dic[node, default: []] {
                    let weight = weights[node] + n.weight
                    if weight > k || ( weights[n.node] > 0 && weights[n.node] <= weight ) { continue }
                    weights[n.node] = weight
                    q.append(n.node)
                }
            }
            return weights.filter { $0 != 0 && $0 <= k }.count
        }
        
        print(solution(5, [[1,2,1],[2,3,3],[5,2,2],[1,4,2],[5,3,1],[5,4,2]], 3))
    }
    
    func testJumpTeleport() {
        func solution(_ n:Int) -> Int
        {
            var ans:Int = 0
            var n :Int = n
            
            
            while n > 0 {
                ans += n % 2
                n = n/2
            }

            return ans
        }
        
        print(solution(5000))
    }
    
    func testEnglishEndGame() {
        func solution(_ n:Int, _ words:[String]) -> [Int] {
            var words = words
            var dic: [String:Bool] = [:]
            var pre = words[0]
            
            for (i,word) in words.enumerated() {
                if dic[word, default: false] || !word.hasPrefix(pre) { return [i%n + 1, i/n + 1] }
                dic[word] = true
                pre = String(word.suffix(1))
            }
            
            return [0,0]
        }
        
        print(solution(2, ["hello", "one", "even", "never", "now", "world", "draw"]))
    }
    

    
    func testNewsClustering() {
        func solution(_ str1:String, _ str2:String) -> Int {
            var arr1: [String] = [], arr2: [String] = []
            let str1 = str1.map { String($0).uppercased() }
            let str2 = str2.map { String($0).uppercased() }
            
            for i in 0..<str1.count-1 {
                let word = str1[i]+str1[i+1]
                arr1 += word.getArrayAfterRegex(regex: "[A-Z]+")
            }
            
            for i in 0..<str2.count-1 {
                let word = str2[i]+str2[i+1]
                arr2 += word.getArrayAfterRegex(regex: "[A-Z]+")
            }
                        
            let set1: Set = Set(arr1)
            let set2: Set = Set(arr2)
            let intersection = Double(set1.intersection(set2).count)
            let union = Double(set1.union(set2).count)
            
            print(set1)
            print(set2)
            
            if intersection == 0 && union == 0 { return 1 }
            
            print("intersections : \(intersection), union : \(union)")
            
            return Int(intersection / union * 65536)
        }
        print(solution("aa1+aa2", "AAAA12"))
    }
    
    func testFriendsFourBlocks() {
        func solution(_ m:Int, _ n:Int, _ board:[String]) -> Int {
            var blocks: [[String]] = [[String]](repeating: [], count: n)
            var board = board.map { $0.map { String($0) } }
            var ans = 0
            // pop the stacks
            
            func check(r: Int, c: Int, type: String) -> Bool {
                r < m-1 &&
                    c < n-1 &&
                    board[r][c+1] == type &&
                    board[r+1][c] == type &&
                    board[r+1][c+1] == type
            }
            
            func fetchTargets(r: Int, c: Int) -> [(Int,Int)] {
                [(r,c), (r,c+1), (r+1,c), (r+1,c+1)]
            }
            
            
            while true {
                var targets: [(Int,Int)] = []
                
                // find blocks to be removed
                for i in 0..<m {
                    for j in 0..<n {
                        let type = board[i][j]
                        if type.isEmpty { continue }
                        if check(r: i, c: j, type: type) {
                            targets.append(contentsOf: fetchTargets(r: i, c: j))
                        }
                    }
                }
                
                if targets.isEmpty { break }
                
                for target in targets {
                    if !board[target.0][target.1].isEmpty {
                        board[target.0][target.1] = ""
                        ans += 1
                    }
                }
                
            }
            
            return ans
        }
        
        print(solution(4, 5, ["CCBDE", "AAADE", "AAABF", "CCBBF"]    ))
    }
    
    func testCache() {
        func solution(_ cacheSize:Int, _ cities:[String]) -> Int {
            
            var deque: [String] = []
            var ans = 0
            
            if cacheSize == 0 { return cities.count * 5 }
            
            for city in cities.map { $0.uppercased() } {
                //hit
                if deque.contains(city) {
                    deque.removeAll { $0 == city }
                    deque.append(city)
                    ans += 1
                }
                //miss
                else {
                    if deque.count == cacheSize { deque.removeFirst() }
                    deque.append(city)
                    ans += 5
                }
            }
            
            return ans
        }
        
        print(solution(0, ["Jeju", "Pangyo", "Seoul", "NewYork", "LA"]     ))
    }
    
    func testCandidateKey() {
        func solution(_ relation:[[String]]) -> Int {
            func fetchCombinations() -> [[Int]] {
                let n: Int = relation[0].count
                var elements: [Int] = [Int](0..<n)
                var combies: Set<[Int]> = []
                var visited: [Int:Bool] = [:]
                
                func dfs(d: Int, arr: [Int]) {
                    combies.insert(arr)
                    
                    if d == elements.count { return }
                    
                    for e in elements {
                        if visited[e, default: false] { continue }
                        
                        visited[e] = true
                        dfs(d: d+1, arr: arr+[e])
                        visited[e] = false
                    }
                }
                
                while !elements.isEmpty {
                    let element = elements.removeFirst()
                    dfs(d: 0, arr: [element])
                }
                
                
                return combies.sorted { $0.count < $1.count }
            }
            
            var ans: [[Int]] = []
            var combinations = fetchCombinations()
            
            while !combinations.isEmpty {
                let combi = combinations.removeFirst()
                var relationFiltered: Set<[String]> = []
                
                for tuple in relation {
                    let tupleFiltered = tuple.enumerated().filter { combi.contains($0.offset) }.map { $0.element }
                    relationFiltered.insert(tupleFiltered)
                }
               
                if relationFiltered.count == relation.count {
                    ans.append(combi)
                    combinations = combinations.filter { !Set(combi).isSubset(of: Set($0)) }
                }
            }
            
            return ans.count
        }
        
        print(solution([["100","ryan","music","2"],["200","apeach","math","2"],["300","tube","computer","3"],["400","con","computer","4"],["500","muzi","music","3"],["600","apeach","music","2"]]    ))
    }
}

