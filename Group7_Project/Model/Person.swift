//
//  Event.swift
//  Group7_Project
//
//  Created by Winona Lee on 2023-03-26.
//

import Foundation
import MapKit

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let gender : String
    let age : Int
    let coordinate: CLLocationCoordinate2D
}
