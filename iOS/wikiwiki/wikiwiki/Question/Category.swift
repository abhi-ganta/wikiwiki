//
//  Choice.swift
//  wikiwiki
//
//  Created by Brian Lin on 10/14/18.
//  Copyright © 2018 pblin@umich.edu. All rights reserved.
//

import Foundation

public struct Category {
    var cateogry_string: String
    var selected: Bool
    
    func selected_binary() -> String {
        if selected {
            return "1"
        } else {
            return "0"
        }
    }
}
