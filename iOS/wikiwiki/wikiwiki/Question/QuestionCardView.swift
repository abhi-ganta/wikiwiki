//
//  QuestionCardView.swift
//  wikiwiki
//
//  Created by Brian Lin on 10/14/18.
//  Copyright © 2018 pblin@umich.edu. All rights reserved.
//

import Foundation
import UIKit

public class QuestionCardView: UIView {
    
    private var titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    private var subtitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    private var choice1label = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    private var choice2label = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    
    public init(question: Question, color: UIColor) {
        super.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
//        titleLabel.text = question.question
        titleLabel.text = "This is a really really really long question that needs answers"
        subtitleLabel.text = "Waiting for responses..."
        choice1label.text = "this is option 1"
        choice2label.text = "this is option 2"

        backgroundColor = color
        
        setUpViews()
        setUpConstraints()
    }
    
    private func setUpViews() {
        layer.cornerRadius = 15
        
        titleLabel.font = UIFont(name: "Helvetica Neue", size: 25)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        addSubview(titleLabel)
        
        subtitleLabel.font = UIFont(name: "Helvetica Neue", size: 15)
        subtitleLabel.textColor = .white
        subtitleLabel.textAlignment = .left
        addSubview(subtitleLabel)
        
        choice1label.font = UIFont(name: "Helvetica Neue", size: 15)
        choice1label.textColor = .white
        choice1label.textAlignment = .left
        choice1label.numberOfLines = 0
        addSubview(choice1label)
        
        choice2label.font = UIFont(name: "Helvetica Neue", size: 15)
        choice2label.textColor = .white
        choice2label.textAlignment = .left
        choice2label.numberOfLines = 0
        addSubview(choice2label)
    }
    
    private func setUpConstraints() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -40).isActive = true
        subtitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.heightAnchor.constraint(equalToConstant: 120).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -40).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10).isActive = true
        
        choice1label.translatesAutoresizingMaskIntoConstraints = false
        choice1label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        choice1label.widthAnchor.constraint(equalTo: widthAnchor, constant: -40).isActive = true
        choice1label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        choice1label.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        
        choice2label.translatesAutoresizingMaskIntoConstraints = false
        choice2label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        choice2label.widthAnchor.constraint(equalTo: widthAnchor, constant: -40).isActive = true
        choice2label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        choice2label.topAnchor.constraint(equalTo: choice1label.bottomAnchor, constant: 5).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
