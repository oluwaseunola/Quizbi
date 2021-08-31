//
//  APICall.swift
//  Quizbi
//
//  Created by Seun Olalekan on 2021-08-26.
//

import Foundation



struct APICall {
    
    
    
    static func newQuestionSet(completion: @escaping (QuestionFormat)-> Void){
        
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10&type=multiple") else {return}
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data else {
                return
            }
            
        
                do{
                    
                    let result = try JSONDecoder().decode(QuestionFormat.self, from: data)
                    completion(result)
                    
                } catch{
                    print(error)
                }
                        
            
           
            
            
            
        }
        
        session.resume()
        
        
        
        
        
    }
    
    
    
}

