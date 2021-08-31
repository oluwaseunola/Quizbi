//
//  Extensions.swift
//  Quizbi
//
//  Created by Seun Olalekan on 2021-08-25.
//
import UIKit
import Foundation

extension UIView {
    
    public var width: CGFloat {
        return frame.size.width
    }
    
    public var height: CGFloat {
        return frame.size.height
    }
    
    public var top: CGFloat {
        return frame.origin.y
    }
    
    public var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    public var left: CGFloat {
        return frame.origin.x
    
    }
    
    public var right: CGFloat {
        return frame.origin.x + frame.size.width
    }
    
    
    
    
}

extension String {

    init(htmlString: String) {
        self.init()
        guard let encodedData = htmlString.data(using: .utf8) else {
            self = htmlString
            return
        }

        let attributedOptions: [NSAttributedString.DocumentReadingOptionKey : Any] = [
           .documentType: NSAttributedString.DocumentType.html,
           .characterEncoding: String.Encoding.utf8.rawValue
        ]

        do {
            let attributedString = try NSAttributedString(data: encodedData,
                                                          options: attributedOptions,
                                                          documentAttributes: nil)
            self = attributedString.string
        } catch {
            print("Error: \(error.localizedDescription)")
            self = htmlString
        }
    }
}

extension Encodable{
    
    func makeDictionary()-> [String : Any]? {
        
        do{
            guard let data = try? JSONEncoder().encode(self) else{return nil}
            
            let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any]
            
            return dictionary
            
        }
        
        

    }
    
}

extension Decodable{
    
    init?(with dictionary: [String : Any]) {
        
        do{
            guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) else{return nil}
            
            guard let model = try? JSONDecoder().decode(Self.self, from: data) else {return nil}
            
            self = model
            
        }
        
        
    }
    
}
