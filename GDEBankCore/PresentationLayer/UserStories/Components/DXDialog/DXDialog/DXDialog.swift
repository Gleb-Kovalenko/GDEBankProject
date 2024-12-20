//
//  DXDialog.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import ComposableArchitecture
import Foundation

// MARK: - DXDialog

@Reducer
public struct DXDialog {

    // MARK: - Aliases

    public typealias State  = DXDialogState
    public typealias Action = DXDialogAction
    
    // MARK: - Initializers
    
    // MARK: - Properties
    
    /// `FileManager` instance
    private let fileManager: FileManager?
    
    // MARK: - Initializers
    
    public init(
        fileManager: FileManager? = nil
    ) {
        self.fileManager = fileManager
    }
    
    // MARK: - Feature
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .getReceiptButtonTapped:
                guard let fileURL = state.fileURL else {
                    return .none
                }
                return .send(.fileLinkObtained(fileURL))
            case .fileLinkObtained(let url):
                state.filePreview = FilePreviewState(fileURL: url)
            default:
                break
            }
            return .none
        }
        .ifLet(\.$alert, action: \.alert)
        .ifLet(\.$filePreview, action: \.filePreview) {
            FilePreview()
        }
    }
}
