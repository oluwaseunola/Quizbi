//
//  DatabaseManager.swift
//  Quizbi
//
//  Created by Seun Olalekan on 2021-08-31.
//
import FirebaseFirestore
import Foundation

struct DatabaseManager{
    
    static let shared = DatabaseManager()
    
    let database = Firestore.firestore()
    
    
    func saveUser(model: UserModel, completion: @escaping (Bool)-> Void){
        
        let reference = database.collection("users").document(model.username)
        
        reference.setData(model.makeDictionary() ?? [:]) { error in
            if error == nil{
                completion(true)
            }
            else{completion(false)}
        }
        
    }
    
    func getUsers(completion: @escaping ([UserModel])-> Void){
        
        let ref = database.collection("users")
        
        ref.getDocuments { users, error in
            
            guard let results = users else{return}
            
            let userArray = results.documents.compactMap({UserModel(with: $0.data())})
            
            if error == nil{
                completion(userArray)
            }else{print("something went wrong")}
            
            
            
            
            
        }
        
    }
    
    
    
}
