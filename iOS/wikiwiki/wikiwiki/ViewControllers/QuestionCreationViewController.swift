//
//  QuestionCreationViewController.swift
//  wikiwiki
//
//  Created by Brian Lin on 10/13/18.
//  Copyright © 2018 pblin@umich.edu. All rights reserved.
//

import Foundation
import UIKit

public class QuestionCreationViewController: UIViewController {
    
    private var titleLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    private var inputField: UITextView = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    private let actionButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    private var accentColor: UIColor = UIColor()

    public init(title: String, actionLabel: String, color: UIColor) {
        super.init(nibName: nil, bundle: nil)
        self.titleLabel.text =  title
        self.actionButton.setTitle(actionLabel, for: .normal)
        self.accentColor = color
    }
    
    public override func viewDidLoad() {
        view.backgroundColor = .white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(tapGesture)
        
        setUpView()
        setUpConstraints()
    }
    
    @objc
    private func tapped() {
        print("tapped")
        inputField.resignFirstResponder()
    }
    
    private func setUpView() {
        titleLabel.text = "Enter Your Question"
        titleLabel.font = UIFont(name: "Helvetica Neue", size: 30)
        titleLabel.textColor = accentColor
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        inputField.textAlignment = .center
        inputField.textColor = accentColor
        inputField.font = UIFont(name: "Helvetica Neue", size: 40)
        inputField.text = ""
        view.addSubview(inputField)

        actionButton.setTitle("Add Options", for: .normal)
        actionButton.setTitleColor(accentColor, for: .normal)
        actionButton.setTitleColor(.white, for: .highlighted)
        actionButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 20)
        actionButton.backgroundColor = .clear
        actionButton.layer.borderWidth = 1
        actionButton.layer.borderColor = accentColor.cgColor
        actionButton.layer.cornerRadius = 5

        view.addSubview(actionButton)
    }
    
    private func setUpConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
        inputField.heightAnchor.constraint(equalToConstant: 200).isActive = true
        inputField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputField.becomeFirstResponder()
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
