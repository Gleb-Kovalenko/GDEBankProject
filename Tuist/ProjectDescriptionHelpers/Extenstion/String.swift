//
//  String.swift
//  ProjectDescriptionHelpers
//
//  Created by Gleb Kovalenko on 11.07.2024.
//

import ProjectDescription

// MARK: - String

extension String {
    
    /// Convert string to source file glob
    public var toGlob: SourceFileGlob {
        SourceFileGlob.glob(
            .relativeToRoot(self)
        )
    }
    
    /// Convert string to string relative to root
    public var relativeToRoot: String {
        let rootPath: Path = .relativeToRoot(self)
        return rootPath.pathString
    }
    
    /// Convert string to resource file element
    public var toResourceFileElement: ResourceFileElement {
        return ResourceFileElement.glob(
            pattern: .relativeToRoot(self),
            excluding: [],
            tags: [],
            inclusionCondition: nil
        )
    }
}
