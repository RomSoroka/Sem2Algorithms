//
//  main.swift
//  Z#3: SplayTree
//
//  Created by Рома Сорока on 14.02.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import Foundation



print("Hello, World!")

var t = SplayTree<Int>()

for i in 0..<10 {
    t.add(Int(arc4random_uniform(40)))
}

t.show()
