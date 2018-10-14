//
//  QuestionViewerViewController.swift
//  wikiwiki
//
//  Created by Brian Lin on 10/14/18.
//  Copyright © 2018 pblin@umich.edu. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

public class QuestionViewerViewController: UIViewController {
    private var questionCards: [CommunityQuestionCardView] = [CommunityQuestionCardView]()
    fileprivate let fetcher = DataFetcher(url: "https://bom29zmpy6.execute-api.us-west-1.amazonaws.com/default/mh-retrieve?uid=brian")

    public init() {
        super.init(nibName: nil, bundle: nil)
        fetcher.delegate = self
        fetcher.getData()
    }
    
    private func retrievedData(data: JSON) -> [Question] {
        var questions = [Question]()
        let cardsArray = data["finalCardArr"].arrayValue
        for card in cardsArray {
            questions.append(Question(question: card["question"].stringValue, choice_1: card["option1"].stringValue, choice_2: card["option2"].stringValue, uid: card["uid"].stringValue))
        }
        
        return questions
    }
    
    public override func viewDidLoad() {
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    private func populateCards(questions: [Question]) {
        questions.forEach {
            questionCards.append(CommunityQuestionCardView(question: $0, color: UIColor.wikiwiki.orange.color()))
        }
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        questionCards.forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        questionCards.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 400).isActive = true
            $0.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QuestionViewerViewController: DataFetcherDelegateProtocol {
    public func didReceiveData() {
        print(fetcher.data)
        populateCards(questions: retrievedData(data: fetcher.data!))
    }
}
