//
//  SelectionRow.swift
//  wikiwiki
//
//  Created by Brian Lin on 10/13/18.
//  Copyright © 2018 pblin@umich.edu. All rights reserved.
//

import Foundation
import UIKit

public class SelectionRow: UIView {
    private var selectionButton = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    private var categoryLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))

    public var selected: Bool = false
    private var accentColor: UIColor = UIColor.wikiwiki.blue.color()
    
    public init(option: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        categoryLabel.text = option
        setUpViews()
    }
    
    private func setUpViews() {
        selectionButton.layer.cornerRadius = 5
        setNotSelected()
        addSubview(selectionButton)
    }
    
    private func setUpConstraints() {
        selectionButton.translatesAutoresizingMaskIntoConstraints = false
        selectionButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        selectionButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        selectionButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        selectionButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.leftAnchor.constraint(equalTo: selectionButton.rightAnchor, constant: 20).isActive = true
        categoryLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        categoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setSelected() {
        selectionButton.backgroundColor = accentColor
    }
    
    private func setNotSelected() {
        selectionButton.backgroundColor = .white
        selectionButton.layer.borderColor = accentColor.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
