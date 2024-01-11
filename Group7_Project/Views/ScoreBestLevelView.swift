//
//  ScoreBestLevelView.swift
//  G07_Crossword
//
//  Created by Arnulfo Sánchez on 2023-03-28.
//

import SwiftUI

struct ScoreBestLevelView: View {
    
    let levelNumber : Int
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    var body: some View {
        VStack{
            Text("Best Scores of all games played of the Level #\(levelNumber)")
                .font(.custom("AmericanTypewriter",fixedSize: 20).weight(.bold))
                .foregroundColor(.blue)
            
            Spacer()
            if(self.fireDBHelper.levelScoreList.isEmpty){
                Text("There are not any score in this level yet")
            }
            else{
                List{
                    ForEach(self.fireDBHelper.levelScoreList.enumerated().map({$0}), id: \.element.self){index, currentScore in
                        
                        HStack(spacing: 10){
                            Text("\(index + 1).")
                                .foregroundColor(.blue)
                                .fontWeight(.bold)
                                .italic()
                                .frame(maxHeight: .infinity, alignment: .topLeading)
                            VStack(alignment: .leading){
                                
                                Text("User email : \(currentScore.pEmail)")
                                    .bold()
                                Text("Score : \(currentScore.pScore)")
                                    .fontWeight(.bold)
                                    .italic()
                                Text("Date : \(currentScore.dateAdded.formatted(date: .long, time: .shortened))")
                                
                            }//VStack
                        }
                    }//ForEach
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }//List ends
                
            }
            Spacer()
        }
        .padding()
        .onAppear(){
            self.fireDBHelper.getAllScore(collectionLevel: "LEVEL \(self.levelNumber)")
        }
    }
}


