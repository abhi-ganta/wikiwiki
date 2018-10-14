//
//  QuestionViewerViewController.swift
//  wikiwiki
//
//  Created by Brian Lin on 10/14/18.
//  Copyright © 2018 pblin@umich.edu. All rights reserved.
//

import Foundation
import UIKit

public class QuestionViewerViewController: UIViewController {
    var questionCards: [CommunityQuestionCardView] = [CommunityQuestionCardView]()
    
    public init(questions: [Question]) {
        super.init(nibName: nil, bundle: nil)
        populateCards(questions: questions)
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
