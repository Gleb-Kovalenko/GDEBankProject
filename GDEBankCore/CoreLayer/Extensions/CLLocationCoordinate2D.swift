//
//  CLLocationCoordinate2D.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 15.08.2024.
//

import CoreLocation

// MARK: - CLLocationCoordinate2D+Equatable

extension CLLocationCoordinate2D: Equatable {
    
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

// MARK: - Identifiable

extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}
