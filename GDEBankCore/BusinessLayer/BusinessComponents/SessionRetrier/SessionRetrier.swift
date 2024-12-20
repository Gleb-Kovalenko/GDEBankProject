//
//  SessionRetrier.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 23.08.2024.
//

import Foundation
import ServiceCore
import HTTPTransport

// MARK: - SessionRetrier

public final class SessionRetrier: WebService {

    // MARK: - Properties

    /// SessionStorage instance
    private let sessionStorage: SessionStorage

    /// The notification center to send logout event
    public let notificationCenter: NotificationCenter = NotificationCenter.default
    
    /// App type
    public let appType: AppType

    // MARK: - Initializers

    public init(
        appType: AppType,
        sessionStorage: SessionStorage,
        transport: HTTPTransport,
        requestInterceptors: [HTTPRequestInterceptor],
        responseInterceptors: [HTTPResponseInterceptor]
    ) {
        self.appType = appType
        self.sessionStorage = sessionStorage
        super.init(
            baseURL: AppConstants.Network.apiURL,
            transport: transport,
            requestInterceptors: requestInterceptors,
            responseInterceptors: responseInterceptors
        )
    }
}

// MARK: - HTTPTransportRetrierDelegate

extension SessionRetrier: HTTPTransportRetrierDelegate {

    public var maxAttemptsCount: Int {
        AppConstants.Network.retryAttemptsCount
    }

    public func refreshForRetrieve(completion: @escaping (Bool) -> Void) {
        let call = createCall { () -> Result<Void, Error> in
            guard let session = self.sessionStorage.session() else {
                self.notificationCenter.post(name: .logout, object: nil)
                return .failure(NSError.new(message: "Cannot obtain session"))
            }

            let jsonArguments = self.fillHTTPRequestParameters(
                self.jsonParameters,
                with: [
                    "refresh_token": session.refreshToken
                ]
            )

            let request = HTTPRequest(
                httpMethod: .post,
                endpoint: self.appType.refreshTokenApiURL + "/",
                parameters: [jsonArguments],
                base: self.baseRequest
            )

            let result = self.transport.send(request: request)

            switch result {
            case .success(let response):
                do {
                    let data = response.body.unsafelyUnwrapped
                    let result = try data.decoded() as SessionRefreshPlainObject
                    self.sessionStorage.save(
                        session: session.set(
                            accessToken: result.accessToken,
                            refreshToken: result.refreshToken
                        )
                    )
                    return .success(())
                } catch {
                    return .failure(error)
                }
            case .failure(let error):
                return .failure(error)
            }
        }
        call
            .async()
            .success {
                completion(true)
            }
            .failure { error in
                let error = error as NSError
                if error.httpStatusCode == .unauthorized || error.httpStatusCode == .badRequest {
                    self.notificationCenter.post(name: .logout, object: nil)
                    return
                }
                completion(false)
            }
    }

    public func shouldRetry(_ response: URLResponse, responseJSON: Any?, error: Error) -> Bool {
        guard let httpResponse = response as? HTTPURLResponse else { return false }
        guard httpResponse.url?.absoluteString.contains("reg/social/") == false else {
            return false
        }
        if httpResponse.url?.absoluteString.contains(appType.refreshTokenApiURL) == true, httpResponse.statusCode >= 400 {
            notificationCenter.post(name: .logout, object: nil)
            return false
        }
        return httpResponse.statusCode >= 401
    }

    public func adapted(_ urlRequest: URLRequest) -> URLRequest {
        urlRequest
    }
}
