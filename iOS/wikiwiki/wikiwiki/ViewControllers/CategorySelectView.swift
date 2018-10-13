//
//  CategorySelectView.swift
//  wikiwiki
//
//  Created by Brian Lin on 10/13/18.
//  Copyright © 2018 pblin@umich.edu. All rights reserved.
//

import Foundation
import UIKit

public class CategorySelectView: UIView {
    
    private var titleLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    private let actionButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    private var accentColor: UIColor = UIColor()
    
    public var delegate: QuestionCreationDelegate?
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    }
    
    @objc
    private func tappedButton() {
        delegate?.pressedAction(enteredContent: "")
    }
    
    private func setUpView() {
        titleLabel.font = UIFont(name: "Helvetica Neue", size: 30)
        titleLabel.textColor = accentColor
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
