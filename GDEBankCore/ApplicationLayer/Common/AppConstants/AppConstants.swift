//
//  Constants.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 29.09.2024.
//

import Combine
import Foundation
import HTTPTransport
import UIKit

// MARK: - Constants

public enum AppConstants {
    
    public static let rootCategoryID = "ROOT_CATEGORY"
    public static let zeroWidthSpace = "\u{200B}"
    public static let mockExistedOrganizationCategoryID = "1"
    
    // MARK: - UserDefaultsKeys
    
    public enum UserDefaultsKeys: String, CaseIterable {
        
        case currentUserId = "gdeBank.current-user-id"
        case subscription = "gdeBank.subscription"
        case session = "gdeBank.session"
        case isOnboardingActive = "gdeBank.onboarding"
        case notificationRequested = "gdeBank.notifications-request"
        case resendTimeInterval = "gdeBank.resend-code-interval"
        case useFaceID = "gdeBank.settings.face-id"
        case useTouchID = "gdeBank.settings.touch-id"
        case useDarkTheme = "gdeBank.settings.dark-theme"
        case passcode = "user-passcode"
        case fcmToken = "fcm-token"
        case userLastCard = "gdeBank.user-last-card"
        case userEmail = "gdeBank.user-email"
        case userPhone = "gdeBank.user-phone"
        
        public var shouldRemoveOnCleaning: Bool {
            switch self {
            case .notificationRequested:
                return false
            default:
                return true
            }
        }
    }
    
    // MARK: - ErrorCodes
    
    public enum ErrorCodes {
        public static let theFileHasbeenDownloadedError = 9982
    }
    
    // MARK: - InfoPlistKeys
    
    public enum InfoPlistKeys {
        public static let useMock = "Use mock"
        public static let apiKey = "Api key"
        public static let urlSchemeSalt = "URL scheme salt"
        public static let encryptionKey = "Encryption key"
        public static let intercomApiKey = "IntercomApiKey"
        public static let intercomAppID = "IntercomAppId"
    }
    
    // MARK: - UserProfile
    
    public enum UserProfile {
        public static let pickedImage = "avatar-picked-image.jpeg"
    }
    
    // MARK: - Review

    public enum Review {
        public static let totalRating = 5
    }
    
    // MARK: - Sharing
    
    public enum Sharing {
        public static let shareLinkURL = URL(string: "https://testflight.apple.com/join/bw5wCtJz").unsafelyUnwrapped
        public static let appGroupName = "group.com.gdeBank"
    }

    // MARK: - Network
    
    public enum Network {

        public static let retryAttemptsCount = 7

        public static var apiURL: URL {
            URL(string: "https://host.gde-bank.io/api/v1").unsafelyUnwrapped
        }
        
        public static let requestDelay: DispatchQueue.SchedulerTimeType.Stride = 0.25
        
        // MARK: - Pagination
        
        public enum Pagination {
            public static let previewItemsCount = 5
            public static let pageSize = 17
            public static let transactionsPageSize = 8
        }
        
        // MARK: - ErrorBodyKeys
        
        public enum ErrorBodyKeys {
            
            public static let verificationToken = "verification_token"
            public static let theFileHasbeenDownloaded = "theFileHasbeenDownloaded"
        }
        
        // MARK: - Headers
        
        public enum Headers {
            
            public static let userAgent   = "User-Agent"
            public static let accessToken = "Authorization"
            public static let secretKey   = "secretKey"
            public static let device      = "X-Device"
            public static let osVersion   = "X-OS"
            public static let build       = "X-Build"
            public static let client      = "X-Client"
            public static let locale      = "X-Locale"
            public static let apiKey      = "API-KEY"
            
            // MARK: - Pagination
            
            public enum Pagination {
                public static let page = "X-Pagination-Current-Page"
                public static let perPage = "X-Pagination-Per-Page"
            }
        }
        
        // MARK: - Logging
        
        public enum Logging {
            public static let request = LogRequestInterceptor.LogLevel.curl
            public static let response = LogResponseInterceptor.LogLevel.everything
        }
    }

    // MARK: - Business

    public enum Business {

        public static let defaultVideoFormat = "mp4"
        public static let localMediaFolder = "LocalMedia101GROUP"
        public static let maxVideoDuration: TimeInterval = 60
        public static let timerPlayingInterval: TimeInterval = 0.033
        public static let gdeBankWalletAppStoreId = "544007664"
        public static let gdeBankAppStoreId = "544007664"
        
        public enum Currency {
            public static let fiatRound = 2
            public static let cryptoRound = 8
        }
        
        public enum TextFields {
            public static let maxEmailLength = 32
            public static let maxPasswordLength = 32
            public static let maxAmountLength = 32
            public static let maxIBANLength = 29
            public static let maxMemoLength = 64
            public static let maxCardLength = 19
        }
        
        public static let supportEmailAddress = "support@gdeBank.app"
        
        public static var settingURL: URL {
            if let bundleId = Bundle.main.bundleIdentifier,
               let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)")
            {
                return url
            } else {
                return URL(string: "\(UIApplication.openSettingsURLString)").unsafelyUnwrapped
            }
        }
        
        public static let termsURL = URL(string: "https://docs.google.com/document/d/1Rfx7BoP498MHB8ODE6Dka6TSMTc9_jIm5shPvCc7A6g").unsafelyUnwrapped
        public static let privacyURL = URL(string: "https://docs.google.com/document/d/1sXHijLP-NIoTA8a9uKHR4fSlwo8Zdm-lrT-fxMQ9qzE").unsafelyUnwrapped
        public static let applicationURL = URL(string: "https://incetro.notion.site/8f3e00077e5e44d585b17443c06f9d50").unsafelyUnwrapped
        public static let supportURL = URL(string: "https://incetro.notion.site/8f3e00077e5e44d585b17443c06f9d50").unsafelyUnwrapped
        public static let changeNumberURL = URL(string: "https://incetro.notion.site/8f3e00077e5e44d585b17443c06f9d50").unsafelyUnwrapped
        public static let telegramURL = URL(string: "t.me/gdeBankapp_bot").unsafelyUnwrapped
        public static let whatsAppURL = URL(string: "https://www.whatsapp.com/?lang=en_EN").unsafelyUnwrapped
        public static let emailURL = URL(string: "mailto:\(supportEmailAddress)").unsafelyUnwrapped
        
        public static let maxPasscodeAttemptsCount = 5
        public static let profileAvatarCompressionMeasure: Double = 850
        public static let mediaCollectionDefaultRowSize: CGFloat = 3
        public static let resendCodeInterval = 30

        public static let localMediaFolderDirectory = NSTemporaryDirectory().appending("/" + AppConstants.Business.localMediaFolder)

        public static func randomVideoFilePath(inFolder folder: String? = nil, fileExt: String = defaultVideoFormat) -> String {
            let url = localMediaFolderDirectory
            let filename = "\(NSUUID().uuidString).\(fileExt)"
            let directoryPath = (folder ?? url) as NSString
            return directoryPath.appendingPathComponent(filename)
        }

        public static func randomVideoFileURL(inFolder folder: String? = nil, fileExt: String = defaultVideoFormat) -> URL {
            URL(fileURLWithPath: randomVideoFilePath(inFolder: folder, fileExt: fileExt))
        }
        public static let appBackgoundTaskTime: TimeInterval = 25
        
        // MARK: - InfoPlistValues
        
        public static var useMock: Bool {
            if let stringUseMock = Bundle.main.object(forInfoDictionaryKey: InfoPlistKeys.useMock) as? String {
                return NSString(string: stringUseMock).boolValue
            } else {
                return false
            }
        }
        
        public static var intercomApiKey: String {
            Bundle.main.object(forInfoDictionaryKey: InfoPlistKeys.intercomApiKey) as? String ?? ""
        }
        public static var intercomAppId: String {
            Bundle.main.object(forInfoDictionaryKey: InfoPlistKeys.intercomAppID) as? String ?? ""
        }
        
        public static var urlSchemeSalt: String {
            Bundle.main.object(forInfoDictionaryKey: InfoPlistKeys.urlSchemeSalt) as? String ?? ""
        }
        
        public static var apiKey: String {
            Bundle.main.object(forInfoDictionaryKey: InfoPlistKeys.apiKey) as? String ?? ""
        }
        
        public static var encryptionKey: String {
            Bundle.main.object(forInfoDictionaryKey: InfoPlistKeys.encryptionKey) as? String ?? ""
        }
    }
    
    /// All available regular expressions
    public enum Regex {

        /// Phone regex
        public static let phone = NSRegularExpression("[0-9]{5,16}")

        /// Email regex
        public static let email = NSRegularExpression("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")

        /// Characters which user cannot use for their login
        public static let prohibitedLoginCharacters = NSRegularExpression("[ ЁёА-я]+")

        /// Password regex
        public static let password = NSRegularExpression("^.{6,32}$")

        /// Name regex
        public static let name = NSRegularExpression("^(?:[А-ЯЁ]|[А-ЯЁ][\\.\\-А-ЯЁа-яё]*[А-ЯЁа-яё])$")

        /// Username regex
        public static let username = NSRegularExpression("^[a-zA-Z_]{1}[a-zA-Z0-9_]{4,32}$")

        /// URL regex
        public static let url = NSRegularExpression("https://([-\\w\\.]+)+(:\\d+)?(/([\\w/_\\.]*(\\?\\S+)?)?)?")
        
        /// Tag name regex
        public static let tagName = NSRegularExpression("^[a-zа-яё0-9]+$")
        
        /// Last name reges
        public static let lastName = NSRegularExpression("^[\\p{L}-]{1,25}$")
    }
}

var isUITestMode: Bool {
    CommandLine.arguments.contains("UITests")
}
