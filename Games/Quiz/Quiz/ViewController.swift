//
//  ViewController.swift
//  Quiz
//
//  Created by tommy trojan on 5/26/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UITextView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var answer①Button: UIButton!
    @IBOutlet weak var answer②Button: UIButton!
    @IBOutlet weak var answer③Button: UIButton!
    
    @IBAction func answer(_ sender: UIButton) {
        var userAnswer:Int
        switch(sender){
        case answer①Button:
            userAnswer = 1
        case answer②Button:
            userAnswer = 2
        case answer③Button:
            userAnswer = 3
        default:
            userAnswer = 0
        }
        quizManager.answer(userAnswer)
        prepareNextQuestion()
    }

    //The timer will keep track of the quiz questions
    var quizTimer:Timer?
    var elapsedTime:Int
    //The entire quiz
    var quizManager:QuizManager
    
    //We must re-implement this class
    required init(coder: NSCoder) {
        //We set the elapsed time before the super class
        self.elapsedTime = 0
        quizManager = QuizManager()
        //We set the Super class
        super.init(coder: coder)!
        //
        setupQuizManager()
    }
    
    fileprivate func setupQuizManager(){
        quizManager.addQuiz(Quiz(question: "What is the entertainment capital of the world?", ①: "Los Angeles", ②: "New York City", ③: "Tokyo", 👌: 1))
        quizManager.addQuiz(Quiz(question: "Which film mogol did not own a building in Downtown Los Angeles?", ①: "William H Fox", ②: "Warner Brothers", ③: "Jack Valenti", 👌: 3))
        quizManager.addQuiz(Quiz(question: "Which artist is not a United Artist?", ①: "Charlie Chaplin", ②: "Douglas Fairbanks", ③: "George Lucas", 👌: 3))
    }
    
    fileprivate func prepareNextQuestion(){
        if(quizTimer != nil){
            quizTimer!.invalidate()
        }
        //If a question exists, assign it to quiz
        if let quiz = quizManager.getCurrentQuestion(){
            print(quiz)
            elapsedTime = 0
            questionLabel.text = quiz.question
            answer①Button.setTitle(quiz.①, for: UIControlState())
            answer②Button.setTitle(quiz.②, for: UIControlState())
            answer③Button.setTitle(quiz.③, for: UIControlState())
            //Set the clock
            quizTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.tick), userInfo: nil, repeats: true)
            //Set off the clock
            quizTimer!.fire()
        }else{
            //No more questions left
            UIAlertView(title: "Score",
                message: "Total \u{1F44D} \(quizManager.get👍()) \nTotal \u{1F44E} \(quizManager.get👎())",
                delegate: nil, cancelButtonTitle: "OK").show()
        }
        
    }
    
    func tick(){
        print(elapsedTime)
        if elapsedTime < 12 {
            let baseCharCode = 0x1F550
            timerLabel.text = String(Character(UnicodeScalar(baseCharCode + elapsedTime)!))
            elapsedTime += 1
        } else {
            quizManager.answer(0)
            prepareNextQuestion()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        prepareNextQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

