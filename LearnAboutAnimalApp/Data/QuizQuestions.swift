//
//  QuizQuestions.swift
//  LearnAboutAnimalApp
//
//  Created by skj on 17.4.2021.
//

import Foundation
enum QuestionType {
    case normal
    case yesNo
}

struct Questions {
    var question = ""
    var options = [String]()
    var answerIndex = 0
    var type:QuestionType = .normal
}

class QuizQuestions {
    static func getQuizQuestionsForTiger() -> [Questions] {
        var questions = [Questions]()
            
        var quizQuestion1 = Questions()
        quizQuestion1.question = "Identify the carnivorous animal from the following list"
        quizQuestion1.options = ["Cow", "Deer", "Tiger", "Elephant"]
        quizQuestion1.answerIndex = 2
        quizQuestion1.type = .normal
        questions.append(quizQuestion1)
        
        var quizQuestion2 = Questions()
        quizQuestion2.question = "Which is the largest subspecies of Tiger?"
        quizQuestion2.options = ["Sumatran tigers", "Siberian tigers", "Indian Tiger", "Malayan Tiger"]
        quizQuestion2.answerIndex = 1
        quizQuestion2.type = .normal
        questions.append(quizQuestion2)

        var quizQuestion3 = Questions()
        quizQuestion3.question = "What is the average age of tiger?"
        quizQuestion3.options = ["8 - 10 years", "50 years", "5 - 8 years", "80 years"]
        quizQuestion3.answerIndex = 0
        quizQuestion3.type = .normal
        questions.append(quizQuestion3)

        var quizQuestion4 = Questions()
        quizQuestion4.question = "Tigers are closer to extinction because of loss of habitat and poaching"
        quizQuestion4.options = ["True", "False"]
        quizQuestion4.answerIndex = 0
        quizQuestion4.type = .yesNo
        questions.append(quizQuestion4)

        var quizQuestion5 = Questions()
        quizQuestion5.question = "The major food of tigers is deer."
        quizQuestion5.options = ["True", "False"]
        quizQuestion5.answerIndex = 0
        quizQuestion5.type = .yesNo
        questions.append(quizQuestion5)

        return questions
    }
}
