//
//  Question.swift
//  wikiwiki
//
//  Created by Brian Lin on 10/13/18.
//  Copyright © 2018 pblin@umich.edu. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol QuestionProtocol {
    var question: String { get set }
    var choice_1: String { get set }
    var choice_2: String { get set }
    var categories: [Category]? { get set }
    var question_id: String? { get }
    var remainingSeconds: String? { get }
}

public class Question: QuestionProtocol {
    
    public var question: String
    public var choice_1: String
    public var choice_2: String
    public private(set) var question_id: String?
    public private(set) var remainingSeconds: String?
    public var categories: [Category]?
    
    public init(question: String, choice_1: String, choice_2: String) {
        self.question = question
        self.choice_1 = choice_1
        self.choice_2 = choice_2
    }
    
    public func send() {
        let dataManager = DataFetcher(url: "https://bom29zmpy6.execute-api.us-west-1.amazonaws.com/default/mh-create-question")
        dataManager.postData(dataToSend: compiledData())
    }
    
    private func compiledData() -> [String: String] {
        guard let categories = categories else {
            print("Categories not initialized")
            return [:]
        }
        let data: [String : String] = [
            "option1"   : choice_1,
            "option2"   : choice_2,
            "question"  : question,
            "c0"        : categories[0].selected_binary(),
            "c1"        : categories[1].selected_binary(),
            "c2"        : categories[2].selected_binary(),
            "c3"        : categories[3].selected_binary(),
            "c4"        : categories[4].selected_binary(),
            "c5"        : categories[5].selected_binary(),
            "c6"        : categories[6].selected_binary()
        ]
        
        return data
    }
}
