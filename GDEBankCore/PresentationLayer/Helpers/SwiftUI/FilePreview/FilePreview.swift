//
//  FilePreview.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import ComposableArchitecture
import Foundation

// MARK: - FilePreview

@Reducer
public struct FilePreview {

    // MARK: - Aliases

    public typealias State  = FilePreviewState
    public typealias Action = FilePreviewAction
    
    // MARK: - Initializers
    
    public init() {
    }
    
    // MARK: - Feature
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                guard let fileURL = state.fileURL else {
                    state.isNoFileObtained = true
                    return .none
                }
                state.isRemotingOperation = true
                return .run(
                    operation: { send in
                    try DiggerManager
                        .shared
                        .download(with: fileURL)
                        .completion { result in
                            Task {
                                switch result {
                                case .success(let localFileUrl):
                                    await send(.fileDownloaded(localFileUrl))
                                case .failure(let error):
                                    await send(.errorOccured(error as NSError))
                                }
                            }
                        }
                    },
                    catch: { error, send in
                        await send(.errorOccured(error as NSError))
                    }
                )
            case .fileDownloaded(let url):
                state.isRemotingOperation = false
                state.localFileURL = url
            case .shareSheetButtonTapped:
                guard let localFileURL = state.localFileURL else {
                    return .none
                }
                state.shareSheet = ShareSheetState(activityItem: localFileURL)
            case .shareSheetDismiss:
                state.shareSheet = nil
            case .errorOccured(let error):
                state.isRemotingOperation = false
                if let url = error.diggerFileURLString,
                   error.code == AppConstants.ErrorCodes.theFileHasbeenDownloadedError {
                    return .send(.fileDownloaded(url))
                }
                state.alert = .show(error: error)
                state.isNoFileObtained = true
            case .onDisappear:
                if let url = state.localFileURL{
                    try? FileManager.default.removeItem(at: url)
                }
            default:
                break
            }
            return .none
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
