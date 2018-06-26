//
//  ViewController.swift
//  RxNamer
//
//  Created by Rehan Parkar on 2018-06-25.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    //outlets
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var namesEntryTextField: UITextField!
    @IBOutlet weak var namesLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    //variables
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    func bind() {
        
        namesEntryTextField.rx.text
            .debounce(0.5, scheduler: MainScheduler.instance)
            .map {
                
                if $0 == "" {
                    return "Type your name below"
                } else {
                    return "Hello \($0!)."
                }
          
            }
            .bind(to: helloLabel.rx.text)
            .disposed(by: disposeBag)
        
    }

}

