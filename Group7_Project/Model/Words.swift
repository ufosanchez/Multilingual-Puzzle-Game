//
//  Words.swift
//  G07_Crossword
//
//  Created by Arnulfo Sánchez on 2023-03-20.
//

import Foundation

class Words : Identifiable{
    
    var id = UUID() //string
    var number : Int
    var language : String
    var word : String
    var meaning : String
    var down : Bool
    
    var posFirstRow : Int
    var posFirstCol : Int
    var posLastRow : Int
    var posLastCol : Int
    
    init(){
        self.number = 0
        self.language = "NA"
        self.word = "NA"
        self.meaning = "NA"
        self.down = false
        self.posFirstRow = 0
        self.posFirstCol = 0
        self.posLastRow = 0
        self.posLastCol = 0
    }
    
    
    init(number: Int, language: String = "NA", word: String, meaning: String, down: Bool, posFirstRow: Int = 0, posFirstCol: Int = 0, posLastRow: Int = 0, posLastCol: Int = 0) {
        self.number = number
        self.language = language
        self.word = word
        self.meaning = meaning
        self.down = down
        self.posFirstRow = posFirstRow
        self.posFirstCol = posFirstCol
        self.posLastRow = posLastRow
        self.posLastCol = posLastCol
    }
}
