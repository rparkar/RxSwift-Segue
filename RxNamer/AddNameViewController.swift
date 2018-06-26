//
//  AddNameViewController.swift
//  RxNamer
//
//  Created by Rehan Parkar on 2018-06-25.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AddNameViewController: UIViewController {

    //outlets
    
    @IBOutlet weak var newNameTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    //variables
    let nameSubject = PublishSubject<String>()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindSubmitButton()

    }
    
    func bindSubmitButton() {
        
        submitButton.rx.tap.subscribe(onNext: {
            
            if self.newNameTextField.text != "" {
                
                self.nameSubject.onNext(self.newNameTextField.text!)
                
            }

        }).disposed(by: disposeBag)
    }

}
