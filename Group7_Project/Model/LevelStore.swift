//
//  LevelStore.swift
//  G07_Crossword
//
//  Created by Arnulfo Sánchez on 2023-03-28.
//

import Foundation
import FirebaseFirestoreSwift

struct LevelStore : Codable, Hashable{
    @DocumentID var id : String? = UUID().uuidString
    var pEmail : String = ""
    var pScore : Int = 0
    var dateAdded : Date = Date()
    
    init(){
        
    }
    
    init(email: String, score : Int){
        self.pEmail = email
        self.pScore = score
    }
    
    init?(dictionary : [String : Any]){
        
        guard let email = dictionary["pEmail"] as? String else{
            print(#function, "Unable to read pEmail from the object")
            return nil
        }
        
        guard let score = dictionary["pScore"] as? Int else{
            print(#function, "Unable to read pScore from the object")
            return nil
        }
        
        self.init(email: email, score: score)
        
    }
}
