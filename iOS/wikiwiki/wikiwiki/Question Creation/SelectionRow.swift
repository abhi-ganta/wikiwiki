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
    public var categoryLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))

    public var selected: Bool = false
    private var accentColor: UIColor

    public var delegate: SelectionRowDelegateProtocol?
    
    public init(option: String, accent: UIColor) {
        self.accentColor = accent
        super.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        categoryLabel.text = option
        setUpViews()
        setUpConstraints()
        selectionButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
    }
    
    @objc
    private func tappedButton() {
        if selected {
            setNotSelected()
            selected = false
        } else {
            setSelected()
            selected = true
        }
    }
    
    private func setUpViews() {
        selectionButton.layer.cornerRadius = 5
        selectionButton.layer.borderWidth = 3
        categoryLabel.textColor = accentColor
        setNotSelected()
        addSubview(selectionButton)
        addSubview(categoryLabel)
    }
    
    public func setUpConstraints() {
        selectionButton.translatesAutoresizingMaskIntoConstraints = false
        selectionButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 40).isActive = true
        selectionButton.heightAnchor.constraint(equalTo: heightAnchor, constant: -20).isActive = true
        selectionButton.widthAnchor.constraint(equalTo: heightAnchor, constant: -20).isActive = true
        selectionButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.leftAnchor.constraint(equalTo: selectionButton.rightAnchor, constant: 20).isActive = true
        categoryLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        categoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setSelected() {
        UIView.animate(withDuration: 0.3, animations: {
            self.selectionButton.backgroundColor = self.accentColor
        }, completion: { success in 
            self.delegate?.pressedSelecionButton()
        })
    }
    
    private func setNotSelected() {
        UIView.animate(withDuration: 0.3, animations: {
            self.selectionButton.backgroundColor = .clear
            self.selectionButton.layer.borderColor = self.accentColor.cgColor
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
