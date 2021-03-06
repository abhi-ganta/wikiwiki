//
//  CategorySelectView.swift
//  wikiwiki
//
//  Created by Brian Lin on 10/13/18.
//  Copyright © 2018 pblin@umich.edu. All rights reserved.
//

import Foundation
import UIKit

public class CategorySelectView: ContentView {
    
    private var titleLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    private let actionButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    private var accentColor: UIColor = UIColor.wikiwiki.purple.color()
    private var rows: [SelectionRow] = [
        SelectionRow(option: "Activities", accent: UIColor.wikiwiki.purple.color()),
        SelectionRow(option: "Education", accent: UIColor.wikiwiki.purple.color()),
        SelectionRow(option: "Entertainment", accent: UIColor.wikiwiki.purple.color()),
        SelectionRow(option: "Food", accent: UIColor.wikiwiki.purple.color()),
        SelectionRow(option: "Shopping", accent: UIColor.wikiwiki.purple.color()),
        SelectionRow(option: "Tech", accent: UIColor.wikiwiki.purple.color()),
        SelectionRow(option: "Other", accent: UIColor.wikiwiki.purple.color())
    ]
    
    public init(withOption: String) {
        super.init()
        
        titleLabel.text = "Select Category"
        actionButton.setTitle("Finish", for: .normal)
        
        setUpView()
        setUpConstraints()
    }
    
    private func compiledData() -> [Category] {
        var categories = [Category]()
        for row in rows {
            if row.selected {
                categories.append(Category(cateogry_string: row.categoryLabel.text ?? "", selected: true))
            } else {
                categories.append(Category(cateogry_string: row.categoryLabel.text ?? "", selected: false))
            }
        }
        
        return categories
    }
    
    @objc
    private func tappedButton() {
        delegate?.pressedAction(enteredContentDictionary: compiledData())
    }
    
    private func setUpConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        actionButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80).isActive = true
        
        rows[0].translatesAutoresizingMaskIntoConstraints = false
        rows[0].widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        rows[0].leftAnchor.constraint(equalTo: leftAnchor, constant: 60).isActive = true
        rows[0].heightAnchor.constraint(equalToConstant: 60).isActive = true
        rows[0].topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50).isActive = true
        
        for i in 1..<7 {
            rows[i].translatesAutoresizingMaskIntoConstraints = false
            rows[i].widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            rows[i].leftAnchor.constraint(equalTo: leftAnchor, constant: 60).isActive = true
            rows[i].heightAnchor.constraint(equalToConstant: 60).isActive = true
            rows[i].topAnchor.constraint(equalTo: rows[i-1].bottomAnchor, constant: 2).isActive = true
        }
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
        
        rows.forEach {
            addSubview($0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
