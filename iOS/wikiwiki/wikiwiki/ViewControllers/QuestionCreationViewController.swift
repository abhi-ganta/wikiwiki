//
//  QuestionCreationViewController.swift
//  wikiwiki
//
//  Created by Brian Lin on 10/13/18.
//  Copyright © 2018 pblin@umich.edu. All rights reserved.
//

import Foundation
import UIKit

public protocol QuestionCreationDelegate {
    func pressedAction(enteredContent: String)
    func presentError()
}

public class QuestionCreationViewController: UIViewController {
    
    private var count = 0
    private var editingView: EditingField = EditingField(title: "", actionLabel: "", color: UIColor.wikiwiki.blue.color())
    private var question: Question = Question(question: "", choice_1: "", choice_2: "")
    private var progressBar: UIView = UIView()
    
    private var barWidthConstraint: NSLayoutConstraint?
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        view.backgroundColor = .white
        
        setUpView()
        setUpConstraints()
    }
    
    private func setUpView() {
        editingView = EditingField(title: "Enter Your Question", actionLabel: "Add Options", color: UIColor.wikiwiki.blue.color())

        editingView.delegate = self
        view.addSubview(editingView)
        
        progressBar.backgroundColor = UIColor.wikiwiki.blue.color()
        view.addSubview(progressBar)
        
    }
    
    private func setUpConstraints() {
        editingView.translatesAutoresizingMaskIntoConstraints = false
        editingView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        editingView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        editingView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

        progressBar.translatesAutoresizingMaskIntoConstraints = false
        barWidthConstraint = progressBar.widthAnchor.constraint(equalToConstant: view.frame.width / 3)
        barWidthConstraint?.isActive = true
        progressBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        progressBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    fileprivate func presentNext(content: String) {
        switch count {
        case 1:
            question.question = content
            removeCurrent {
                self.editingView = EditingField(title: "Enter Option 1", actionLabel: "Add Option 2", color: UIColor.wikiwiki.red.color())
                DispatchQueue.main.async {
                    self.progressBar.backgroundColor = UIColor.wikiwiki.red.color()
                    self.barWidthConstraint?.constant = self.view.frame.width * 2 / 3
                    
                    self.progressBar.setNeedsUpdateConstraints()
                    self.progressBar.layoutIfNeeded()
                }
                
                self.addNextView()
            }
        case 2:
            question.choice_1 = content
            removeCurrent {
                self.editingView = EditingField(title: "Enter Option 2", actionLabel: "Finish", color: UIColor.wikiwiki.green.color())
                DispatchQueue.main.async {
                    self.barWidthConstraint?.constant = self.view.frame.width
                    self.progressBar.backgroundColor = UIColor.wikiwiki.green.color()

                    self.progressBar.setNeedsUpdateConstraints()
                    self.progressBar.layoutIfNeeded()
                }
                
                self.addNextView()

            }
        case 3:
            question.choice_2 = content
            removeCurrent {}
            question.send()
            print("finished")
        default:
            break
        }
    }
    
    private func removeCurrent(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0.5, animations: {
            self.editingView.alpha = 0
        }, completion: { success in
            self.editingView.removeFromSuperview()
            completion()
        })
    }
    
    private func addNextView() {
        self.editingView.delegate = self
        self.view.addSubview(self.editingView)
        self.setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QuestionCreationViewController: QuestionCreationDelegate {
    public func presentError() {
        let alert = UIAlertController(title: "Error", message: "Please Enter Something", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    public func pressedAction(enteredContent content: String) {
        print("received event: \(content)")
        count += 1
        presentNext(content: content)
    }
}
