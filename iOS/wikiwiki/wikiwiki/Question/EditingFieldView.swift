//
//  QuestionView.swift
//  wikiwiki
//
//  Created by Brian Lin on 10/13/18.
//  Copyright © 2018 pblin@umich.edu. All rights reserved.
//

import Foundation
import UIKit

public class EditingField: UIView, ContentViewProtocol {
    
    private var titleLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    private var inputField: UITextView = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    private let actionButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    private var accentColor: UIColor = UIColor()
    
    public var delegate: QuestionCreationDelegate?
    
    public init(title: String, actionLabel: String, color: UIColor) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        backgroundColor = .white
        self.titleLabel.text =  title
        self.actionButton.setTitle(actionLabel, for: .normal)
        self.accentColor = color
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(tapGesture)
        
        setUpView()
        setUpConstraints()
    }
    
    @objc
    private func tapped() {
        print("tapped")
        inputField.resignFirstResponder()
    }
    
    @objc
    private func tappedButton() {
        if (inputField.text != "") {
            delegate?.pressedAction(enteredContent: inputField.text)
        } else {
            delegate?.presentError()
        }
    }
    
    private func setUpView() {
        titleLabel.font = UIFont(name: "Helvetica Neue", size: 30)
        titleLabel.textColor = accentColor
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        
        inputField.textAlignment = .center
        inputField.textColor = accentColor
        inputField.font = UIFont(name: "Helvetica Neue", size: 50)
        inputField.text = ""
        addSubview(inputField)
        
        actionButton.setTitleColor(accentColor, for: .normal)
        actionButton.setTitleColor(.white, for: .highlighted)
        actionButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 20)
        actionButton.backgroundColor = .clear
        actionButton.layer.borderWidth = 1
        actionButton.layer.borderColor = accentColor.cgColor
        actionButton.layer.cornerRadius = 5
        
        actionButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        
        addSubview(actionButton)
    }
    
    private func setUpConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.widthAnchor.constraint(equalTo: widthAnchor, constant: -80).isActive = true
        inputField.heightAnchor.constraint(equalToConstant: 200).isActive = true
        inputField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        inputField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        inputField.becomeFirstResponder()
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        actionButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
