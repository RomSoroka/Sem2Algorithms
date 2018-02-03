#include "RedBlack.hpp"
#include <iostream>

using namespace std;

// order statistic stuff

// returns rank of given element if found, else INT_MAX // O(log n)
int OrderStatRBtree::whatRank(int k){
    RBnode* x = find(k);
    if (x == nil_) {
        return INT_MAX;
    } else {
        int rank = x->left->size + 1;
        RBnode* y = x;
        while (y != root) {
            if (y == y->p->right) {
                rank += y->p->left->size + 1;
            }
            y = y->p;
        }
        return rank;
    }
}
// returns element with given rank // O(log n)
int OrderStatRBtree::withRank(int i){
    return OS_Select(root, i)->k;
}

RBnode* OrderStatRBtree::OS_Select(RBnode* x, int i){
    int rank = x->left->size + 1;
    if (i == rank)
        return x;
    else if (i < rank)
        return OS_Select(x->left, i);
    else return OS_Select(x->right, i - rank);
}

RBnode *OrderStatRBtree::minNode(RBnode * start_node)
{
    if (start_node != nil_)
    {
        while (start_node->left != nil_)
            start_node = start_node->left;
    }
    return start_node;
}

void OrderStatRBtree::changeAllParrentSizes(RBnode *n, int by){
    n = n->p;
    while (n != nil_) {
        n->size += by;
        n = n->p;
    }
}

// returns nil if not found
RBnode *OrderStatRBtree::find(const int &x){
    RBnode *p = root;
    while(p!=nil_)
    {
        if(p->k==x)
            return p;
        else if(p->k<x)
            p=p->right;
        else
            p=p->left;
        
    }
    return nil_;
}

void OrderStatRBtree::del(const int& x)
{
    if(root==nil_)
    {
        cout<<"\nEmpty Tree." ;
        return ;
    }
    
    RBnode *p = find(x);
    
    if(p == nil_)
    {
        cout<<"\nElement Not Found.\n";
        return ;
    }
    else
    {
        
        changeAllParrentSizes(p, -1);
        
        RBnode *y = p, *x = nullptr;
        short original_color = p->color;
        if (p->left == nil_) //1)
        {
            x = p->right;
            replace(p, p->right);
        }
        else if (p->right == nil_) //1)
        {
            x = p->left;
            replace(p, p->left);
        }
        else //2) 
        {
            y = minNode(p->right);
            x = y->right;
            original_color = y->color;
            int min_data = y->k;
            replace(y, y->right);
            p->k = min_data;
        }
        if (original_color == BLACK)
            fixAfterDelete(x);
    }
}

 

void OrderStatRBtree::replace(RBnode * u, RBnode * v)
{
    if (u->p == nil_)
        root = v;
    else if (u->p->left == u)
        u->p->left = v;
    else
        u->p->right = v;
    v->p = u->p;
    delete u;
}

void OrderStatRBtree::fixAfterDelete(RBnode * x)
{
    while (x != root && x->color == BLACK)
    {
        if (x == x->p->left)
        {
            RBnode *br = x->p->right;
            if (br->color == RED)
            {
                br->color = BLACK;
                x->p->color = RED;
                rotate_left(x->p);
                br = x->p->right;
            }
            if (br->left->color == BLACK &&
                br->right->color == BLACK)
            {
                br->color = RED;
                x = x->p;
            }
            else {
                if (br->right->color == BLACK)
                {
                    br->left->color = BLACK;
                    br->color = RED;
                    rotate_right(br);
                    br = x->p->right;
                }
                br->color = x->p->color;
                x->p->color = BLACK;
                br->right->color = BLACK;
                rotate_left(x->p);
                x = root;
            }
        }
        else
        {
            RBnode *br = x->p->left;
            if (br->color == RED)
            {
                br->color = BLACK;
                x->p->color = RED;
                rotate_right(x->p);
                br = x->p->left;
            }
            if (br->left->color == BLACK &&
                br->right->color == BLACK)
            {
                br->color = RED;
                x = x->p;
            }
            else {
                if (br->left->color == BLACK)
                {
                    br->right->color = BLACK;
                    br->color = RED;
                    rotate_left(br);
                    br = x->p->left;
                }
                br->color = x->p->color;
                x->p->color = BLACK;
                br->left->color = BLACK;
                rotate_right(x->p);
                x = root;
            }
        }
    }
    x->color = BLACK;
}


void OrderStatRBtree::rotate_left(RBnode *n)
{
    RBnode *pivot = n->right;
    n->right = pivot->left;
    if (pivot->left != nil_)
        pivot->left->p = n;
    pivot->p = n->p;
    if (n->p == nil_)
        root = pivot;
    else if (n == n->p->left)
        n->p->left = pivot;
    else n->p->right = pivot;
    pivot->left = n;
    n->p = pivot;
    
    // size implementation
    pivot->size = n->size;
    n->size = n->left->size + n->right->size + 1;

}

void OrderStatRBtree::rotate_right(RBnode *n)
{
    RBnode *pivot = n->left; // x = y->r
    n->left = pivot->right;
    if (pivot->right != nil_)
        pivot->right->p = n;
    pivot->p = n->p;
    if (n->p == nil_)
        root = pivot;
    else if (n == n->p->left)
        n->p->left = pivot;
    else n->p->right = pivot;
    pivot->right = n;
    
    n->p = pivot;
    
    // size implementation
    pivot->size = n->size;
    n->size = n->left->size + n->right->size + 1;
    
    
}


RBnode *OrderStatRBtree::grandp(RBnode *n)
{
    if ((n != nil_) && (n->p != nil_))
        return n->p->p;
    else
        return nil_;
}

RBnode *OrderStatRBtree::uncle(RBnode *n)
{
    RBnode *g = grandp(n);
    if (g == nil_)
        return nil_; // No grandp means no uncle
    if (n->p == g->left)
        return g->right;
    else
        return g->left;
}

void OrderStatRBtree::insert_case1(RBnode *n) //n == root - recolor
{
    if (n->p == nil_)
        n->color = BLACK;
    else
        insert_case2(n);
}

void OrderStatRBtree::insert_case2(RBnode *n) //if p - black then ok
{
    if (n->p->color == BLACK)
        return; // Tree is still valid
    else
        insert_case3(n);
}

void OrderStatRBtree::insert_case3(RBnode *n) //p - red case 1.
{
    RBnode *u = uncle(n), *g;
    
    if ((u != nil_) && (u->color == RED)) {
        n->p->color = BLACK;
        u->color = BLACK;
        g = grandp(n);
        g->color = RED;
        insert_case1(g);
    } else {
        insert_case4(n);
    }
}

void OrderStatRBtree::insert_case4(RBnode *n) //p - red, u - black (case 2. to case 3.)
{
    RBnode *g = grandp(n);
    
    if ((n == n->p->right) && (n->p == g->left)) {
        rotate_left(n->p);
        n = n->left;
    } else if ((n == n->p->left) && (n->p == g->right)) {
        rotate_right(n->p);
        n = n->right;
    }
    insert_case5(n);
}

void OrderStatRBtree::insert_case5(RBnode *n) //case 3.
{
    RBnode *g = grandp(n);
    
    n->p->color = BLACK;
    g->color = RED;
    if ((n == n->p->left) && (n->p == g->left)) {
        rotate_right(g);
    } else { /* (n == n->p->right) && (n->p == g->right) */
        rotate_left(g);
    }
}

//public

void OrderStatRBtree::printTree()
{
    display(root, 0);
}

void OrderStatRBtree::display(RBnode* p, unsigned char h){
    if (p!=nil_) {
        display(p->right, h+1);
        for (int  i= 0; i<h; i++) {
            cout<<"   ";
        }
        if (p->color == RED) cout<<"<"<<p->k<<"|"<<p->size<<">"<<endl;
        else cout<<' '<<p->k<<"|"<<p->size<<' '<<endl;
        display(p->left, h+1);
    }
}

void OrderStatRBtree::insert(const int& z)
{
    RBnode *p = root,*q = nil_;
    RBnode *t = new RBnode(z, RED , nil_, nil_);
    if(root==nil_)
    {
        root=t;
        t->p=nil_;
    }
    else
    {
        while(p!=nil_)
        {
            q=p;
            if(p->k==t->k) return;
            if(p->k<t->k)
                p=p->right;
            else
                p=p->left;
            
        }
        t->p=q;
        if(q->k<t->k)
            q->right=t;
        else
            q->left=t;
    }
    insert_case1(t);
    changeAllParrentSizes(t, 1);


}

