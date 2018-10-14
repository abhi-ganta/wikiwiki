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
    func pressedAction(enteredContentDictionary: [Category])
    func presentError()
}

public class QuestionCreationViewController: UIViewController {
    
    private var count = 0
    private var editingView: ContentView = EditingField(title: "", actionLabel: "", color: UIColor.wikiwiki.blue.color())
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
        progressBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        progressBar.rightAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progressBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    fileprivate func presentNext(content: String) {
        switch count {
        case 1:
            question.question = content
            removeCurrent {
                self.editingView = EditingField(title: "Enter Option 1", actionLabel: "Add Option 2", color: UIColor.wikiwiki.red.color())
                DispatchQueue.main.async {
                    self.updateProgressBarColor(color: UIColor.wikiwiki.red.color())
                }
                
                self.addNextView()
            }
        case 2:
            question.choice_1 = content
            removeCurrent {
                self.editingView = EditingField(title: "Enter Option 2", actionLabel: "Select Category", color: UIColor.wikiwiki.green.color())
                DispatchQueue.main.async {
                    self.updateProgressBarColor(color: UIColor.wikiwiki.green.color())
                }
                
                self.addNextView()

            }
        case 3:
            question.choice_2 = content
            removeCurrent {
                self.editingView = CategorySelectView(withOption: "")
                DispatchQueue.main.async {
                    self.updateProgressBarColor(color: UIColor.wikiwiki.purple.color())
                }
                self.addNextView()

            }
        case 4:
            removeCurrent {
                self.progressBar.removeFromSuperview()
                self.question.send()
                print("finished")

                self.present(ActiveQuestionViewController(activeQuestion: self.question), animated: true, completion: nil)
            }
        default:
            break
        }
    }
    
    private func updateProgressBarColor(color: UIColor) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1, animations: {
                self.progressBar.backgroundColor = color
            })
        }
    }
    
    private func removeCurrent(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0.7, animations: {
            self.editingView.center.x -= 500
            self.editingView.alpha = 0
        }, completion: { success in
            self.editingView.removeFromSuperview()
            completion()
        })
    }
    
    private func addNextView() {
        self.editingView.delegate = self
        self.view.addSubview(self.editingView)
        editingView.alpha = 0
        self.setUpConstraints()
        UIView.animate(withDuration: 0.6, animations: {
            self.editingView.alpha = 1
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QuestionCreationViewController: QuestionCreationDelegate {
    public func pressedAction(enteredContentDictionary: [Category]) {
        question.categories = enteredContentDictionary
        count += 1
        presentNext(content: "")
    }
    
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
