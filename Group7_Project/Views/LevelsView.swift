//
//  LevelsView.swift
//  G07_Crossword
//
//  Created by Arnulfo Sánchez on 2023-03-20.
//

import SwiftUI

struct LevelsView: View {
    
    @State private var levelsList = [Level]()
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    var body: some View {
        
        VStack{
            
            Text("MAIN")
                .font(.custom("AmericanTypewriter",fixedSize: 26).weight(.bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            if(self.levelsList.isEmpty){
                    Text("There are not levels yet")
            }
            else{
                List{
                    Section(header: Text("Levels Dino Crossword")){
                        ForEach(self.levelsList){ currentLevel in
//                            NavigationLink(destination: DetailedView(selectedLevel: currentLevel)){
                            NavigationLink(destination: GameView(levelInfo: currentLevel).environmentObject(self.fireDBHelper)){
                                Text("LEVEL \(currentLevel.numLevel)")
                                    .frame(maxWidth: .infinity, alignment: .center)
//                                    .background(Image("\(currentLevel.numLevel)").resizable().opacity(0.5))
                            }
//                            .navigationBarHidden(true)
                            .frame(height: 100)
                            .listRowBackground(Image("\(currentLevel.numLevel)").resizable().opacity(0.7))
                        }//ForEach ends
                    }//Section ends
                }//List ends
                .environment(\.defaultMinListRowHeight, 50)
            }//if-else ends
        }//NavigationView ends
        .onAppear(perform: {
            self.levelsList.removeAll()
            self.loadInitialData()
        })
        .onDisappear{
//            self.levelsList = []
        }
    }//body ends
    
    private func loadInitialData(){
        var level = Level(numLevel: 1,
                          numFields: 4,
                          matrixLevel: [["E","G","G","S"],
                                        ["S","I","M","E"],
                                        ["","À","","P"],
                                        ["S","O","L","T"]],
                          matrixLevelItem: [["1","3","","2"],
                                            ["4","","",""],
                                            ["","","",""],
                                            ["5","","",""]],
                          wordsList: [Words(number: 1, language: "English", word: "EGGS", meaning: "The oval object with a hard shell that is produced by female birds, especially chickens, eaten as food", down: false, posFirstRow: 0, posFirstCol: 0, posLastRow: 0, posLastCol: 3),
                                      Words(number: 2, language: "French", word: "SEPT", meaning: "The number 7", down: true, posFirstRow: 0, posFirstCol: 3, posLastRow: 3, posLastCol: 3),
                                      Words(number: 3, language: "Italian", word: "GIÀ", meaning: "1.Before the present time\n2.Earlier than the time expected", down: true, posFirstRow: 0, posFirstCol: 1, posLastRow: 2, posLastCol: 1),
                                      Words(number: 4, language: "Portuguese", word: "SIM", meaning: "Used to express willingness or agreement", down: false, posFirstRow: 1, posFirstCol: 0, posLastRow: 1, posLastCol: 2),
                                      Words(number: 5, language: "Spanish", word: "SOL", meaning: "The star that provides light and heat for the earth and around which the earth moves", down: false, posFirstRow: 3, posFirstCol: 0, posLastRow: 3, posLastCol: 2)])
        self.levelsList.append(level)
        
        level = Level(numLevel: 2,
                      numFields: 5,
                      matrixLevel: [["G","A","F","A","S"],
                                    ["","","O","","A"],
                                    ["O","","R","","D"],
                                    ["U","N","O","",""],
                                    ["I","","A","E","R"]],
                      matrixLevelItem: [["1","","6","","3"],
                                        ["","","","",""],
                                        ["2","","","",""],
                                        ["5","","","",""],
                                        ["","","4","",""]],
                      wordsList: [Words(number: 1, language: "Spanish", word: "GAFAS", meaning: "Two small pieces of special glass or plastic in a frame worn in front of the eyes to improve sight", down: false, posFirstRow: 0, posFirstCol: 0, posLastRow: 0, posLastCol: 4),
                                  Words(number: 2, language: "French", word: "OUI", meaning: "Used to express willingness or agreement", down: true, posFirstRow: 2, posFirstCol: 0, posLastRow: 4, posLastCol: 0),
                                  Words(number: 3, language: "English", word: "SAD", meaning: "1.Unhappy or sorry\n2.Not satisfactory or pleasant", down: true, posFirstRow: 0, posFirstCol: 4, posLastRow: 2, posLastCol: 4),
                                  Words(number: 4, language: "Romanian", word: "AER", meaning: "The mixture of gases that surrounds the earth and that we breathe", down: false, posFirstRow: 4, posFirstCol: 2, posLastRow: 4, posLastCol: 4),
                                  Words(number: 5, language: "Italian", word: "UNO", meaning: "The number 1", down: false, posFirstRow: 3, posFirstCol: 0, posLastRow: 3, posLastCol: 2),
                                  Words(number: 6, language: "Portuguese", word: "FORO", meaning: "A situation or meeting in which people can talk about a problem or matter especially of public interest", down: true, posFirstRow: 0, posFirstCol: 2, posLastRow: 3, posLastCol: 2)])
        self.levelsList.append(level)
        
        level = Level(numLevel: 3,
                      numFields: 6,
                      matrixLevel: [["C","","M","E","A","T"],
                                    ["O","M","","","","C"],
                                    ["M","A","R","D","I","H"],
                                    ["I","V","","","","A"],
                                    ["D","I","C","H","","U"],
                                    ["A","M","O","R","E",""]],
                      matrixLevelItem: [["1","","7","","","2"],
                                        ["","6","","","",""],
                                        ["5","","","","",""],
                                        ["","","","","",""],
                                        ["4","","","","",""],
                                        ["3","","","","",""]],
                      wordsList: [Words(number: 1, language: "Spanish", word: "COMIDA", meaning: "Something that people and animals eat, or plants absorb, to keep them alive", down: true, posFirstRow: 0, posFirstCol: 0, posLastRow: 5, posLastCol: 0),
                                  Words(number: 2, language: "Portuguese", word: "TCHAU", meaning: "1.Used when someone leaves\n2.The words or actions that are used when someone leaves or is left", down: true, posFirstRow: 0, posFirstCol: 5, posLastRow: 4, posLastCol: 5),
                                  Words(number: 3, language: "Italin", word: "AMORE", meaning: "To like something very much", down: false, posFirstRow: 5, posFirstCol: 0, posLastRow: 5, posLastCol: 4),
                                  Words(number: 4, language: "German", word: "DICH", meaning: "Used to refer to the person or people being spoken or written to", down: false, posFirstRow: 4, posFirstCol: 0, posLastRow: 4, posLastCol: 3),
                                  Words(number: 5, language: "French", word: "MARDI", meaning: "The day of the week after Monday and before Wednesday", down: false, posFirstRow: 2, posFirstCol: 0, posLastRow: 2, posLastCol: 4),
                                  Words(number: 6, language: "Turkish", word: "MAVI", meaning: "The salty water that covers a large part of the surface of the earth, or a large area of salty water, smaller than an ocean, that is partly or completely surrounded by land", down: true, posFirstRow: 1, posFirstCol: 1, posLastRow: 4, posLastCol: 1),
                                  Words(number: 7, language: "English", word: "MEAT", meaning: "The flesh of an animal when it is used for food", down: false, posFirstRow: 0, posFirstCol: 2, posLastRow: 0, posLastCol: 5)])
        self.levelsList.append(level)
        
        level = Level(numLevel: 4,
                      numFields: 7,
                      matrixLevel: [["O","","H","","K","","S"],
                                    ["P","R","O","D","U","C","T"],
                                    ["P","E","N","","L","","O"],
                                    ["D","I","D","","E","","L"],
                                    ["R","E","I","N","","S","Ì"],
                                    ["A","W","A","N","S","A","L"],
                                    ["G","L","Ä","S","E","R",""]],
                      matrixLevelItem: [["2","","4","","5","","6"],
                                        ["1","7","","","","",""],
                                        ["","","","","","",""],
                                        ["","","","","","",""],
                                        ["8","","","","","11",""],
                                        ["10","","","","9","",""],
                                        ["3","","","","","",""]],
                      wordsList: [Words(number: 1, language: "English", word: "PRODUCT", meaning: "Something that is made to be sold, usually something that is produced by an industrial process or, less commonly, something that is grown or obtained through farming", down: false, posFirstRow: 1, posFirstCol: 0, posLastRow: 1, posLastCol: 6),
                                  Words(number: 2, language: "Norwegian", word: "OPPDRAG", meaning: "A piece of work given to someone, typically as part of their studies or job", down: true, posFirstRow: 0, posFirstCol: 0, posLastRow: 6, posLastCol: 0),
                                  Words(number: 3, language: "German", word: "GLÄSER", meaning: "Two small pieces of special glass or plastic in a frame worn in front of the eyes to improve sight", down: false, posFirstRow: 6, posFirstCol: 0, posLastRow: 6, posLastCol: 5),
                                  Words(number: 4, language: "Dutch", word: "HOND", meaning: "A common animal with four legs, especially kept by people as a pet or to hunt or guard things", down: true, posFirstRow: 0, posFirstCol: 2, posLastRow: 3, posLastCol: 2),
                                  Words(number: 5, language: "Turkish", word: "KULE", meaning: "A tall, narrow structure, often square or circular, that either forms part of a building or stands alone", down: true, posFirstRow: 0, posFirstCol: 4, posLastRow: 3, posLastCol: 4),
                                  Words(number: 6, language: "Swedish", word: "STOL", meaning: "A seat for one person that has a back, usually four legs, and sometimes two arms", down: true, posFirstRow: 0, posFirstCol: 6, posLastRow: 3, posLastCol: 6),
                                  Words(number: 7, language: "Portuguese", word: "REI", meaning: "(The title of) a male ruler of a country, who holds this position because of his royal birth", down: true, posFirstRow: 1, posFirstCol: 1, posLastRow: 3, posLastCol: 1),
                                  Words(number: 8, language: "French", word: "REIN", meaning: "Either of a pair of small organs in the body that take away waste matter from the blood to produce urine", down: false, posFirstRow: 4, posFirstCol: 0, posLastRow: 4, posLastCol: 3),
                                  Words(number: 9, language: "Spanish", word: "SAL", meaning: "A common white substance found in sea water and in the ground, used especially to add flavour to food or to preserve it", down: false, posFirstRow: 5, posFirstCol: 4, posLastRow: 5, posLastCol: 6),
                                  Words(number: 10, language: "Polish", word: "AWANS", meaning: "Activities to advertise something", down: false, posFirstRow: 5, posFirstCol: 0, posLastRow: 5, posLastCol: 4),
                                  Words(number: 11, language: "Italian", word: "SÌ", meaning: "Used to express willingness or agreement", down: false, posFirstRow: 4, posFirstCol: 5, posLastRow: 4, posLastCol: 6)])
        self.levelsList.append(level)
        
        level = Level(numLevel: 5,
                      numFields: 8,
                      matrixLevel: [["S","K","J","Ø","R","T","D","P"],
                                    ["","A","I","L","","D","I","A"],
                                    ["L","","","","S","","N","A"],
                                    ["U","G","R","A","I","","O","R"],
                                    ["N","S","C","H","L","O","S","S"],
                                    ["A","K","","","L","","A",""],
                                    ["","O","H","Ň","A","","U",""],
                                    ["Ä","T","A","","K","A","R","T"]],
                      matrixLevelItem: [["2","","","3","","","1","8"],
                                        ["","11","","","","10","",""],
                                        ["9","","","","13","","",""],
                                        ["12","","","","","","",""],
                                        ["","5","","","","","",""],
                                        ["","4","","","","","",""],
                                        ["","14","","","","","",""],
                                        ["6","","","","7","","",""]],
                      wordsList: [Words(number: 1, language: "English", word: "DINOSAUR", meaning: "A type of reptile that became extinct about 65,000,000 years ago", down: true, posFirstRow: 0, posFirstCol: 6, posLastRow: 7, posLastCol: 6),
                                  Words(number: 2, language: "Norwegian", word: "SKJØRT", meaning: "A piece of clothing for women and girls that hangs from the waist and does not have legs", down: false, posFirstRow: 0, posFirstCol: 0, posLastRow: 0, posLastCol: 5),
                                  Words(number: 3, language: "Danish", word: "ØL", meaning: "An alcoholic drink made from grain and hops", down: true, posFirstRow: 0, posFirstCol: 3, posLastRow: 1, posLastCol: 3),
                                  Words(number: 4, language: "Polish", word: "KOT", meaning: "A machine that uses the energy from liquid fuel or steam to produce movement", down: true, posFirstRow: 5, posFirstCol: 1, posLastRow: 7, posLastCol: 1),
                                  Words(number: 5, language: "German", word: "SCHLOSS", meaning: "A large strong building, built in the past by a ruler or important person to protect the people inside from attack", down: false, posFirstRow: 4, posFirstCol: 1, posLastRow: 4, posLastCol: 7),
                                  Words(number: 6, language: "Swedish", word: "ÄTA", meaning: "To put or take food into the mouth, chew it, and swallow it", down: false, posFirstRow: 7, posFirstCol: 0, posLastRow: 7, posLastCol: 2),
                                  Words(number: 7, language: "Turkish", word: "KART", meaning: "A small, rectangular piece of card or plastic, often with your signature, photograph, or other information proving who you are", down: false, posFirstRow: 7, posFirstCol: 4, posLastRow: 7, posLastCol: 7),
                                  Words(number: 8, language: "Dutch", word: "PAARS", meaning: "A dark reddish-blue colour", down: true, posFirstRow: 0, posFirstCol: 7, posLastRow: 4, posLastCol: 7),
                                  Words(number: 9, language: "Italian", word: "LUNA", meaning: "The round object that moves in the sky around the earth and can be seen at night", down: true, posFirstRow: 2, posFirstCol: 0, posLastRow: 5, posLastCol: 0),
                                  Words(number: 10, language: "Portuguese", word: "DIA", meaning: "A period of 24 hours, especially from twelve o'clock one night to twelve o'clock the next night", down: false, posFirstRow: 1, posFirstCol: 5, posLastRow: 1, posLastCol: 7),
                                  Words(number: 11, language: "French", word: "AIL", meaning: "A plant of the onion family that has a strong taste and smell and is used in cooking to add flavour", down: false, posFirstRow: 1, posFirstCol: 1, posLastRow: 1, posLastCol: 3),
                                  Words(number: 12, language: "Hungarian", word: "UGRAI", meaning: "To push yourself suddenly off the ground and into the air using your legs", down: false, posFirstRow: 3, posFirstCol: 0, posLastRow: 3, posLastCol: 4),
                                  Words(number: 13, language: "Spanish", word: "SILLA", meaning: "A seat for one person that has a back, usually four legs, and sometimes two arms", down: true, posFirstRow: 2, posFirstCol: 4, posLastRow: 6, posLastCol: 4),
                                  Words(number: 14, language: "Slovak", word: "OHŇA", meaning: "The state of burning that produces flames that send out heat and light, and might produce smoke", down: false, posFirstRow: 6, posFirstCol: 1, posLastRow: 6, posLastCol: 4)])
        self.levelsList.append(level)
    }
}//LevelsView ends

struct LevelsView_Previews: PreviewProvider {
    static var previews: some View {
        LevelsView()
    }
}
