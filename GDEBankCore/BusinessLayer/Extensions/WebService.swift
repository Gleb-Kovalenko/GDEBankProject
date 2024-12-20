//
//  WebService.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 14.08.2024.
//

import Foundation
import ServiceCore
import HTTPTransport

// MARK: - WebService

extension WebService {
    
    public convenience init(transport: HTTPTransport) {
        self.init(
            baseURL: AppConstants.Network.apiURL,
            transport: transport
        )
    }
}

// MARK: - AsyncCall

extension WebService {
    
    /// Assemble a sync/async call object.
    /// - Parameters:
    ///   - request: target HTTP request for processing.
    ///   - responseProcessing: additional closure for result processing.
    /// - Returns: assembled service call ready to call.
    public func asyncCall<T: Decodable>(
        from request: HTTPRequest,
        _ responsePrecessing: ((T) -> Void)? = nil
    ) async throws -> T {
        let result = try await transport.send(request: request)
        switch result {
        case .success(let response):
            guard let data = response.body else {
                throw NSError.new(message: "No response body")
            }
            let result = try data.decoded() as T
            responsePrecessing?(result)
            return result
        case .failure(error: let error):
            throw error.error
        }
    }
    
    /// Assemble a sync/async call object.
    /// - Parameters:
    ///   - request: target HTTP request for processing.
    ///   - responseProcessing: additional closure for result processing.
    /// - Returns: assembled service call ready to call.
    public func asyncPaginatedCall<T: Decodable & Equatable>(
        from request: HTTPRequest,
        page: Int,
        pageSize: Int,
        _ responsePrecessing: ((DXPaginationPlainObject<T>) -> Void)? = nil
    ) async throws -> DXPaginationPlainObject<T> {
        let result = try await transport.send(request: request)
        switch result {
        case .success(let response):
            guard let data = response.body else {
                throw NSError.new(message: "No response body")
            }
            let response = try data.decoded() as DXPaginationResponsePlainObject<T>
            let result = response.convert(page: page, pageSize: pageSize)
            responsePrecessing?(result)
            return result
        case .failure(error: let error):
            throw error.error
        }
    }

    /// Assemble a sync/async call object with specific data key.
    /// - Parameters:
    ///   - request: target HTTP request for processing.
    ///   - dataByKey: the key to extract specific data from the response.
    ///   - responseProcessing: additional closure for result processing.
    /// - Returns: assembled service call ready to call.
    public func asyncCall<T: Decodable>(
        from request: HTTPRequest,
        dataByKey: String,
        _ responsePrecessing: ((T) -> Void)? = nil
    ) async throws -> T {
        let result = try await transport.send(request: request)
        switch result {
        case .success(let response):
            do {
                let json = try response.getJSONDictionary()?.data(byKey: dataByKey)
                guard let json else {
                    throw NSError.new(message: "No response body")
                }
                if let result = json as? T {
                    responsePrecessing?(result)
                    return result
                }
                let jsonData = try JSONSerialization.data(withJSONObject: json)
                let result = try jsonData.decoded() as T
                responsePrecessing?(result)
                return result
            } catch {
                throw error
            }
        case .failure(error: let error):
            throw error.error
        }
    }
}

// MARK: - String

extension String {
    
    public var asResultBool: Bool {
        self == "success"
    }
}
