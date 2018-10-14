//
//  ActiveQuestionViewController.swift
//  wikiwiki
//
//  Created by Brian Lin on 10/13/18.
//  Copyright © 2018 pblin@umich.edu. All rights reserved.
//

import Foundation
import UIKit

public class ActiveQuestionViewController: UIViewController {
    
    private var activeCardView: QuestionCardView!
    
    public convenience init(activeQuestion: Question) {
        self.init(nibName: nil, bundle: nil)
        
        activeCardView = QuestionCardView(question: activeQuestion, color: UIColor.wikiwiki.orange.color())
    }
    
    public override func viewDidLoad() {
        view.backgroundColor = .white
        setUpView()
        setUpConstraints()
    }
    
    private func setUpView() {
        view.addSubview(activeCardView)
    }
    
    private func setUpConstraints() {
        activeCardView.translatesAutoresizingMaskIntoConstraints = false
        activeCardView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        activeCardView.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
        activeCardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        activeCardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
