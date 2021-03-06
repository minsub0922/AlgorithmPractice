//
//  Kakao2020Blind.swift
//  AlgorithmPracticeTests
//
//  Created by 최민섭 on 2020/09/11.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

import XCTest
@testable import AlgorithmPractice

extension AlgorithmPracticeTests {
    func testCompositeString() throws {
        let s = "xababcdcdababcdcd"
        var result = Int.max
        for i in 1...s.count/2 {
            var stack = s.map { String($0) }
            var count = 1
            var pre = ""
            var ans = ""
            while stack.count >= i {
                let item = (0..<i).map { _ in stack.removeFirst() }.reduce("",+)
                if item != pre {
                    ans += (count == 1 ? "" : String(count)) + pre
                    pre = item
                    count = 1
                } else { count += 1 }
            }
            
            ans += (count == 1 ? "" : String(count)) + pre
            ans += stack.reduce("",+)
            result = min(result, ans.count)
        }
        
        print(result)
    }
    
    func testBalancedString() throws {
        let p = "()))((()"
        
        func check(_ w: String) -> Bool {
            var stack: [String] = []
            if w.first == ")" { return false}
            
            stack.append(String(w.first!))
            for _w in w.map { String($0) }[1..<w.count] {
                if stack.last != _w {
                    stack.removeLast()
                } else { stack.append(_w) }
            }
            
            return stack.isEmpty
        }
        
        func beBalanced(w: String) -> String {
            if w.count == 0 { return "" }
            
            var lCount = 0, rCount = 0
            for _w in w {
                _w == "(" ? (lCount += 1) : (rCount += 1)
                if lCount == rCount {
                    break
                }
            }
            
            let u = w.map { String($0) }[0..<(lCount+rCount)].reduce("", +)
            let v = w.map { String($0) }[(lCount+rCount)..<w.count].reduce("", +)
            let b = beBalanced(w: v)
            let reversed = u
                .map { String($0) }[1..<u.count-1]
                .map { $0 == "(" ? ")" : "(" }.reduce("",+)
            
            return check(u) ? u + b : "(" + b + ")" + reversed
        }
        
        print(beBalanced(w: p))
    }
    
    func testLockAndKey() throws {
        let key: [[Int]] = [[0, 0, 0], [1, 0, 0], [0, 1, 1]]
        let lock: [[Int]] = [[1, 1, 1], [1, 1, 0], [1, 0, 1]]
        
        
    }
    
    func testLyrics() throws {
        let words = ["frodo", "front", "frost", "frozen", "frame", "kakao"]
        let queries = ["fro??", "????o", "fr???", "fro???", "pro?"]
     
        var ans: [Int] = []
        
        for q in queries {
            var count = 0
            
            for w in words {
                if w.count != q.count { continue }
                if q.first! == "?" {
                    let lastIndex = q.filter { $0 == "?" }.count
                    let word = w.map { String($0) }[lastIndex..<w.count]
                    let query = q.map { String($0) }[lastIndex..<w.count]
                    if word == query { count += 1 }
                } else {
                    let firstIndex = q.count - q.filter { $0 == "?" }.count
                    if w.map { String($0) }[0..<firstIndex] == q.map { String($0) }[0..<firstIndex] { count += 1 }
                }
            }
            
            ans.append(count)
        }
        
        print(ans)
    }
    
    func testfortest() {
        let queries = ["fro??", "????o", "fr???", "fro???", "pro?"]
        for q in queries {
            let lastIndex = q.filter { $0 == "?" }.count
            
        }
    }
    
    func testBow() throws {
        let n = 5
        let build_frame = [[0,0,0,1],[2,0,0,1],[4,0,0,1],[0,1,1,1],[1,1,1,1],[2,1,1,1],[3,1,1,1],[2,0,0,0],[1,1,1,0],[2,2,0,1]]
        var ans: [[Int]] = []
        var map: [[[Int]]] = Array(repeating: Array(repeating: [], count: n+1), count: n+1)
        
        func ableToSetPillar(_ x: Int, _ y: Int) -> Bool {
            return y == 0 ||
                (y>0 && map[x][y-1].contains(0)) ||
                (x>0 && map[x-1][y].contains(1)) ||
                map[x][y].contains(1)
        }
        
        func ableToSetPlate(_ x: Int, _ y: Int) -> Bool {
            return (y>0 && map[x][y-1].contains(0)) ||
                (y>0 && map[x+1][y-1].contains(0)) ||
                (x>0 && map[x-1][y].contains(1) && map[x+1][y].contains(1))
        }
        
        func set(_ x: Int, _ y: Int, _ type: Int) {
            if type == 0 && ableToSetPillar(x, y) {
                map[x][y].append(0)
                ans.append([x,y,0])
            } else if type == 1 && ableToSetPlate(x, y) {
                map[x][y].append(1)
                ans.append([x,y,1])
            }
        }
        
        func delete(_ x: Int, _ y: Int, _ type: Int) {
            func deletePillar(_ x: Int, _ y: Int) {
                map[x][y].removeAll { $0 == 0 }
                
                if (map[x][y+1].contains(0) && !ableToSetPillar(x, y+1)) ||
                    (x>0 && map[x-1][y+1].contains(1) && !ableToSetPlate(x-1, y+1)) ||
                    (map[x][y+1].contains(1) && !ableToSetPlate(x, y+1)) {
                    map[x][y].append(0)
                } else { ans.removeAll { $0 == [x,y,0] } }
            }
            
            func deletePlate(_ x: Int, _ y: Int) {
                map[x][y].removeAll { $0 == 1 }
                
                if (map[x][y].contains(0) && !ableToSetPillar(x, y)) ||
                    (map[x+1][y].contains(0) && !ableToSetPillar(x+1, y)) ||
                    (x>0 && map[x-1][y].contains(1) && !ableToSetPlate(x-1, y)) ||
                    (map[x+1][y].contains(1) && !ableToSetPlate(x+1, y)) {
                    map[x][y].append(1)
                } else { ans.removeAll { $0 == [x,y,1] } }
            }
            
            type == 0 ? deletePillar(x, y) : deletePlate(x, y)
        }
        
        build_frame.forEach {
            let x = $0[0]
            let y = $0[1]
            let type = $0[2]
            $0.last == 0 ? delete(x, y, type) : set(x, y, type)
        }
        
        print(ans.sorted { o1, o2 in
            if o1[0] == o2[0] { return o1[1] < o2[1]}
            return o1[0] < o2[0] }
        )
    }
    
    func testCheckOuterwall() throws {
        let n = 12
        let weak = [1, 5, 6, 10]
        let dist = [1, 2, 3, 4]
        var ans = n + 1
        
        func findMin(_ depth: Int, _ _dist: [Int], _ _left: [Int]) {
            if _left.count == 0 {
                ans = min(ans, depth)
                return
            }
            
            for d in _dist {
                for i in 0..<_left.count {
                    var left = _left[i..<_left.count]
                    left.append(contentsOf: _left[0..<i])
                    
                    let start: Int = left.first!
                    let end: Int = (start+d) % n
                    let isOver: Bool = start+d >= n
                    while !left.isEmpty {
                        guard let first = left.first else { break }
                        if isOver ?
                            (first >= start && first < n) || (first >= 0 && first <= end)
                            : first >= start && first <= end {
                            left.removeFirst()
                        } else { break }
                    }
                    
                    var dist = _dist
                    dist.removeAll { $0 == d }
                    findMin(depth+1, dist, left.map { Int($0) })
                }
            }
        }
        
        findMin(0, dist, weak)
        
        print(ans == n+1 ? -1 : ans)
    }
}
