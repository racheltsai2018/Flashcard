//
//  ViewController.swift
//  Flashcards
//
//  Created by Rachel on 10/13/18.
//  Copyright © 2018 Rachel. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    //array to holf Flashcards
    var flashcards = [Flashcard]()
    var currentIndex = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        readSavedFlashcards()
        if flashcards.count == 0{
           updateFlashCard(question: "What is the captial of Brazil?", answer: "Brasilia")} else{
            updateLabels()
            updateNextPrevButtons()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        frontLabel.isHidden = true;
    }
    
    func updateFlashCard(question: String, answer: String) {
        let flashcard = Flashcard(question: question, answer: answer)
        frontLabel.text = question
        backLabel.text = answer
        
        flashcards.append(flashcard)
        
        print("Added new Flashcard")
        print("We now have \(flashcards.count) flashcards")
        
        currentIndex = flashcards.count-1
        print("Our current Index is \(currentIndex)")
        
        updateNextPrevButtons()
        
        updateLabels()
        
        saveAllFlashcardsToDisk()
        }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex+1
        updateLabels()
        updateNextPrevButtons()
    }
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex-1
        updateLabels()
        updateNextPrevButtons()
        
    }
    
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
    
    func updateNextPrevButtons(){
        if currentIndex == flashcards.count-1{
            nextButton.isEnabled = false
        } else{
            nextButton.isEnabled = true
        }
        
        if currentIndex == 0{
            prevButton.isEnabled = false
        } else{
            prevButton.isEnabled = true
        }
    }
    
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map { (card) -> [String:String] in return ["question": card.question, "answer": card.answer]
        }
      UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            let savedCards = dictionaryArray.map{ dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)}
            flashcards.append(contentsOf: savedCards)
        }
    }
    
}

