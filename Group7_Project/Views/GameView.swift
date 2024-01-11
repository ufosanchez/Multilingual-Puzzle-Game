//
//  ContentView.swift
//  G07_Crossword
//
//  Created by Arnulfo Sánchez on 2023-03-17.
//

import SwiftUI
import AVKit

struct GameView: View {
    
    @State private var boardPlayer = [
        ["","","","","","","",""],
        ["","","","","","","",""],
        ["","","","","","","",""],
        ["","","","","","","",""],
        ["","","","","","","",""],
        ["","","","","","","",""],
        ["","","","","","","",""],
        ["","","","","","","",""]]
    
    let levelInfo : Level
    
    @State private var board = [
        ["S","K","J","Ø","R","T","D","P"],
        ["","A","I","L","","D","I","A"],
        ["L","","","","S","","N","A"],
        ["U","G","R","A","I","","O","R"],
        ["N","S","C","H","L","O","S","S"],
        ["A","K","","","L","","A",""],
        ["","O","H","Ň","A","","U",""],
        ["Ä","T","A","","K","A","R","T"]]
    
    @State private var boardItem = [
        ["2","","","3","","","1","8"],
        ["","11","","","","10","",""],
        ["9","","","","13","","",""],
        ["12","","","","","","",""],
        ["","5","","","","","",""],
        ["","4","","","","","",""],
        ["","14","","","","","",""],
        ["6","","","","7","","",""]]
    
//    @State private var answers = ["DINOSAUR", "SKJØRT", "ØL", "KOT", "SCHLOSS", "ÄTA", "KART", "PAARS", "LUNA", "DIA", "AIL", "UGRAI", "SILLA", "OHŇA"]
    @State private var answers = [Words]()
    
    @State private var wordsList = [Words(number: 1,word: "DINOSAUR", meaning: "NA", down: true),
                                    Words(number: 2,word: "SKJØRT", meaning: "NA", down: false),
                                    Words(number: 3,word: "ØL", meaning: "NA", down: true),
                                    Words(number: 4,word: "KOT", meaning: "NA", down: true),
                                    Words(number: 5,word: "SCHLOSS", meaning: "NA", down: false),
                                    Words(number: 6,word: "ÄTA", meaning: "NA", down: false),
                                    Words(number: 7,word: "KART", meaning: "NA", down: false),
                                    Words(number: 8,word: "PAARS", meaning: "NA", down: true),
                                    Words(number: 9,word: "LUNA", meaning: "NA", down: true),
                                    Words(number: 10,word: "DIA", meaning: "NA", down: false),
                                    Words(number: 11,word: "AIL", meaning: "NA", down: false),
                                    Words(number: 12,word: "UGRAI", meaning: "NA", down: false),
                                    Words(number: 13,word: "SILLA", meaning: "NA", down: true),
                                    Words(number: 14,word: "OHŇA", meaning: "NA", down: false)]
    
    @State private var correctArray = [String]()
    
    @State private var letter : String = ""
    
    @State private var numCorrect = 0
    
    @StateObject var singleton = Singleton.shared
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    @State private var player : AVAudioPlayer?
    
    @State private var showingAlert = false
    @State private var title = ""
    @State private var message = ""
    
    @State private var userScoreLevel : Bool = false
    @State private var bestScoreLevel : Bool = false
    
    var body: some View {
        
//        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    
                    Text("Level # \(self.levelInfo.numLevel)")
                        .font(.custom("AmericanTypewriter",fixedSize: 20).weight(.bold))
                    
                    ForEach(0..<self.levelInfo.numFields){ row in
                        HStack{
                            ForEach(0..<self.levelInfo.numFields){ col in
                                Button(action:{
                                    print("Tile clicked - row : \(row) - col : \(col)")
                                    print("from database - row : \(row) - col : \(col) letter : \(board[row][col])")
                                    print("from player - row : \(row) - col : \(col) letter : \(boardPlayer[row][col])")
                                }){
                                    //appearance
                                    
                                    ZStack{
                                        
                                        if(self.board[row][col] == ""){
                                            Text("\(self.board[row][col])")
                                                .frame(minWidth: 40, minHeight: 40)
                                                .background(Color.black)
                                        }
                                        else{
                                            
                                            if(board[row][col] == boardPlayer[row][col]){
                                                TextField("\(self.board[row][col])", text: self.$boardPlayer[row][col])
                                                //                                        Text("\(self.board[row][col])")
                                                    .font(.system(size: 30))
                                                    .bold()
                                                    .foregroundColor(Color.black)
                                                //                                            .frame(minWidth: 40, minHeight: 40)
                                                    .frame(maxWidth: 40, minHeight: 40)
                                                    .background(Color.green)
                                                    .autocorrectionDisabled()
                                            }
                                            else{
                                                TextField("\(self.board[row][col])", text: self.$boardPlayer[row][col])
                                                //                                        Text("\(self.board[row][col])")
                                                    .font(.system(size: 30))
                                                    .bold()
                                                    .foregroundColor(Color.black)
                                                //                                            .frame(minWidth: 40, minHeight: 40)
                                                    .frame(maxWidth: 40, minHeight: 40)
                                                    .background(Color.red)
                                                    .autocorrectionDisabled()
                                            }
                                        }
                                        
                                        Text(self.boardItem[row][col])
                                            .font(.caption)
                                            .foregroundColor(Color.black)
                                            .frame(maxWidth: 40, minHeight: 40, alignment: .topLeading)
                                    }
                                    
                                }//Button ends
                                .disabled(self.board[row][col] == "")
                            }//ForEach col ends
                        }//HStack ends
                    }//ForEach rown ends
                    
                    Button(action:{
                        self.singleton.temporalWords.removeAll()
                        self.singleton.realWords.removeAll()
                        self.numCorrect = 0
                        
                        self.getData()
                        print("temporalWords : \(self.singleton.temporalWords)")
                        print("realWords : \(self.singleton.realWords)")
                        print("numCorrect : \(self.numCorrect)")
                        print("correctArray : \(self.correctArray)")
                        
                        
                    }){
                        Text("Check")
                    }//Button ends
                    .padding(7)
                    .background(Color(red: 0, green: 0, blue: 0.5))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .alert(isPresented: self.$showingAlert){
                        Alert(title: Text(title),
                              message: Text("\(message)\n\(self.correctArray.joined(separator: "\n"))")
                        )
                    }
                    
                    VStack{
                        //                    List{
                        //                        Section(header: Text("Across")){
                        Text("ACROSS")
                        Divider()
                        ForEach(self.wordsList){ answer in
                            
                            if(!answer.down){
                                HStack(spacing: 20){
                                    Text("\(answer.number).")
                                        .bold()
                                        .frame(maxHeight: .infinity, alignment: .topLeading)
                                    Text("\(answer.meaning) (\(answer.language))")
                                        .onTapGesture{
                                            print(#function, "\(answer.word) selceted")
                                        }
                                    //.frame(height: 1)
                                    
                                    Button(action:{
                                        self.pronunciation(word: answer.word)
                                    }){
                                        Image(systemName: "speaker.wave.3.fill")
                                    }
                                }
                                //                                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            }
                        }//ForEach ends
                        .frame(maxWidth: .infinity, alignment: .leading)
                        //                        }//Section ends
                        
                        //                    }//List ends
                        
                        //                .environment(\.defaultMinListRowHeight, 1)
                        
                        //                    List{
                        //                        Section(header: Text("Down")){
                        Text("DOWN")
                        Divider()
                        ForEach(self.wordsList){ answer in
                            
                            if(answer.down){
                                HStack(spacing: 20){
                                    Text("\(answer.number).")
                                        .bold()
                                        .frame(maxHeight: .infinity, alignment: .topLeading)
                                    Text("\(answer.meaning) (\(answer.language))")
                                        .onTapGesture{
                                            print(#function, "\(answer.word) selceted")
                                        }
                                    //                                        .frame(height: 1)
                                    
                                    Button(action:{
                                        self.pronunciation(word: answer.word)
                                    }){
                                        Image(systemName: "speaker.wave.3.fill")
                                    }
                                }
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            }
                        }//ForEach ends
                        .frame(maxWidth: .infinity, alignment: .leading)
                        //                        }//Section ends
                        //                    }//List ends
                    }//VStack ends
                    .padding()
                    //                .environment(\.defaultMinListRowHeight, 1)
                    //            .frame(height: 100, alignment: .topLeading)
                    //            .scrollContentBackground(.hidden)
                    
                }//VStack ends
//                .frame(height: geometry.size.height)
            }//ScrollView ends
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button{
                        self.userScoreLevel = true
                        
                    }label: {Image(systemName: "medal")}
                    .sheet(isPresented: self.$userScoreLevel){
                        ScoreUserLevelView(levelNumber: self.levelInfo.numLevel).environmentObject(self.fireDBHelper)
                            .presentationDetents([.fraction(0.8), .large])
                    }
                    
                    Button{
                        self.bestScoreLevel = true
                        
                    }label: {Image(systemName: "trophy")}
                    .sheet(isPresented: self.$bestScoreLevel){
                        ScoreBestLevelView(levelNumber: self.levelInfo.numLevel).environmentObject(self.fireDBHelper)
                            .presentationDetents([.fraction(0.8)])
                    }
                }
            }
//        }//GeometryReader ends
        .onAppear(){
            self.boardPlayer.removeAll()
            print("boardPlayer removeAll: \(self.boardPlayer)")
            
            for row in 0..<self.levelInfo.numFields{
                for col in 0..<self.levelInfo.numFields{
                    self.singleton.polulateBoardPlayer.append("")
                }
                self.boardPlayer.append(self.singleton.polulateBoardPlayer)
                self.singleton.polulateBoardPlayer.removeAll()
            }
            print("boardPlayer after : \(self.boardPlayer)")
            
            self.board.removeAll()
            self.board = self.levelInfo.matrixLevel
            
            self.boardItem.removeAll()
            self.boardItem = self.levelInfo.matrixLevelItem
            
            self.wordsList.removeAll()
            self.wordsList = self.levelInfo.wordsList
            
            self.answers.removeAll()
            self.answers = self.levelInfo.wordsList
            
            self.correctArray.removeAll()
            
        }//onappear
    }//body ends
    
    func getData(){
        
        self.correctArray.removeAll()
        
        for row in 0..<self.levelInfo.numFields{
            for col in 0..<self.levelInfo.numFields{
                self.singleton.temporalWords.append(boardPlayer[row][col])
            }
            self.singleton.realWords.append(self.singleton.temporalWords.joined(separator: ""))
            self.singleton.temporalWords.removeAll()
        }
        
        for col in 0..<self.levelInfo.numFields{
            for row in 0..<self.levelInfo.numFields{
                self.singleton.temporalWords.append(boardPlayer[row][col])
            }
            self.singleton.realWords.append(self.singleton.temporalWords.joined(separator: ""))
            self.singleton.temporalWords.removeAll()
        }
        
        for correctWord in answers{
            for userFound in self.singleton.realWords{
                
                if(userFound.contains(correctWord.word) && boardPlayer[correctWord.posFirstRow][correctWord.posFirstCol] == board[correctWord.posFirstRow][correctWord.posFirstCol] && boardPlayer[correctWord.posLastRow][correctWord.posLastCol] == board[correctWord.posLastRow][correctWord.posLastCol]){
                    self.numCorrect += 1
                    self.correctArray.append("\(correctWord.number). \(correctWord.word)")
                }
                
            }
        }
        
        if(self.correctArray.isEmpty){
            self.title = "ERROR"
            self.message = "Sorry you got 0 corrects answers of \(self.answers.count)"
            self.showingAlert = true
        }else{
            self.title = "ANSWERS FOUND"
            self.message = "Congratulations you got \(self.correctArray.count) corrects answers of \(self.answers.count)"
            self.showingAlert = true
        }
        
        self.fireDBHelper.insertScoreLevel(collectionLevel: "LEVEL \(self.levelInfo.numLevel)", newScore: LevelStore(email: self.fireDBHelper.loggedInUserEmail, score: self.correctArray.count))
        
        self.fireDBHelper.insertScoreUserLevel(collectionLevel: "LEVEL \(self.levelInfo.numLevel)", newScore: LevelStore(email: self.fireDBHelper.loggedInUserEmail, score: self.correctArray.count))
        
    }
    
    func pronunciation(word : String){
        
        guard let url = Bundle.main.url(forResource: word, withExtension: ".mp3") else {return}
        
        do{
            self.player = try AVAudioPlayer(contentsOf: url)
            self.player?.play()
        }catch let error{
            print("Error playing sound \(error.localizedDescription)")
        }
        
    }
}
