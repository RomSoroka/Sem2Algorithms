//
//  RedBlack.hpp
//  Z#2:AVL + Red-Black tree
//
//  Created by Рома Сорока on 10.09.17.
//  Copyright © 2017 Рома Сорока. All rights reserved.
//

#ifndef RedBlack_h
#define RedBlack_h

#include <stdio.h>

#include<iostream>

using namespace std;

enum color {RED, BLACK};

struct RBnode
{
    int size = 1;
    int k = 0;
    color color = RED;
    RBnode *p = nullptr, *left = nullptr, *right = nullptr;
    RBnode() {}
    RBnode(int k) : k(k), left(0), right(0), color(RED), p(0) {}
    RBnode(int k, int size) : k(k), left(0), right(0), color(RED), p(0), size(size) {}
    RBnode(int k, enum color c, RBnode* l, RBnode* r) : k(k),color(c), left(l), right(r) {}
};

class OrderStatRBtree
{
private:
    RBnode *root, *nil_;
    
    RBnode *grandp(RBnode *n);
    RBnode *uncle(RBnode *n);

    void insert_case1(RBnode *); //for insert
    void insert_case2(RBnode *);
    void insert_case3(RBnode *);
    void insert_case4(RBnode *);
    void insert_case5(RBnode *);

    void replace(RBnode * u, RBnode * v); //for delete
    void fixAfterDelete(RBnode * x);
    RBnode *minNode(RBnode * start_node);

    
    void rotate_left(RBnode *); //for insert and delete
    void rotate_right(RBnode *);
    void changeAllParrentSizes(RBnode*, int);
    RBnode *find(const int &x);
    RBnode* OS_Select(RBnode* x, int i);
    
    void display( RBnode *, unsigned char); //for print
public :
    OrderStatRBtree() {
        nil_ = new RBnode(0, 0);
        root = nil_;
        cout<<"In defaut constructor!\n";
    }
    void insert(const int& z);
    void del(const int&);
    void printTree();
    // order statistic stuff
    int whatRank(int); // returns rank of given element O(log n)
    int withRank(int); // returns element with given rank O(log n)
};
#endif /* RedBlack_h */
