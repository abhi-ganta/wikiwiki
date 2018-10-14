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
    
    private var titleLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
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
        titleLabel.text = "wikiwiki"
        titleLabel.font = UIFont(name: "Helvetica Neue", size: 25)
        titleLabel.textColor = UIColor.wikiwiki.blue.color()
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        view.addSubview(activeCardView)
    }
    
    private func setUpConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        
        activeCardView.translatesAutoresizingMaskIntoConstraints = false
        activeCardView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        activeCardView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activeCardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        activeCardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
