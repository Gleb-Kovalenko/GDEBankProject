// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Plist Files

// swiftlint:disable identifier_name line_length type_body_length
public enum PlistFiles {
  private static let _document = PlistDocument(path: "GDEBankInfo.plist")
  public static let apiKey: String = _document["Api key"]
  public static let cfBundleDevelopmentRegion: String = _document["CFBundleDevelopmentRegion"]
  public static let cfBundleDisplayName: String = _document["CFBundleDisplayName"]
  public static let cfBundleExecutable: String = _document["CFBundleExecutable"]
  public static let cfBundleIdentifier: String = _document["CFBundleIdentifier"]
  public static let cfBundleInfoDictionaryVersion: String = _document["CFBundleInfoDictionaryVersion"]
  public static let cfBundleName: String = _document["CFBundleName"]
  public static let cfBundlePackageType: String = _document["CFBundlePackageType"]
  public static let cfBundleShortVersionString: String = _document["CFBundleShortVersionString"]
  public static let cfBundleURLTypes: [[String: Any]] = _document["CFBundleURLTypes"]
  public static let cfBundleVersion: String = _document["CFBundleVersion"]
  public static let encryptionKey: String = _document["Encryption key"]
  public static let itsAppUsesNonExemptEncryption: Bool = _document["ITSAppUsesNonExemptEncryption"]
  public static let lsApplicationCategoryType: String = _document["LSApplicationCategoryType"]
  public static let lsApplicationQueriesSchemes: [String] = _document["LSApplicationQueriesSchemes"]
  public static let lsRequiresIPhoneOS: Bool = _document["LSRequiresIPhoneOS"]
  public static let nsAppTransportSecurity: [String: Any] = _document["NSAppTransportSecurity"]
  public static let nsCameraUsageDescription: String = _document["NSCameraUsageDescription"]
  public static let nsFaceIDUsageDescription: String = _document["NSFaceIDUsageDescription"]
  public static let nsLocationWhenInUseUsageDescription: String = _document["NSLocationWhenInUseUsageDescription"]
  public static let nsMicrophoneUsageDescription: String = _document["NSMicrophoneUsageDescription"]
  public static let nsPhotoLibraryUsageDescription: String = _document["NSPhotoLibraryUsageDescription"]
  public static let uiApplicationSupportsIndirectInputEvents: Bool = _document["UIApplicationSupportsIndirectInputEvents"]
  public static let uiLaunchScreen: [String: Any] = _document["UILaunchScreen"]
  public static let uiLaunchStoryboardName: String = _document["UILaunchStoryboardName"]
  public static let uiSupportedInterfaceOrientations: [String] = _document["UISupportedInterfaceOrientations"]
  public static let uiSupportedInterfaceOrientationsIpad: [String] = _document["UISupportedInterfaceOrientations~ipad"]
  public static let urlSchemeSalt: String = _document["URL scheme salt"]
  public static let useMock: String = _document["Use mock"]
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

private func arrayFromPlist<T>(at path: String) -> [T] {
  guard let url = BundleToken.bundle.url(forResource: path, withExtension: nil),
    let data = NSArray(contentsOf: url) as? [T] else {
    fatalError("Unable to load PLIST at path: \(path)")
  }
  return data
}

private struct PlistDocument {
  let data: [String: Any]

  init(path: String) {
    guard let url = BundleToken.bundle.url(forResource: path, withExtension: nil),
      let data = NSDictionary(contentsOf: url) as? [String: Any] else {
        fatalError("Unable to load PLIST at path: \(path)")
    }
    self.data = data
  }

  subscript<T>(key: String) -> T {
    guard let result = data[key] as? T else {
      fatalError("Property '\(key)' is not of type \(T.self)")
    }
    return result
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
