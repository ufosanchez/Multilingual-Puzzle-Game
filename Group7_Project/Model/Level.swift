//
//  Level.swift
//  G07_Crossword
//
//  Created by Arnulfo Sánchez on 2023-03-20.
//

import Foundation

class Level : Identifiable{
    
    var id = UUID() //string
    var numLevel : Int
    var numFields : Int
    var matrixLevel : [[String]]
    var matrixLevelItem : [[String]]
    var wordsList : [Words]
    
    init(){
        self.numLevel = 0
        self.numFields = 0
        self.matrixLevel = []
        self.matrixLevelItem = []
        self.wordsList = []
    }
    
    init(numLevel: Int, numFields: Int, matrixLevel: [[String]], matrixLevelItem: [[String]], wordsList: [Words]) {
        self.numLevel = numLevel
        self.numFields = numFields
        self.matrixLevel = matrixLevel
        self.matrixLevelItem = matrixLevelItem
        self.wordsList = wordsList
    }
}
