// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Colors {
  public static let accentColor = ColorAsset(name: "AccentColor")
  public static let accentBlue = ColorAsset(name: "accentBlue")
  public static let accentGreen = ColorAsset(name: "accentGreen")
  public static let accentOrange = ColorAsset(name: "accentOrange")
  public static let accentPressed = ColorAsset(name: "accentPressed")
  public static let accentRed = ColorAsset(name: "accentRed")
  public static let alert1 = ColorAsset(name: "alert_1")
  public static let alert2 = ColorAsset(name: "alert_2")
  public static let alert3 = ColorAsset(name: "alert_3")
  public static let bg1 = ColorAsset(name: "bg_1")
  public static let bg2 = ColorAsset(name: "bg_2")
  public static let bg3 = ColorAsset(name: "bg_3")
  public static let bg4 = ColorAsset(name: "bg_4")
  public static let defaultPrimary = ColorAsset(name: "default_primary")
  public static let buttonTitle = ColorAsset(name: "button_title")
  public static let buttonDisabled = ColorAsset(name: "button_disabled")
  public static let buttonFilledPress = ColorAsset(name: "button_filled_press")
  public static let buttonFilledPrimary1 = ColorAsset(name: "button_filled_primary_1")
  public static let buttonFilledPrimary2 = ColorAsset(name: "button_filled_primary_2")
  public static let buttonFilledPrimary3 = ColorAsset(name: "button_filled_primary_3")
  public static let buttonOutlinePress = ColorAsset(name: "button_outline_press")
  public static let buttonOutlinePrimary1 = ColorAsset(name: "button_outline_primary_1")
  public static let buttonOutlinePrimary2 = ColorAsset(name: "button_outline_primary_2")
  public static let buttonPayPress = ColorAsset(name: "button_pay_press")
  public static let buttonPayPrimary1 = ColorAsset(name: "button_pay_primary_1")
  public static let buttonPayPrimary2 = ColorAsset(name: "button_pay_primary_2")
  public static let buttonPayPrimary3 = ColorAsset(name: "button_pay_primary_3")
  public static let buttonSecondaryPress = ColorAsset(name: "button_secondary_press")
  public static let buttonSecondaryPrimary = ColorAsset(name: "button_secondary_primary")
  public static let control1 = ColorAsset(name: "control_1")
  public static let gray1 = ColorAsset(name: "gray_1")
  public static let gray2 = ColorAsset(name: "gray_2")
  public static let gray3 = ColorAsset(name: "gray_3")
  public static let gray4 = ColorAsset(name: "gray_4")
  public static let gray5 = ColorAsset(name: "gray_5")
  public static let gray6 = ColorAsset(name: "gray_6")
  public static let iconGray = ColorAsset(name: "icon_gray")
  public static let passcodeButtonColor = ColorAsset(name: "passcode_button_color")
  public static let passcodeButtonColorPressed = ColorAsset(name: "passcode_button_color_pressed")
  public static let shadowDefault = ColorAsset(name: "shadow_default")
  public static let success1 = ColorAsset(name: "success_1")
  public static let success2 = ColorAsset(name: "success_2")
  public static let success3 = ColorAsset(name: "success_3")
  public static let tabInactive = ColorAsset(name: "tab_inactive")
  public static let textDefault = ColorAsset(name: "text_default")
  public static let textGray = ColorAsset(name: "text_gray")
  public static let textWhite = ColorAsset(name: "text_white")
  public static let searchField = ColorAsset(name: "searchField")
  public static let warning1 = ColorAsset(name: "warning_1")
  public static let warning2 = ColorAsset(name: "warning_2")
  public static let warning3 = ColorAsset(name: "warning_3")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class ColorAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  public func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

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
