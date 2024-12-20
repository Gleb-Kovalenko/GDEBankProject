//
//  PreScripts.swift
//  ProjectDescriptionHelpers
//
//  Created by Gleb Kovalenko on 24.06.2024.
//

import ProjectDescription

// MARK: - PreScripts

public enum PreScripts: CaseIterable {
    
    // MARK: - Cases
    
    case daoAuthograph
    case swiftGen
    
    // MARK: - Useful
    
    public var name: String {
        switch self {
        case .daoAuthograph: "dao-autograph"
        case .swiftGen: "SwiftGen"
        }
    }
    
    public func scriptString(for targetName: String) -> String {
        switch self {
        case .daoAuthograph:"""
            DAO_AUTOGRAPH_PATH=Codegen/dao-autograph

            if [ -f $DAO_AUTOGRAPH_PATH ]
            then
                echo "dao-autograph executable found"
            else
                osascript -e 'tell app "Xcode" to display dialog "DAO generator executable not found in \nCodegen/dao-autograph" buttons {"OK"} with icon caution'
            fi

            $DAO_AUTOGRAPH_PATH \
                -translators "$SRCROOT/$PROJECT_NAME/BusinessLayer/DAO/Translators" \
                -models "$SRCROOT/$PROJECT_NAME/Application/Models/Database" \
                -plains "$SRCROOT/$PROJECT_NAME/Application/Models/Plains" \
                -enums "$SRCROOT/$PROJECT_NAME/Application/Models/Enums" \
                -project_name $PROJECT_NAME \
                -accessibility "public" \
                -verbose
            """
        case .swiftGen:
            "./../SwiftGen/bin/swiftgen --config ./Resources/\(targetName.lowercased())-swiftgen.yml"
        }
    }
    
    public var isAvailable: Bool {
        switch self {
        case .daoAuthograph: false
        case .swiftGen: true
        }
    }
    
    public func script(for targetName: String) -> TargetScript {
        .pre(script: scriptString(for: targetName), name: name)
    }
    
}
