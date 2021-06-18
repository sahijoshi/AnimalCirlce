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
    case sound
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
        
        var quizQuestion6 = Questions()
        quizQuestion6.question = "Identify the sound of the animal."
        quizQuestion6.options = ["Elephant", "Tiger", "Dolphin", "Dog"]
        quizQuestion6.answerIndex = 1
        quizQuestion6.type = .sound
        questions.append(quizQuestion6)

        return questions
    }
    
    static func getQuizQuestionsForElephant() -> [Questions] {
        var questions = [Questions]()
        
        var quizQuestion1 = Questions()
        quizQuestion1.question = "In the wild, how long can an African elephant live?"
        quizQuestion1.options = ["20", "60", "70", "10"]
        quizQuestion1.answerIndex = 2
        quizQuestion1.type = .normal
        questions.append(quizQuestion1)
        
        var quizQuestion2 = Questions()
        quizQuestion2.question = "How many muscles does an elephant's trunk have?"
        quizQuestion2.options = ["40", "200", "1000", "150000"]
        quizQuestion2.answerIndex = 3
        quizQuestion2.type = .normal
        questions.append(quizQuestion2)

        var quizQuestion3 = Questions()
        quizQuestion3.question = "What is the purpose of an elephant's trunk?"
        quizQuestion3.options = ["Carry food", "Communication", "Smell", "All of the above"]
        quizQuestion3.answerIndex = 3
        quizQuestion3.type = .normal
        questions.append(quizQuestion3)

        var quizQuestion4 = Questions()
        quizQuestion4.question = "How do elephants communicate with other elephants?"
        quizQuestion4.options = ["Scent", "Voice", "Infrasonic rumbling", "All of the above"]
        quizQuestion4.answerIndex = 3
        quizQuestion4.type = .normal
        questions.append(quizQuestion4)

        var quizQuestion5 = Questions()
        quizQuestion5.question = "Where can you find elephants?"
        quizQuestion5.options = ["North America and Europe", "Europe and Asia", "Asia and Africa", "All of the above"]
        quizQuestion5.answerIndex = 2
        quizQuestion5.type = .normal
        questions.append(quizQuestion5)
        
        var quizQuestion6 = Questions()
        quizQuestion6.question = "Identify the sound of the animal."
        quizQuestion6.options = ["Elephant", "Tiger", "Dolphin", "Dog"]
        quizQuestion6.answerIndex = 0
        quizQuestion6.type = .sound
        questions.append(quizQuestion6)

        return questions
    }
    
    static func getQuizQuestionsForPanda() -> [Questions] {
        var questions = [Questions]()
        
        var quizQuestion1 = Questions()
        quizQuestion1.question = "Where are giant panda found?"
        quizQuestion1.options = ["America", "Europe", "China", "Africa"]
        quizQuestion1.answerIndex = 2
        quizQuestion1.type = .normal
        questions.append(quizQuestion1)
        
        var quizQuestion2 = Questions()
        quizQuestion2.question = "In the wild, how long can giant panda live for?"
        quizQuestion2.options = ["5 - 10 years", "15 - 20 years", "30 - 40 years", "10 - 15 years"]
        quizQuestion2.answerIndex = 1
        quizQuestion2.type = .normal
        questions.append(quizQuestion2)

        var quizQuestion3 = Questions()
        quizQuestion3.question = "What is the main food of giant panda?"
        quizQuestion3.options = ["Grass", "Fruits", "Fish", "Bamboo"]
        quizQuestion3.answerIndex = 3
        quizQuestion3.type = .normal
        questions.append(quizQuestion3)

        var quizQuestion4 = Questions()
        quizQuestion4.question = "Giant panda hibernate."
        quizQuestion4.options = ["True", "False"]
        quizQuestion4.answerIndex = 1
        quizQuestion4.type = .yesNo
        questions.append(quizQuestion4)

        var quizQuestion5 = Questions()
        quizQuestion5.question = "With what name giant panda is also known for in China?"
        quizQuestion5.options = ["Bamboo bear", "White bear", "Large bear cat", "All of the above"]
        quizQuestion5.answerIndex = 3
        quizQuestion5.type = .normal
        questions.append(quizQuestion5)
        
        var quizQuestion6 = Questions()
        quizQuestion6.question = "Identify the sound of the animal."
        quizQuestion6.options = ["Elephant", "Tiger", "Giant Panda", "Dog"]
        quizQuestion6.answerIndex = 2
        quizQuestion6.type = .sound
        questions.append(quizQuestion6)

        return questions
    }

    static func getQuizQuestionsForPolarBear() -> [Questions] {
        var questions = [Questions]()
        
        var quizQuestion1 = Questions()
        quizQuestion1.question = "Where do Polar bear live?"
        quizQuestion1.options = ["Russia", "Greenland", "Canada", "All of the above"]
        quizQuestion1.answerIndex = 3
        quizQuestion1.type = .normal
        questions.append(quizQuestion1)
        
        var quizQuestion2 = Questions()
        quizQuestion2.question = "What do Polar bear eat?"
        quizQuestion2.options = ["Grass", "Seals", "Grains", "None of the above"]
        quizQuestion2.answerIndex = 1
        quizQuestion2.type = .normal
        questions.append(quizQuestion2)

        var quizQuestion3 = Questions()
        quizQuestion3.question = "Climate change is the biggest threat to Polar bear"
        quizQuestion3.options = ["True", "False"]
        quizQuestion3.answerIndex = 0
        quizQuestion3.type = .yesNo
        questions.append(quizQuestion3)

        var quizQuestion4 = Questions()
        quizQuestion4.question = "How many cubs do Polar bear have?"
        quizQuestion4.options = ["5", "2", "3", "1"]
        quizQuestion4.answerIndex = 1
        quizQuestion4.type = .normal
        questions.append(quizQuestion4)

        var quizQuestion5 = Questions()
        quizQuestion5.question = "Polar bear can smell upto 1 km."
        quizQuestion5.options = ["True", "False"]
        quizQuestion5.answerIndex = 0
        quizQuestion5.type = .yesNo
        questions.append(quizQuestion5)
        
        var quizQuestion6 = Questions()
        quizQuestion6.question = "Identify the sound of the animal."
        quizQuestion6.options = ["Elephant", "Polar bear", "Giant Panda", "Dog"]
        quizQuestion6.answerIndex = 1
        quizQuestion6.type = .sound
        questions.append(quizQuestion6)

        return questions
    }

}
