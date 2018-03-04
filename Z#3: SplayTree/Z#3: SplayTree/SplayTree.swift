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
    var left :Node?
    var right :Node?
    var parent: Node?
    init(_ elem: T) {
        dat = elem
    }
    
}

enum Direction {
    case left
    case right
    func oposite() -> Direction{
        return self == .left ? .right : .left
    }
}

enum SplayVariant {
    case zig
    case zigZig
    case zigZag
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
    
    private func _rotate(_ p: Node<T>, direction: Direction){
        let child = direction == .right ? p.left! : p.right!
        let gp = p.parent
        if gp != nil {
            if p === gp!.left {
                gp!.left = child
            } else {
                gp!.right = child
            }
        }
        child.parent = p.parent
        p.parent = child
        if direction == .right {
            p.left = child.right
            p.left?.parent = p
            child.right = p
        } else {
            p.right = child.left
            p.right?.parent = p
            child.left = p
        }
        
    }
    
    private func _grandParrent(_ elem: Node<T>) -> Node<T>? {
        return elem.parent?.parent
    }
    
    private func _getSplayVariant(_ elem: Node<T>) -> SplayVariant{
        let p = elem.parent!
        if let gp = p.parent {
            if (p === gp.left) == (elem === p.left) { // if both false -> true
                return .zigZig
            } else {
                return .zigZag
            }
        } else {
            return .zig
        }
    }
    
    private func _rotationDirection(_ elem: Node<T>) -> Direction {
        if elem === elem.parent!.left {
            return .right
        } else {
            return .left
        }
    }
    
    private func _Splay(_ elem: Node<T>){
        while let parrent = elem.parent {
            let direction = _rotationDirection(elem)
            switch _getSplayVariant(elem) {
                case .zig:
                    _rotate(parrent, direction: direction)
                case .zigZig:
                    _rotate(parrent.parent!, direction: direction)
                    _rotate(parrent, direction: direction)
                case .zigZag:
                    _rotate(parrent, direction: direction)
                    _rotate(elem.parent!, direction: direction.oposite())

            }
        }
        root = elem
    }
    
    func add(_ elem: T) {
        // if empty tree
        if root == nil {
            root = Node<T>(elem)
            return
        }
        
        let insertElem = addToBottom(elem)
        _Splay(insertElem)
        show()
        print("\n")
    }
    
    private func _findNode(_ elem: T) -> Node<T>? {
        var i = root
        while i !== nil {
            if elem == i!.dat {
                return i
            } else if elem < i!.dat {
                i = i!.left
            } else {
                i = i!.right
            }
        }
        return i
    }
    
    private func _findMax(_ x: Node<T>?) -> Node<T>? {
        if x === nil {
            return nil
        }
        var i = x
        while i!.right != nil {
            i = i!.right!
        }
        return i
    }
    
    func delete(_ elem: T) -> Bool {
        if let node = _findNode(elem) {
            if let nodeToReplaceWith = _findMax(node.left) { // doesn't have a right child
                node.dat = nodeToReplaceWith.dat
                nodeToReplaceWith.parent = nodeToReplaceWith.left
                
            } else {  // no left child
                if node.right != nil {
                    
                    if node.parent != nil {
                        //one of thies will complete
                        node.parent!.right? = node.right!
                        node.parent!.left? = node.right!
                        
                        node.right!.parent = node.parent
                    } else {
                        node.right!.parent = nil
                        root = node.right
                        // deletes automatically coz no references point to it
                    }
                    
                } else { // hanging node
                    node.parent = nil
                }
            } // replaced and deleted, only have to split the perrant
            
            if let newRoot = node.parent {
                _Splay(newRoot)
            }
            
            return true
            
        } else {
            return false
        }
    }
    
    func find(elem: T) -> Bool {
        var i = root
        while i !== nil && i!.dat != elem {
            if elem < i!.dat {
                i = i!.left
            } else {
                i = i!.right
            }
        }
        
        if let foundElem = i {
            _Splay(foundElem)
            
            return true
        } else {
            return false
        }
        
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
