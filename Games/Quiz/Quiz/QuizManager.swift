//
//  QuizManager.swift
//  Quiz
//
//  Created by tommy trojan on 5/26/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

class QuizManager{
    fileprivate var quizzess:[Quiz] = []
    fileprivate var currentQuestion = 0
    //Total Right
    fileprivate var 👍 = 0
    //Total Wrong
    fileprivate var 👎 = 0
    
    func addQuiz(_ quiz:Quiz){
        self.quizzess.append(quiz)
    }
    
    func getCurrentQuestion() -> Quiz? {
        
        if currentQuestion < quizzess.count {
            return self.quizzess[currentQuestion]
        }
        return nil
    }
    
    //Answer to the current question
    //Returns true if correct
    func answer(_ questionNumber:Int) -> Bool {
        var rightAnswer:Bool
        if getCurrentQuestion()!.👌 == questionNumber {
            rightAnswer = true
            👍 += 1
        } else {
            rightAnswer = false
            👎 += 1
        }
        currentQuestion += 1
        return rightAnswer
    }
    
    func get👍() -> Int{
        return 👍
    }
    
    func get👎() -> Int{
        return 👎
    }
}
