//
//  ViewController.swift
//  Flashcards
//
//  Created by Rachel on 10/13/18.
//  Copyright © 2018 Rachel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        frontLabel.isHidden = true;
    }
    
    func updateFlashCard(question: String, answer: String) {
        dismiss(animated: true)
        frontLabel.text = question
        backLabel.text = answer
        
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
    
}

