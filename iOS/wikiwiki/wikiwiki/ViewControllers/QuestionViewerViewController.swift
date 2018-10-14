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
    var questionViewerView: CommunityQuestionCardView
    private var questions: [Question]
    
    public init(questions: [Question]) {
        self.questions = questions
        self.questionViewerView = CommunityQuestionCardView(question: questions[0], color: UIColor.wikiwiki.orange.color())
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    public func setupViews() {
        view.addSubview(questionViewerView)
    }
    
    public func setupConstraints() {
        questionViewerView.translatesAutoresizingMaskIntoConstraints = false
        questionViewerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
        questionViewerView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        questionViewerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        questionViewerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
