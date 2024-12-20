//
//  FilePreviewState.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture

// MARK: - FilePreviewState

@ObservableState
public struct FilePreviewState: Equatable, Identifiable {
    
    // MARK: - Properties
    
    /// Id
    public var id: String {
        fileURL?.absoluteString ?? "file-preview-id"
    }
    
    /// File url
    public let fileURL: URL?
    
    /// Local file url
    public var localFileURL: URL?
    
    /// Indicates is remoting operation now
    public var isRemotingOperation = false
    
    /// Indicates is remoting operation now
    public var isNoFileObtained = false
    
    // MARK: - Children
    
    /// `AlertState` instance
    ///
    /// It's an instance of `Alert` submodule.
    /// We use it here to be able to integrate `Alert` feature into a current module logic.
    /// All necessary processing is placed inside current reducer. Also, if you change the state
    /// inside the `Alert` module all changes will be saved here.
    @Presents public var alert: AlertState<DXAlertAction>?
    
    /// Share sheet state instance
    @Presents public var shareSheet: ShareSheetState<FilePreviewAction>?
}

// MARK: - Initializers

extension FilePreviewState {
    
    public init(fileURL: URL?) {
        self.fileURL = fileURL
    }
}
