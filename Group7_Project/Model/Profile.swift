//
//  Profile.swift
//  FirestoreDemo
//
//  Created by Winona Lee on 2023-03-16.
//

import Foundation
import FirebaseFirestoreSwift

struct Profile : Codable, Hashable{
    
    @DocumentID var id : String? = UUID().uuidString
    var pName : String = ""
    var pGender : String = ""
    var pAge : Int = 0
    var pLanguage : [String] = []
    var pLat : Double = 0.0
    var pLog : Double = 0.0
    
    init(){
        
    }
    init(name : String, gender : String, age: Int, language : [String]) {
        self.pName = name
        self.pGender = gender
        self.pAge = age
        self.pLanguage = language
    }
    
    init(name : String, gender : String, age: Int, language : [String], lat : Double, log : Double) {
        self.pName = name
        self.pGender = gender
        self.pAge = age
        self.pLanguage = language
        self.pLat = lat
        self.pLog = log
    }
}
