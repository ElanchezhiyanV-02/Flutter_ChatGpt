#include<bits/stdc++.h>
using namespace std;

int main(){
    pair<int, int> p = {1,2};
    pair<pair<int,int> ,pair<int,int>> p1 = {{1,2},{3,4}};
    //cout<< p1.first.second << p1.second.first;
    // pair<int, int> hlo[3];
    // for(int i =0;i<3;i++){
    //         int a,b;
    //         cin >> a >> b;
    //         hlo[i] = {a,b};
    // } 
    
    // for(auto j : hlo){
    //     cout << j << " ";
    // }
    //cout << hlo[1];

    vector<pair<int,int>> vec;
    vec.push_back({1,2});
    vec.emplace_back(3,4);

    vector<pair<int,int>>::iterator i = vec.begin();
    // i++;
    // cout << (*i).first << " ";
      auto it = vec.end();
    //  it--;
    //  cout << (*it).second;
    // auto it;
     for(it--;it >= vec.begin(); it--){
        cout<< (*it).second << " ";
     }

    vector<int> v{1,2,3,4,5,6};
    v.erase(v.begin()+1,v.begin() + 5);
    // for(auto k : v){
    //     cout  << "\n"<< k << " ";
    // }
  vector<int> v2(5,20);
  v2.insert(v2.begin() + 1,v.begin(),v.end());
    vector<int> v1(v);
    for(auto k : v2){
        cout  << "\n"<< k << " ";
    }
    
    list<int> ls;
    ls.push_front(2);
    for(auto m : ls){
        cout << m;
    }
    stack<int> s;
    s.push(12);
    s.push(24);
    s.pop();

    cout << " " <<s.top();

    queue<int> q;


    set<int> st; // sorted order and  unique elements
    st.insert(1);
    st.insert(1);
    st.insert(4); 

    for(auto it : st){
        cout << " " << it;
    }
    st.erase(4);// delete element 4
    st.count(4); // no of 4's
    auto j = st.find(1); // returns the iterator pointitng to the element 4


    multiset<int> ms; // sorted only and can have duplicate values;

    //unordered set<int> us; // unique only but not sorted;




    map<int , int> app; // {key,value};
    map<int, pair<int, int>> mpp;
    // map stores unique keys only in sorted order
    app.insert({1,2});
    app.insert({2,10});
    
    cout << " "  << app[2];

    auto ikt = app.find(1);
    cout << " " <<(*ikt).second;

}
