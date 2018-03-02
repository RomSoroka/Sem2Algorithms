//
//  SplayTree.swift
//  Z#3: SplayTree
//
//  Created by Рома Сорока on 14.02.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import Foundation

class Node<T: Equatable & Comparable> {
    var dat :T
    var left, right, parent: Node?
    init(_ elem: T) {
        dat = elem
    }
}

class SplayTree<T: Equatable & Comparable>{
    
    var root :Node<T>?
    
    private func addToBottom(_ elem: T) -> Node<T>{
        var i = root, p :Node<T>?
        while i != nil {
            p = i
            if elem <= i!.dat {
                i = i!.left
            } else {
                i = i!.right
            }
        }
        
        let insertElem = Node<T>(elem)
        if elem <= p!.dat {
            p!.left = insertElem
        } else {
            p!.right = insertElem
        }
        insertElem.parent = p
        
        return insertElem
    }
    
    private func _Splay(_ elem: Node<T>){
        
    }
    
    func add(_ elem: T) {
        // if empty tree
        if root == nil {
            root = Node<T>(elem)
            return
        }
        
        // tree not empty
        let insertElem = addToBottom(elem)
        _Splay(insertElem)
        
    }
    
    func delete(_ elem: T) -> Bool {
        return false
    }
    
    func find(elem: T) -> Bool {
        return false
    }
    
    func show(){
        showLevel(node: root, level: 0)
    }
    
    private func showLevel(node: Node<T>?, level: Int){
        if node != nil {
            showLevel(node: node!.right, level: level + 1)
            for i in 0..<level {
                print("  ",terminator:"")
            }
            print(node!.dat)
            showLevel(node: node!.left, level: level + 1)

        }
    }
    
}
