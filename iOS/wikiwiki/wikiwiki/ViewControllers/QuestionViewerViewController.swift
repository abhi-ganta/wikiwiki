//
//  QuestionViewerViewController.swift
//  wikiwiki
//
//  Created by Brian Lin on 10/14/18.
//  Copyright © 2018 pblin@umich.edu. All rights reserved.
//

import Foundation
import UIKit

public class QuestionViewerViewController: UIViewController {
    private var questions: [Question]
    
    public init(questions: [Question]) {
        self.questions = questions
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        view.backgroundColor = .white
    }
    
    public func setupViews() {
        
    }
    
    public func setupConstraints() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
