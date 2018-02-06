#include <iostream>
#include <vector>
#include <cmath>
#include <random>

using std::cout;
using std::cin;
using std::vector;
using std::endl;
using std::fill;


bool isPrime(int n)
{
    int sqrtn = sqrt(n);
    for (int i = 2; i <= sqrtn; i++)
    {
        if (n % i == 0)
            return false;
    }
    
    return true;
}

//given a number n, find the next closest prime number above n
int findNextPrime(int n)
{
    while (!isPrime(n)) {
        n++;
    }
    return n;
}



int hash(int a, int k, int b, int bigPrime, int tableSize) {
    return ((a*k + b) % bigPrime) % tableSize;
}

class Bucket {
    int bigPrime = 10007;
    int a = rand() % bigPrime, b = rand() % bigPrime;
    vector<int> innerHashTable;
    
    
public:
    
    size_t size() const{
        return innerHashTable.size();
    }
    
    void add(int elem){
        // 1. double the capacity
        // 2. rehash all items
        // 3. place the item
        // 3.1 if collision -> randomize a,b -> step 2
        
        // size == 0 or 1 -> size += 1 else size = size^2 so that probability of collision less then 1/2 (so we save time)
        int newSize = pow(sqrt(innerHashTable.size()) + 1, 2);
        vector<int> tempTable(newSize);
        
        bool rebuild = false;
        do {
            fill(tempTable.begin(), tempTable.end(), INT_MAX);
            if (rebuild) {
                a = rand() % bigPrime;
                b = rand() % bigPrime;
            }
            rebuild = false;
            for (auto it = innerHashTable.begin(); it != innerHashTable.end(); it++)
            {
                if (*it != INT_MAX)
                {
                    int h = hash(a, *it, b, bigPrime, int(tempTable.size()));
                    if (tempTable[h] == INT_MAX)
                    {
                        tempTable[h] = *it;
                    } else { //collision
                        rebuild = true;
                        break;
                    }
                    
                } // else next step
                
            }
            
            int h = hash(a, elem, b, bigPrime, int(tempTable.size()));
            if (tempTable[h] == INT_MAX)
            {
                tempTable[h] = elem;
            } else if (elem == tempTable[h]) { //collision
                return;
            } else
                rebuild = true;
            
        } while (rebuild);
        
        innerHashTable = tempTable;
    }
    
    void show() const {
        for (auto it = innerHashTable.begin(); it != innerHashTable.end(); it++) {
            if (*it == INT_MAX) {
                cout<< "* ";
            } else {
                cout<< *it <<" ";
            }
        }
        cout<<endl;
    }
    
    // returns element at given key
    // if not found returns INT_MAX
    int find(int key) const {
        if (!innerHashTable.size()) {
            return INT_MAX;
        }
        int innerHash = hash(a,key,b,bigPrime,(int)innerHashTable.size());
        return innerHashTable[innerHash];
    }
    
};

class PerfectHashTable {
    int A, B;
    vector<Bucket> outerHashTable;
    const int bigPrime = 10007;
    int sumAllBucketSizes = 0;
    int tableSize = 0;
    
    void buildTable(const vector<int> &values, int capacityConstant){
        do
        {
            outerHashTable.clear();
            outerHashTable.resize(tableSize);
            
            sumAllBucketSizes = 0;
            A = rand() % bigPrime;
            B = rand() % bigPrime;
            int i = 0;
            for (auto it = values.begin(); it != values.end(); it++, i++)
            {
                int h = hash(A, *it, B, bigPrime, (int)outerHashTable.size());
                outerHashTable[h].add(*it);
            }
            for (auto it = outerHashTable.begin(); it != outerHashTable.end(); it++)
                sumAllBucketSizes += it->size();
            
            cout << "one lap\n";
            
            tableSize *= 2;
            
        // rebuild outer table each time sumAllBucketSizes > capacityConstant * values.size()
        // just so if we're really unlucky and a lot of elements hash to the same bucket we don't have a huge waist of space
        } while (sumAllBucketSizes > capacityConstant * values.size());
    }
    
public:
    // ratio == values.size() / outerHashTable.size()
    // capacityConstant determins how big of a waist of memory we are ok with (smaller -> more rebuilds -> more time, but less size); used in buildTable
    PerfectHashTable(const vector<int> &values, int capacityConstant = 10, double ratio = 0.5) {
        tableSize = findNextPrime(sqrt(values.size()));
        buildTable(values, capacityConstant);
    }
    
    // returns INT_MAX if error occured
    int find(int key) const {
        int outerHash = hash(A, key, B, bigPrime, outerHashTable.size());
        int elem = outerHashTable[outerHash].find(key);
        if (elem == INT_MAX) {
            cout<< "ERROR: Element not found" << endl;
        }
        return elem;
    }
    
    void show(){
        for (int i = 0; i < outerHashTable.size(); i++){
            cout<< i <<": ";
            outerHashTable[i].show();
        }
    }
    
};

int main(){
    srand(time(nullptr));
    
//    std::random_device rd;
//    std::mt19937 rng(rd());
//    std::uniform_int_distribution<int> uni(1, 10000);
    
    vector<int> a;
    for (int i = 0; i < 20; i++) {
        a.push_back(rand() % 100);
    }
    
    PerfectHashTable b(a);
    b.show();
    
    cout<< b.find(42);
    
    return 0;
}
