//
//  AnnotationView.swift
//  Group7_Project
//
//  Created by Winona Lee on 2023-03-27.
//

import SwiftUI

struct AnnotationView: View {
    @State private var showTitle = true
      
      let title: String
      
      var body: some View {
        VStack(spacing: 0) {
          Text(title)
            .font(.callout)
            .padding(5)
            .background(Color(.white))
            .cornerRadius(10)
            .opacity(showTitle ? 0 : 1)
          
          Image(systemName: "mappin.circle.fill")
            .font(.title)
            .foregroundColor(.red)
          
          Image(systemName: "arrowtriangle.down.fill")
            .font(.caption)
            .foregroundColor(.red)
            .offset(x: 0, y: -5)
        }
        .onTapGesture {
          withAnimation(.easeInOut) {
            showTitle.toggle()
          }
        }
      }
}

//struct AnnotationView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnnotationView()
//    }
//}
