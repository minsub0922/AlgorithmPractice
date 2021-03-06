//
//  Kakao2019BLIND.swift
//  AlgorithmPracticeTests
//
//  Created by 최민섭 on 2020/09/09.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

import XCTest
@testable import AlgorithmPractice

extension AlgorithmPracticeTests {
    func testOpenChat() {
        let record = ["Enter uid1234 Muzi", "Enter uid4567 Prodo","Leave uid1234","Enter uid1234 Prodo","Change uid4567 Ryan"]
        
        var dic: [String:String] = [:]
        var result: [(String, String)] = []
        
        record.forEach {
            let letter = $0.components(separatedBy: " ")
            if letter[0] == "Enter" {
                dic[letter[1]] = letter[2]
                result.append((letter[1],"님이 들어왔습니다."))
            } else if letter[0] == "Change" {
                dic[letter[1]] = letter[2]
            } else {
                result.append((letter[1],"님이 나갔습니다."))
            }
        }
        
        print(result.map { dic[$0.0]! + $0.1 })
    }
    
    func testFailure() {
        let N = 5
        let stages = [2, 1, 2, 6, 2, 4, 3, 3]

        var result: [Double] = Array(repeating: 0.0, count: N+2)
        
        var ordered = stages.sorted()
        
        var preStage = 0
        var count = 1
        
        while !ordered.isEmpty {
            let stage = ordered.removeFirst()
            if preStage < stage {
                result[preStage] = Double(count) / Double((ordered.count + 1 + count))
                count = 1
                preStage = stage
            } else { count += 1}
        }
            
        for i in 1...N {
            if i == preStage && result[i] == 0 { result[i] = 1 }
        }
                
        print(result[1...N]
            .enumerated()
            .map { (i,e) in (index: i, failure: e) }
            .sorted { o1, o2 in
                if o1.failure == o2.failure { return  o1.index < o2.index }
                else { return o1.failure > o2.failure } }
            .map { $0.index + 1 }
        )
    }
    
    func testPrimaryKey() throws {
        let relation = [["100","ryan","music","2"],["200","apeach","math","2"],["300","tube","computer","3"],["400","con","computer","4"],["500","muzi","music","3"],["600","apeach","music","2"]]
        
        var columns: [[String]] = []
        let numberOfRows = relation.count
        
        for i in 0..<relation[0].count {
            columns.append(relation.map { $0[i] })
        }
        
        var result: [String] = []
                
        func dfs(depth: Int, start: Int, combi: [Int]) {
            if depth == 0 {
                
                var combiKeys: [String] = []
                (0..<numberOfRows).forEach { i in
                    combiKeys.append(combi.map { columns[$0][i] }.reduce("") { String($0) + String($1) })
                }
        
                if combiKeys.count == Set(combiKeys).count {
                    let idx = combi.reduce("") { String($0)+String($1) }
                    
                    if result.filter({ idx.contains($0) }).count == 0 {
                        result.append(idx)
                    }
                }
            }
            
            for i in start..<columns.count {
                var newCombi = combi
                newCombi.append(i)
                dfs(depth: depth-1, start: i+1, combi: newCombi)
            }
        }
        
        (1...columns.count).forEach { dfs(depth: $0, start: 0, combi: []) }
        
        print("result",result)
    }
    
    func testMukbang() throws {
        let food_times = [3,1,2]
        let k: Int64 = 5
        var target: Int64 = k
        
        var foods = food_times
            .enumerated()
            .map { (index: $0.offset, time: $0.element) }
            .sorted { o1,o2 in o1.time < o2.time }
        
        var count = 0
        
        while target / Int64(foods.count) > 0  {
            let size = foods.count
            let foodTime = foods[0].time
            
            while foods[0].time <= foodTime { foods.removeFirst() }
            
            let time = Int64(size * (foodTime-count))
            target -= time
            count += foodTime
            
            if foods.count == 0 { break }
        }
        
        if foods.count == 0 { print(-1) }
        print(foods.sorted { o1,o2 in o1.index < o2.index }[Int(target % Int64(foods.count))].index+1)
        
    }
}
