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
    var namesArray: Variable<[String]> = Variable([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToTextField()
        bindToButton()
    }

    func bindToTextField() {
        
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
    
    func bindToButton() {
        submitButton.rx.tap.subscribe(onNext: {
            if self.namesEntryTextField.text != "" {
                self.namesArray.value.append((self.namesEntryTextField.text!.capitalized))
                self.namesLabel.rx.text.onNext(self.namesArray.value.joined(separator: ", "))
                self.namesEntryTextField.rx.text.onNext("")
                self.helloLabel.rx.text.onNext("Type your name below")
            }
        }).disposed(by: disposeBag)
    }

}

