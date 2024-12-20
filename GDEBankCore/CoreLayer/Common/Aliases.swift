//
//  Aliases.swift
//  SwiftyKit
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2019 Incetro Inc. All rights reserved.
//

import Combine
import TCANetworkReducers
import Foundation

// MARK: - Aliases

/// Request/Response parameters
public typealias Parameters = [String: Any]

/// Request/Response headers
public typealias Headers = [String: String]

/// Simple swift result block
public typealias ResultBlock<T> = (Result<T, Error>) -> Void

/// Block with some error
public typealias ErrorBlock = (Error) -> Void

/// Block with some errors
public typealias ErrorsBlock = ([Error]) -> Void

/// Block with some error message
public typealias ErrorMessageBlock = (String) -> Void

/// Services success block for `ObtainAll` operation
public typealias ServiceObtainAllSuccessBlock<T> = ([T]) -> Void

/// Services failure block for `ObtainAll` operation
public typealias ServiceObtainAllFailureBlock = ErrorBlock

/// Services success block for `Obtain` operation
public typealias ServiceObtainSuccessBlock<T> = (T) -> Void

/// Services failure block for `Obtain` operation
public typealias ServiceObtainFailureBlock = ErrorBlock

/// Services success block for `Update` operation
public typealias ServiceUpdateSuccessBlock<T> = (T) -> Void

/// Services failure block for `Update` operation
public typealias ServiceUpdateFailureBlock = ErrorBlock

/// Services success block for `Create` operation
public typealias ServiceCreateSuccessBlock<T> = (T) -> Void

/// Services failure block for `Create` operation
public typealias ServiceCreateFailureBlock = ErrorBlock

/// Services success block for `Remove` operation
public typealias ServiceRemoveSuccessBlock = () -> Void

/// Services failure block for `Remove` operation
public typealias ServiceRemoveFailureBlock = ErrorBlock

/// Simple void closure alias
public typealias VoidClosure = () -> Void

// MARK: - Storage

public typealias PaginatedObtain<T: Decodable & Equatable> = ((_ page: Int, _ pageSize: Int) -> AnyPublisher<PaginatedResponsePlainObject<T>, NSError>)

public typealias StraightArrayObtain<T: Decodable & Equatable> = ((_ page: Int, _ pageSize: Int) -> AnyPublisher<[T], NSError>)

// MARK: - NetworkReducer

public typealias DXPaginationState<T: Decodable & Equatable> = PaginationState<DXPaginationPlainObject<T>>
public typealias DXIDPaginationState<T: Decodable & Equatable, ID: Equatable> = IDPaginationState<DXPaginationPlainObject<T>, ID>
public typealias DXPaginationAction<T: Decodable & Equatable, ErrorType: NSError> = PaginationAction<DXPaginationPlainObject<T>, ErrorType>

// MARK: - NetworkReducer

public typealias DXReloadableState<Data: Equatable, ErrorType: Error & Equatable> = ReloadableState<Data, ErrorType>
public typealias DXIDReloadableState<Data: Equatable, ID: Equatable, ErrorType: Error & Equatable> = IDReloadableState<Data, ID, ErrorType>
