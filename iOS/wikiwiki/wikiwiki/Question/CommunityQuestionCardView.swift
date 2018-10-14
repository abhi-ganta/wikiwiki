//
//  CommunityQuestionCardView.swift
//  wikiwiki
//
//  Created by Brian Lin on 10/14/18.
//  Copyright © 2018 pblin@umich.edu. All rights reserved.
//

import Foundation
import UIKit

public class CommunityQuestionCardView: UIView {
    private var titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    private var subtitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    private var choice1: SelectionRow
    private var choice2: SelectionRow
    
    private var question_stored: Question
    
    public init(question: Question, color: UIColor) {
        question_stored = question
        choice1 = SelectionRow(option: question.choice_1, accent: .white)
        choice2 = SelectionRow(option: question.choice_2, accent: .white)

        super.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        titleLabel.text = question.question
        subtitleLabel.text = ""
        choice1.delegate = self
        choice2.delegate = self
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
        
//        choice1label.font = UIFont(name: "Helvetica Neue", size: 15)
//        choice1label.textColor = .white
//        choice1label.textAlignment = .left
//        choice1label.numberOfLines = 0
        addSubview(choice1)
        
//        choice2label.font = UIFont(name: "Helvetica Neue", size: 15)
//        choice2label.textColor = .white
//        choice2label.textAlignment = .left
//        choice2label.numberOfLines = 0
        addSubview(choice2)
    }
    
    private func setUpConstraints() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -40).isActive = true
        subtitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.heightAnchor.constraint(equalToConstant: 120).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -80).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10).isActive = true
        
        choice1.translatesAutoresizingMaskIntoConstraints = false
        choice1.heightAnchor.constraint(equalToConstant: 60).isActive = true
        choice1.widthAnchor.constraint(equalTo: widthAnchor, constant: -20).isActive = true
        choice1.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        choice1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        
        choice2.translatesAutoresizingMaskIntoConstraints = false
        choice2.heightAnchor.constraint(equalToConstant: 60).isActive = true
        choice2.widthAnchor.constraint(equalTo: widthAnchor, constant: -20).isActive = true
        choice2.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        choice2.topAnchor.constraint(equalTo: choice1.bottomAnchor, constant: 5).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func dismiss() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: {
                self.center.x -= 500
//                self.alpha = 0
            }, completion: { success in
                self.removeFromSuperview()
            })
        }
    }
}

extension CommunityQuestionCardView: SelectionRowDelegateProtocol {
    public func pressedSelecionButton() {
        print("selected")
        if choice1.selected {
            question_stored.selectedOption = 1
        } else if choice2.selected {
            question_stored.selectedOption = 2
        }
//        print(question_stored.vote())
        let total = question_stored.option1_count + question_stored.option2_count
        choice1.categoryLabel.text = "\(question_stored.option1_count / total * 100)%"
        choice2.categoryLabel.text = "\(question_stored.option2_count / total * 100)%"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.dismiss()

        })
    }
    
    
}
