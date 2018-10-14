//
//  main.cpp
//  wiki
//
//  Created by Austin Wong on 10/13/18.
//  Copyright © 2018 Austin Wong. All rights reserved.
//

#include <cstdlib>
#include <iostream>
#include <fstream>
#include "time.h"
#include <random>
#include <unordered_set>

#define MAX_POST_LENGTH  5
#define NUM_CATEGORIES  7

using namespace std;

string genPostID(const int len) {
    const char alphanum[] =
    "0123456789"
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    "abcdefghijklmnopqrstuvwxyz";
    string ret;
    for (int i = 0; i < len; ++i) {
        ret += alphanum[rand() % (sizeof(alphanum) - 1)];
    }
    return ret;
}

int vote(int qlen, int alen, unordered_set<int> &category){
    // Brian's likelihood of choosing based on q&a length (0 to 90 chars)
    double choose_perc_qa[10] = {0.85, 0.9, 0.9, 0.8, 0.7, 0.6, 0.5, 0.35, 0.25, 0.15};
    
    // Brian's likelihood of choosing based on chosen categories (activity, edu, ent, food, shop, tech, other)
    double choose_perc_cat[7] = {0.7, 0.8, 0.5, 0.6, 0.4, 0.9, 0.4};
    
    double percentage;
    for(auto it=category.begin(); it!=category.end(); ++it){
        percentage += 0.85 * (choose_perc_cat[*it]/category.size());            // 85% of decision based on categories
    }
    percentage += (0.075*choose_perc_qa[qlen] + 0.075*choose_perc_qa[alen]);    // 2*7.5% of decision based upon q&a length
    
    if(percentage > 0.55){
        return 1;
    }
    else{
        return 0;
    }
}

int main() {
    ofstream wiki_out;
    wiki_out.open ("wiki_out.txt");
    wiki_out << "poll_id,alen,c0,c1,c2,c3,c4,c5,c6,qlen,voted\n";
    srand(time(NULL));
    
    
    // QnA Length Generation
    //Question
    default_random_engine qgenerator;
    discrete_distribution<int> distribution {10,20,20,15,10,10,8,4,2,1};    // probability for tens value of num chars
    
    default_random_engine cat_gen;
    discrete_distribution<int> cprob_dist {50,35,10,5};  // probabilty for # of categories
    for(int i=0; i<1000; ++i){
        string poll_id = genPostID(MAX_POST_LENGTH);
        int qtens = distribution(qgenerator);
        int qones;
        if(qtens == 0){
            qones = rand() % 6 + 4;    // 4 to 9
        }
        else{
            qones = rand() % 10;     // 0 to 9
        }
        int qlen = 10*qtens + qones;
        
        //Answer
        int atens = 20;
        while (atens > qtens) {
            atens = distribution(qgenerator);
        }
        int aones = 0;
        if(atens < 1){
            while (aones < 4) {
                aones = rand() % 6 + 4;
            }
        }
        else{
            aones = rand() % 10;
        }
        int alen = 10*atens +aones;
        
        unordered_set<int> category;    // contains category indices
        int other = rand() % 7; //0 to 6
        
        if(other < 6){          // 6/7 chance for not other
            //cout << cprob_dist(cat_gen) << endl;
            int num_category = cprob_dist(cat_gen);
            if (num_category == 0) {        // 1 category
                category.insert(other);
            }
            else if (num_category == 1){    // 2 categories
                category.insert(other);
                int second = rand() % 6;
                while (category.find(second) != category.end()) {
                    second = rand() % 6;
                }
                category.insert(second);
            }
            else if (num_category == 2){
                category.insert(other);
                int second = rand() % 6;
                while (category.find(second) != category.end()) {   // if second already exists
                    second = rand() % 6;
                }
                category.insert(second);
                int third = rand() % 6;
                while (category.find(third) != category.end()) {
                    third = rand() % 6;
                }
                category.insert(third);
            }
            else{
                category.insert(other);
                int second = rand() % 6;
                while (category.find(second) != category.end()) {
                    second = rand() % 6;
                }
                category.insert(second);
                int third = rand() % 6;
                while (category.find(third) != category.end()) {
                    third = rand() % 6;
                }
                category.insert(third);
                int fourth = rand() % 6;
                while (category.find(fourth) != category.end()) {
                    fourth = rand() % 6;
                }
                category.insert(fourth);
            }
            
        }
        else{    // 1/7 chance for other; other implies only 1 category
            int voted = -1;
            int temp = rand() % 20;
            if(temp < 3){
                voted = 1;
            }
            else{
                voted = 0;
            }
            wiki_out << poll_id << "," << alen << ",0,0,0,0,0,0,1," << qlen << "," << voted << '\n';
            continue;
        }
        
        int voted = vote(qlen, alen, category);
        wiki_out << poll_id << "," << alen << ",";
        for(int i=0; i<NUM_CATEGORIES; ++i){
            if (category.find(i) == category.end()) {       // category is NOT chosen
                wiki_out << "0,";
            }
            else{                                           // category is chosen
                wiki_out<<"1,";
            }
        }
        wiki_out << qlen << "," << voted << '\n';
    }
    
    return 0;
}
