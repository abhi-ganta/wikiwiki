//
//  IntroViewController.swift
//  wikiwiki
//
//  Created by Brian Lin on 10/14/18.
//  Copyright © 2018 pblin@umich.edu. All rights reserved.
//

import Foundation
import UIKit

public class IntroViewController: UIViewController {
    
    private var titleLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    private let actionButton1 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    private let actionButton2 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    private let logo = UIImageView(image: UIImage(named: "wikiwiki_logo.png"))

    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        titleLabel.text = "WikiWiki"
        titleLabel.font = UIFont(name: "Helvetica Neue", size: 25)
        titleLabel.textColor = UIColor.wikiwiki.blue.color()
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        actionButton1.setTitle("Create", for: .normal)
        actionButton1.setTitleColor(UIColor.wikiwiki.orange.color(), for: .normal)
        actionButton1.setTitleColor(.white, for: .highlighted)
        actionButton1.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 20)
        actionButton1.backgroundColor = .clear
        actionButton1.layer.borderWidth = 1
        actionButton1.layer.borderColor = UIColor.wikiwiki.orange.color().cgColor
        actionButton1.layer.cornerRadius = 5
        
        actionButton1.addTarget(self, action: #selector(tappedCreate), for: .touchUpInside)
        
        view.addSubview(actionButton1)
        
        actionButton2.setTitle("Answer", for: .normal)
        actionButton2.setTitleColor(UIColor.wikiwiki.blue.color(), for: .normal)
        actionButton2.setTitleColor(.white, for: .highlighted)
        actionButton2.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 20)
        actionButton2.backgroundColor = .clear
        actionButton2.layer.borderWidth = 1
        actionButton2.layer.borderColor = UIColor.wikiwiki.blue.color().cgColor
        actionButton2.layer.cornerRadius = 5
        
        actionButton2.addTarget(self, action: #selector(tappedAnswer), for: .touchUpInside)
        
        view.addSubview(actionButton2)
        
        view.addSubview(logo)
    }
    
    @objc
    private func tappedCreate() {
        present(QuestionCreationViewController(), animated: true, completion: nil)
    }
    
    @objc
    private func tappedAnswer() {
        present(QuestionViewerViewController(), animated: true, completion: nil)
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 180).isActive = true
        
        actionButton1.translatesAutoresizingMaskIntoConstraints = false
        actionButton1.widthAnchor.constraint(equalToConstant: 200).isActive = true
        actionButton1.heightAnchor.constraint(equalToConstant: 50).isActive = true
        actionButton1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        actionButton1.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120).isActive = true
        
        actionButton2.translatesAutoresizingMaskIntoConstraints = false
        actionButton2.widthAnchor.constraint(equalToConstant: 200).isActive = true
        actionButton2.heightAnchor.constraint(equalToConstant: 50).isActive = true
        actionButton2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        actionButton2.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.widthAnchor.constraint(equalToConstant: 300).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 300).isActive = true
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logo.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
