//
//  QuizManager.swift
//  Quiz
//
//  Created by tommy trojan on 5/26/15.
//  Copyright (c) 2015 Chris Mendez. All rights reserved.
//

class QuizManager{
    private var quizzess:[Quiz] = []
    private var currentQuestion = 0
    //Total Right
    private var 👍 = 0
    //Total Wrong
    private var 👎 = 0
    
    func addQuiz(quiz:Quiz){
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
    func answer(questionNumber:Int) -> Bool {
        var rightAnswer:Bool
        if getCurrentQuestion()!.👌 == questionNumber {
            rightAnswer = true
            👍++
        } else {
            rightAnswer = false
            👎++
        }
        currentQuestion++
        return rightAnswer
    }
    
    func get👍() -> Int{
        return 👍
    }
    
    func get👎() -> Int{
        return 👎
    }
}