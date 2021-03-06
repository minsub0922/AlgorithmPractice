//
//  Kakao2021Blind.swift
//  AlgorithmPracticeTests
//
//  Created by 최민섭 on 2020/09/12.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation
import XCTest
@testable import AlgorithmPractice

extension AlgorithmPracticeTests {
    func testRecommendId() {
        let new_id = "abcdefghijklmn.p"
        
        func capitalToSmall(_ w: String) -> String {
            return w.map { $0.lowercased() }.reduce("",+)
        }
        
        func filterCharacters(_ w: String) -> [String] {
            do {
                let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._-]")
                var results = regex.matches(in: new_id, range: NSRange(w.startIndex..., in: w))
                return results.map { String(w[Range($0.range, in: w)!]) }
            } catch let err {
                return []
            }
        }
        
        func removeConinuosPeriod(_ arr: [String]) -> [String] {
            var res: [String] = []
            var pre = ""
            
            for a in arr {
                if !(a == "." && pre == ".") { res.append(a) }
                pre = a
            }
            
            return res
        }
        
        func removeUselessPeriod(_ arr: [String]) -> [String] {
            var res: [String] = arr
            if res.first == "." { res.removeFirst() }
            if res.last == "." { res.removeLast() }
            return res
        }
        
        var characters = filterCharacters(capitalToSmall(new_id))
        characters = removeConinuosPeriod(characters)
        characters = removeUselessPeriod(characters)
        
        let count = characters.count
        if count == 0 { characters.append("a") }
        if count >= 16 {
            characters = characters[0..<15].map { String($0) }
            characters = removeUselessPeriod(characters)
        }
        if count <= 2 {
            while characters.count < 3 {
                characters.append(characters.last!)
            }
        }
        
        print(characters.reduce("",+))
    }
    
    func testFuckingCorona() throws {
        let orders = ["XYZ", "XWY", "WXA"]
        let course = [2,3,4]
        
        var candidates: [String:Int] = [:]
        var ans: [String] = []
        
        func dfs(depth: Int, order: String, str: String) {
            if depth > order.count { return }
            
            if depth == 0 {
                candidates[str, default: 0] += 1
                return
            }
            
            var left = order
            for o in order {
                left.removeAll { $0 == o }
                dfs(depth: depth-1, order: left, str: str+String(o))
            }
        }
        
        for o in orders {
            for c in course {
                dfs(depth: c, order: o.sorted().map { String($0) }.reduce("",+), str: "")
            }
        }
        
        for c in course {
            var candiPerCourseNumber = candidates
                .filter { $0.key.count == c }
                .filter { $0.value >= 2 }
                .sorted { $0.value >= $1.value }
            let max = candiPerCourseNumber.first?.value
            ans.append(contentsOf:
                candiPerCourseNumber
                .filter { $0.value == max }
                .map { $0.key })
        }
        
        print(ans.sorted())
    }
    
    func testApplicants() {
        let info = ["java backend junior pizza 150","python frontend senior chicken 210","python frontend senior chicken 150","cpp backend senior pizza 260","java backend junior chicken 80","python backend senior chicken 50"]
        let query = ["java and backend and junior and pizza 100","python and frontend and senior and chicken 200","cpp and - and senior and pizza 250","- and backend and senior and - 150","- and - and - and chicken 100","- and - and - and - 150"]
        
        var applicants: [String:[Int]] = [:]
        var ans: [Int] = []
        
        for inf in info {
            var str = inf.split(separator: " ")
            let score = str.removeLast()
            let index = str.map { String($0) }.reduce("",+)
            applicants[index, default: []].append(Int(score)!)
        }
        
        print(applicants)
        
        for q in query {
            var quiries: [String] = []
            var str = q.components(separatedBy: " and").reduce("",+).components(separatedBy: " ")
            
            if str[0] == "-" { quiries.append(contentsOf: ["java","cpp","python"]) }
            else { quiries.append(str[0]) }
            
            if str[1] == "-" {
                let temp = quiries
                quiries = quiries.map { $0 + "backend" } + temp.map { $0 + "frontend" }
            } else { quiries = quiries.map { $0 + str[1]}}
            
            if str[2] == "-" {
                let temp = quiries
                quiries = quiries.map { $0 + "junior" } + temp.map { $0 + "senior" }
            } else { quiries = quiries.map { $0 + str[2]}}
            
            if str[3] == "-" {
                let temp = quiries
                quiries = quiries.map { $0 + "chicken" } + temp.map { $0 + "pizza" }
            } else { quiries = quiries.map { $0 + str[3]}}
            
            var count = 0
            quiries.forEach {
                count += applicants[$0, default: []].filter { $0 >= Int(str[4])! }.count
            }
            
            ans.append(count)
        }
        
        print(ans)
    }
    
    func testTaxiRoute() throws {
        
    }
    
    func testBestAd() {
        let play_time = "02:03:55"
        let adv_time = "00:14:15"
        let logs = ["01:20:15-01:45:14", "00:40:31-01:00:00", "00:25:50-00:48:29", "01:30:59-01:53:29", "01:37:44-02:02:30"]
        var logOrdered = logs.map { log -> (s: String, e: String) in
            var temp = log.split(separator: "-").map { String($0)}
            return (s: temp[0], e: temp[1])
        }.sorted { $0 < $1 }
        
        print(logs.map { log -> [(String, Int)] in
            let temp = log.split(separator: "-")
            return [(String(temp[0]),0),(String(temp[1]),1)]
        }.flatMap { $0 }.sorted { $0.0 < $1.0 })
        
        let timeStamps = logs
            .map { log -> [(String, Int)] in
                let temp = log.split(separator: "-")
                return [(String(temp[0]),0),(String(temp[1]),1)] }
            .flatMap { $0 }
            .sorted { $0.0 < $1.0 }
        var starts: [String] = []
        for stamp in timeStamps {
            if stamp.1 == 0 { starts.append(stamp.0) }
            else {
                let firstStartTime = starts.removeFirst()
                
            }
        }
        
        
//        print(logOrdered)
    }
    
    func testCardGame() throws {
        let board = [[1,0,0,3],[2,0,0,0],[0,0,0,2],[3,0,1,0]]
        let r = 1, c = 0
        
        var x = r, y = c
        let d = [[1,0], [-1,0], [0,1], [0,-1]]
        var map = board
        var cards: [(Int,Int)] = []
        var count = 0

        for i in 0..<4 {
            for j in 0..<4 {
                let item = map[i][j]
                if item == 0 { continue }
                cards.append((i,j))
            }
        }
        
        var minDist = Int.max
        
        func findDistance(directions: [Int], cost: Int, preDirection: Int, x: Int, y: Int) {
            if cost == 0 { minDist = Int.max }
            
            if directions.count == 0 { minDist = min(cost, minDist) }
            
            for direction in Array(Set(directions)) {
                var newDirections = directions
                let index = newDirections.firstIndex(of: direction)!
                newDirections.remove(at: index)
                
                let newCost = (preDirection == direction) && (map[x][y] == 0 ) ? cost : cost + 1
                let newX = x + d[direction][0]
                let newY = y + d[direction][1]
                
                findDistance(directions: newDirections,
                    cost: newCost,
                    preDirection: direction,
                    x: newX,
                    y: newY)
            }
        }
            
        func findClosest() -> (Int,Int) {
            var distance = Int.max
            var target: (Int,Int) = (x,y)
            for card in cards {
                let dist = (card.0-x, card.1-y)
                var directions: [Int] = []
                (0..<abs(dist.0)).forEach { _ in
                    directions.append(dist.0 > 0 ? 0 : 1 )
                }
                (0..<abs(dist.1)).forEach { _ in
                    directions.append(dist.1 > 0 ? 2 : 3 )
                }
                
                findDistance(directions: directions, cost: 0, preDirection: -1, x: x, y: y)
                if distance > minDist { distance = minDist; target = card }
            }
            
            return target
        }
        
        func findPartner(value: Int) -> (Int,Int)? {
            for card in cards {
                if map[card.0][card.1] == value { return card }
            }
            return nil
        }

        while !cards.isEmpty  {
            let item = map[x][y]
            if item != 0 {
                if !cards.contains(where: { $0 == (x,y) }) { break }
                map[x][y] = 0
                cards.removeAll { $0 == (x,y) }
                let next = findPartner(value: item)!
                
                let dist = (next.0-x, next.1-y)
                var directions: [Int] = []
                (0..<abs(dist.0)).forEach { _ in
                    directions.append(dist.0 > 0 ? 0 : 1 )
                }
                (0..<abs(dist.1)).forEach { _ in
                    directions.append(dist.1 > 0 ? 2 : 3 )
                }
                findDistance(directions: directions, cost: 0, preDirection: -1, x: x, y: y)
                cards.removeAll { $0 == (next.0,next.1) }
                map[next.0][next.1] = 0
                x = next.0
                y = next.1
                count += minDist
                count += 2
            } else {
                let next = findClosest()
                count += minDist
                x = next.0
                y = next.1
            }
        }
        
        print(count)
    }
}
