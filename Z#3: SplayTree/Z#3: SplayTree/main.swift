//
//  main.swift
//  Z#3: SplayTree
//
//  Created by Рома Сорока on 14.02.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import Foundation

var t = SplayTree<Int>()

let rand = [5, 18, 10, 7, 4, 6]

for i in 0..<6 {
    t.add(rand[i])
}

t.show()

print(t.find(elem: 5) ? "Found" : "Not found")
t.show()

print(t.delete(10)  ? "Delition succeded": "Delition failed" )
t.show()

print(t.delete(9)  ? "Delition succeded": "Delition failed")
t.show()
