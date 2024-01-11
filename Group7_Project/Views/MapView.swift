//
//  MapView.swift
//  Group7_Project
//
//  Created by Winona Lee on 2023-03-26.
//
import MapKit
import SwiftUI

struct MapView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3, longitude: -122.4), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))

    @State private var annotations : [Person] = []

    var body: some View {
        VStack{
            Text("Find players close to your location and complete with them")
            Map(coordinateRegion: $region, annotationItems: annotations) { person in
                MapAnnotation(coordinate: person.coordinate) {
                    AnnotationView(title: "\(person.name)\n\(person.gender)\nAge: \(person.age)")
                }
            }
            .frame(width: 400, height: 500)
        }
        .onAppear{
            self.fireDBHelper.getSharedUsers()
            self.usersToAnnotations()
        }
    }
    func usersToAnnotations (){
        self.annotations = []
        for data in self.fireDBHelper.sharedProfile { 
            let thisLocation = CLLocationCoordinate2D(latitude: data.pLat, longitude: data.pLog)
            self.annotations.append(Person(name: data.pName, gender: data.pGender, age: data.pAge, coordinate: thisLocation))
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
