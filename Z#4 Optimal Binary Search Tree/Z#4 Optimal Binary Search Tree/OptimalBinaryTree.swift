//
//  OptimalBinaryTree.swift
//  Z#4 Optimal Binary Search Tree
//
//  Created by Рома Сорока on 06.03.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import Foundation

protocol HasNameAndID {
  var name: String {get}
  var ID: Int {get}
}

class OptimalBinaryTree<KeyType: Equatable & Comparable, ValueType: HasNameAndID> {
  class Node<KeyType: Equatable & Comparable, ValueType: HasNameAndID> {
    var key: KeyType
    var value: ValueType
    
    var positionInFreqArray: Int
    
    var left: Node? {
      didSet {
        left?.parent = self
      }
      
    }
    var right: Node? {
      didSet {
        right?.parent = self
      }
    }
    weak var parent: Node?
    
    init(key: KeyType, value: ValueType, pos: Int) {
      self.key = key
      self.value = value
      self.positionInFreqArray = pos
    }
  }
  
  private(set) var optimalCost = 0
  private var root: Node<KeyType,ValueType>?
  private var vals: [ValueType], freq: [Int]
  private var roots: [[Int]]
  private var nodesCount: Int
  private var keys: [KeyType]
  var maxAccessesBeforeRebuild = 3
  private var numberOfAccessesFromLastRebuild: Int = 0 {
    didSet {
      if numberOfAccessesFromLastRebuild > maxAccessesBeforeRebuild {
        print("Rebuilding")
        root = nil
        makeTree()
        show()
      }
    }
  }
  
  init(keys: [KeyType], values: [ValueType], frequencies: [Int]) {
    guard (values.count == frequencies.count) else {
      fatalError("values.count != frequencies.count")
    }
    
    nodesCount = values.count
    self.keys = keys
    vals = values
    freq = frequencies
    roots = [[Int]](repeating:[Int](repeating: -1, count: nodesCount) , count: nodesCount)

    makeTree()
  }
  
  private func makeTree() {
    roots = [[Int]](repeating:[Int](repeating: -1, count: nodesCount) , count: nodesCount)
    var costs: [[Int]] = [[Int]](repeating:[Int](repeating: Int.max, count: nodesCount), count: nodesCount)
    
    for i in 0..<vals.count {
      costs[i][i] = freq[i]
      roots[i][i] = i
    }
    
    var j, c: Int
    for numberOfNodes in 2...nodesCount{
      for i in 0...(nodesCount - numberOfNodes) {
        j = i + numberOfNodes - 1
        
        for r in i...j {
          c = (r > i ? costs[i][r-1]: 0) +
            (r < j ? costs[r+1][j]: 0) +
            sum(freq, i, j)
          if c < costs[i][j] {
            costs[i][j] = c
            roots[i][j] = r
          }
        }
      }
    }
    optimalCost = costs[0][nodesCount-1]
    buildTree()
  }
  
  private func sum(_ freq: [Int], _ i: Int, _ j:Int) -> Int {
    var s = 0
    for k in i...j {
      s += freq[k]
    }
    return s
  }
  
  private func buildTree() {
    recursiveInsert(0,vals.count - 1)
  }
  
  private func recursiveInsert(_ i: Int,_ j: Int){
    if i <= j {
      insert(key: keys[roots[i][j]], value: vals[roots[i][j]], pos: roots[i][j])
      recursiveInsert(i, roots[i][j] - 1)
      recursiveInsert(roots[i][j] + 1, j)
    }
  }
  
  private func insert(key: KeyType, value: ValueType, pos: Int){
    var i = root, p :Node<KeyType, ValueType>?
    while i != nil {
      p = i
      if key <= i!.key {
        i = i!.left
      } else {
        i = i!.right
      }
    }
    if p == nil {
      root = Node<KeyType,ValueType>(key: key, value: value, pos: pos)
    } else {
      if key <= p!.key {
        p!.left = Node<KeyType,ValueType>(key: key,value: value, pos: pos)
      } else {
        p!.right = Node<KeyType,ValueType>(key: key, value: value, pos: pos)
      }
    }
    
  }
  
  
  func show(){
    showLevel(node: root, level: 0)
  }
  
  private func showLevel(node: Node<KeyType,ValueType>?, level: Int){
    if node != nil {
      showLevel(node: node!.right, level: level + 1)
      for _ in 0..<level {
        print("  ",terminator:"")
      }
      print("\(node!.value.name)|\(node!.value.ID)|\(freq[node!.positionInFreqArray])")
      showLevel(node: node!.left, level: level + 1)
    }
  }
  
  subscript (key: KeyType) -> ValueType?{
    var i = root
    while i !== nil && i!.key != key {
      if key < i!.key {
        i = i!.left
      } else {
        i = i!.right
      }
    }
    
    if let foundElem = i {
      freq[foundElem.positionInFreqArray] += 1
      numberOfAccessesFromLastRebuild += 1
      //return foundElem.value as ValueType?
      return Optional<ValueType>(foundElem.value)
    } else {
      return nil
    }
  }
}
