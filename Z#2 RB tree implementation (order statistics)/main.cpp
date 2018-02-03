//
//  main.cpp
//  Z#2 RB tree implementation (order statistics)
//
//  Created by Рома Сорока on 02.02.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

#include <iostream>
#include "RedBlack.hpp"
#include <ctime>

using namespace std;

int main(int argc, const char * argv[]) {
    srand((unsigned int)time(NULL));

    cout<<"<> - means red node\n";
    OrderStatRBtree t2;
    for (int i = 0; i<10; i++) {
        t2.insert(int(rand()%30));
    }
    cout<<"Red-Black Tree: (turned by 90° counterclock-wise)\n";
    t2.printTree();
    cout<<"===================\n";
    
    int k;
    cout<<"Find element with rank: ";
    cin>>k;
    cout<< t2.withRank(k) <<endl;
    
    cout<<"What rank has element: ";
    cin>>k;
    cout<< t2.whatRank(k)<<endl;
    
    return 0;
}
