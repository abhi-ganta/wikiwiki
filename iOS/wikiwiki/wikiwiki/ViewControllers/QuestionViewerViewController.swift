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
    private var animation: WaitingAnimation = WaitingAnimation()
    private var titleLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))


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
            questions.append(Question(question: card["question"].stringValue, choice_1: card["option1"].stringValue, choice_2: card["option2"].stringValue, uid: card["poll_id"].stringValue, color: UIColor.wikiwiki_randomColor(), count1: card["count1"].intValue, count2: card["count2"].intValue))
        }
        
        return questions
    }
    
    public override func viewDidLoad() {
        view.backgroundColor = .white
        
        DispatchQueue.main.async {
            self.animation.startAnimating()
        }
        view.addSubview(animation)
        
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.widthAnchor.constraint(equalToConstant: 80).isActive = true
        animation.heightAnchor.constraint(equalToConstant: 50).isActive = true
        animation.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animation.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        titleLabel.text = "Answer Questions"
        titleLabel.font = UIFont(name: "Helvetica Neue", size: 25)
        titleLabel.textColor = UIColor.wikiwiki.blue.color()
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
        setupViews()
        setupConstraints()
    }
    
    private func populateCards(questions: [Question]) {
        questions.forEach {
        
            questionCards.append(CommunityQuestionCardView(question: $0, color: $0.color))
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
