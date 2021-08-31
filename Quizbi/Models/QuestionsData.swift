//
//  QuestionsData.swift
//  Quizbi
//
//  Created by Seun Olalekan on 2021-08-26.
//

import Foundation

struct QuestionFormat: Codable{
    let response_code : Int
    let results : [Questions]
}

struct Questions: Codable{
    
    let category : String
    let type : String
    let difficulty: String
    let question : String
    let correct_answer : String
    let incorrect_answers: [String]
    
}
