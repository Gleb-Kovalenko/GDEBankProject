//
//  DXImageType.swift
//  GDEBank
//
//  Created by incetro on 12/10/23.
//

import Foundation

// MARK: - DXImageType

public enum DXImageType {
    
    // MARK: - Cases
    
    case imageURL(URL?)
    case assetsImage(String)
    case systemImage(String)
}
