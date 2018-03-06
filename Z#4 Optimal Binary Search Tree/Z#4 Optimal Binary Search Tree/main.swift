//
//  main.swift
//  Z#4 Optimal Binary Search Tree
//
//  Created by Рома Сорока on 05.03.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import Foundation

var freq = [Int](), vals = [Int]()

for _ in 0..<10 {
    freq.append(Int(arc4random_uniform(10)))
    vals.append(Int(arc4random_uniform(40)))
}

vals.sort()

var optimalBT = OptimalBinaryTree(values: vals,frequencies: freq)

print("Optimal cost: \(optimalBT.optimalCost)")
optimalBT.show()

