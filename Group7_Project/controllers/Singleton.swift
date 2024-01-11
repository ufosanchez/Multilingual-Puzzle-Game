//
//  Singleton.swift
//  G07_Crossword
//
//  Created by Arnulfo Sánchez on 2023-03-18.
//

import Foundation

class Singleton : ObservableObject {
    
    static let shared = Singleton()
    
    
    @Published var temporalWords = [String]()
    @Published var realWords = [String]()
    
    @Published var polulateBoardPlayer = [String]()
    
    
    
    private init() {

    }
    
}
