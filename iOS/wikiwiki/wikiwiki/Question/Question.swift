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
    var question_id: String? { get }
    var remainingSeconds: String? { get }
}

public class Question: QuestionProtocol {
    
    public var question: String
    public var choice_1: String
    public var choice_2: String
    public private(set) var question_id: String?
    public private(set) var remainingSeconds: String?
    
    public init(question: String, choice_1: String, choice_2: String) {
        self.question = question
        self.choice_1 = choice_1
        self.choice_2 = choice_2
    }
    
    public func send() {
        let dataManager = DataFetcher(url: "")
        dataManager.postData(dataToSend: compiledData())
    }
    
    private func compiledData() -> JSON {
        let data: JSON = [
            "question"  : question,
            "choice_1"  : choice_1,
            "choice_2"  : choice_2
        ]
        
        return data
    }
}
