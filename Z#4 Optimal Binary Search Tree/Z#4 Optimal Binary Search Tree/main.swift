//
//  main.swift
//  Z#4 Optimal Binary Search Tree
//
//  Created by Рома Сорока on 05.03.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import Foundation

let data = MyData(fileName: "input.txt")

var freq = [Int]()
for _ in 0..<data.disciplines.count {
  freq.append(Int(arc4random_uniform(5)))
}

data.disciplines.sort { $0.name < $1.name }
var names = [String]()
for dis in data.disciplines {
  names.append(dis.name)
  
}

var discByName = OptimalBinaryTree(keys: names, values: data.disciplines, frequencies: freq)
print("""
  Disciplines sorted by name
  Optimal cost: \(discByName.optimalCost)
  -----------------------------------
  """)
discByName.show()
print("\n")
print(discByName["TeorAlgo"]!.ID)
print(discByName["TeorAlgo"]!.ID)
print(discByName["TeorAlgo"]!.ID)
print(discByName["TeorAlgo"]!.ID)


data.disciplines.sort { $0.ID < $1.ID }
var IDs = [Int]()
for dis in data.disciplines {
  IDs.append(dis.ID)
}
var discByID = OptimalBinaryTree(keys: IDs, values: data.disciplines, frequencies: freq)
print("""
  
  
  Disciplines sorted by ID
  Optimal cost: \(discByID.optimalCost)
  -----------------------------------
  """)
discByID.show()
print("\n")

data.teachers.sort { $0.name < $1.name }
names.removeAll()
freq.removeAll()
for _ in 0..<data.teachers.count-1 {
  freq.append(Int(arc4random_uniform(10)))
}
freq.append(1000000)
for t in data.teachers {
  names.append(t.name)
}
var teachersByName = OptimalBinaryTree(keys: names, values: data.teachers, frequencies: freq)
print("""
  
  
  Teachers sorted by Name
  Optimal cost: \(teachersByName.optimalCost)
  -----------------------------------
  """)
teachersByName.show()
print("\n")

data.teachers.sort { $0.name < $1.name }
IDs.removeAll()
for t in data.teachers {
  IDs.append(t.ID)
}
var teachersByID = OptimalBinaryTree(keys: IDs, values: data.teachers, frequencies: freq)
print("""
  
  
  Teachers sorted by name
  Optimal cost: \(teachersByID.optimalCost)
  -----------------------------------
  """)
teachersByID.show()
print("\n")
