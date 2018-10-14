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
    private var secondaryLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    private var animation: WaitingAnimation = WaitingAnimation()
    
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
        titleLabel.text = "My Question"
        titleLabel.font = UIFont(name: "Helvetica Neue", size: 25)
        titleLabel.textColor = UIColor.wikiwiki.blue.color()
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        view.addSubview(activeCardView)
        
        secondaryLabel.text = "Community Questions"
        secondaryLabel.font = UIFont(name: "Helvetica Neue", size: 25)
        secondaryLabel.textColor = UIColor.wikiwiki.purple.color()
        secondaryLabel.textAlignment = .center
        view.addSubview(secondaryLabel)
        
        animation.startAnimating()
        view.addSubview(animation)
    }
    
    private func setUpConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        
        activeCardView.translatesAutoresizingMaskIntoConstraints = false
        activeCardView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        activeCardView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        activeCardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25).isActive = true
        activeCardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        secondaryLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        secondaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        secondaryLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.widthAnchor.constraint(equalToConstant: 80).isActive = true
        animation.heightAnchor.constraint(equalToConstant: 50).isActive = true
        animation.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animation.topAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height/4).isActive = true
    }
}
