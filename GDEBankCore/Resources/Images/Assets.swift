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
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Assets {
  public static let addCircle = ImageAsset(name: "add-circle")
  public static let alertCircle = ImageAsset(name: "alert-circle")
  public static let alertTriangle = ImageAsset(name: "alert-triangle")
  public static let android = ImageAsset(name: "android")
  public static let appIconLarge = ImageAsset(name: "app_icon_large")
  public static let appIconSmall = ImageAsset(name: "app_icon_small")
  public static let apple = ImageAsset(name: "apple")
  public static let arrowArcLeft = ImageAsset(name: "arrow-arc-left")
  public static let arrowArcRight = ImageAsset(name: "arrow-arc-right")
  public static let arrowBendDoubleUpLeft = ImageAsset(name: "arrow-bend-double-up-left")
  public static let arrowBendDoubleUpRight = ImageAsset(name: "arrow-bend-double-up-right")
  public static let arrowBendDownLeft = ImageAsset(name: "arrow-bend-down-left")
  public static let arrowBendDownRight = ImageAsset(name: "arrow-bend-down-right")
  public static let arrowBendUpLeft = ImageAsset(name: "arrow-bend-up-left")
  public static let arrowBendUpRight = ImageAsset(name: "arrow-bend-up-right")
  public static let arrowClockwise = ImageAsset(name: "arrow-clockwise")
  public static let arrowFatLineRight = ImageAsset(name: "arrow-fat-line-right")
  public static let arrowLineUp = ImageAsset(name: "arrow-line-up")
  public static let at = ImageAsset(name: "at")
  public static let backspace = ImageAsset(name: "backspace")
  public static let bank = ImageAsset(name: "bank")
  public static let bitcoin = ImageAsset(name: "bitcoin")
  public static let calendarCheck = ImageAsset(name: "calendar-check")
  public static let calendarDots = ImageAsset(name: "calendar-dots")
  public static let calendarPlus = ImageAsset(name: "calendar-plus")
  public static let calendar = ImageAsset(name: "calendar")
  public static let cardCvv = ImageAsset(name: "card-cvv")
  public static let cardSend = ImageAsset(name: "card-send")
  public static let card = ImageAsset(name: "card")
  public static let cardholder = ImageAsset(name: "cardholder")
  public static let goldCardTemplate = ImageAsset(name: "gold-card-template")
  public static let platinumCardTemplate = ImageAsset(name: "platinum-card-template")
  public static let standardCardTemplate = ImageAsset(name: "standard-card-template")
  public static let worldEliteCardTemplate = ImageAsset(name: "world-elite-card-template")
  public static let chartBar = ImageAsset(name: "chart-bar")
  public static let chartLineUp = ImageAsset(name: "chart-line-up")
  public static let checkCircle = ImageAsset(name: "check-circle")
  public static let checkFat = ImageAsset(name: "check-fat")
  public static let checkRounded = ImageAsset(name: "check-rounded")
  public static let checkSquare = ImageAsset(name: "check-square")
  public static let check = ImageAsset(name: "check")
  public static let checks = ImageAsset(name: "checks")
  public static let chevronDown = ImageAsset(name: "chevron-down")
  public static let chevronLeft = ImageAsset(name: "chevron-left")
  public static let chevronRight = ImageAsset(name: "chevron-right")
  public static let chevronUp = ImageAsset(name: "chevron-up")
  public static let circle = ImageAsset(name: "circle")
  public static let clockwise = ImageAsset(name: "clockwise")
  public static let closeCircle = ImageAsset(name: "close-circle")
  public static let closeSmall = ImageAsset(name: "close-small")
  public static let close = ImageAsset(name: "close")
  public static let commission = ImageAsset(name: "commission")
  public static let copy = ImageAsset(name: "copy")
  public static let counterclockwise = ImageAsset(name: "counterclockwise")
  public static let ar = ImageAsset(name: "ar")
  public static let de = ImageAsset(name: "de")
  public static let en = ImageAsset(name: "en")
  public static let es = ImageAsset(name: "es")
  public static let fr = ImageAsset(name: "fr")
  public static let ja = ImageAsset(name: "ja")
  public static let ka = ImageAsset(name: "ka")
  public static let pt = ImageAsset(name: "pt")
  public static let ru = ImageAsset(name: "ru")
  public static let tr = ImageAsset(name: "tr")
  public static let uk = ImageAsset(name: "uk")
  public static let zh = ImageAsset(name: "zh")
  public static let aedCircle = ImageAsset(name: "aed-circle")
  public static let btcCircle = ImageAsset(name: "btc-circle")
  public static let ethCircle = ImageAsset(name: "eth-circle")
  public static let eurCircle = ImageAsset(name: "eur-circle")
  public static let gbpCircle = ImageAsset(name: "gbp-circle")
  public static let gelCircle = ImageAsset(name: "gel-circle")
  public static let tonCircle = ImageAsset(name: "ton-circle")
  public static let trxCircle = ImageAsset(name: "trx-circle")
  public static let tryCircle = ImageAsset(name: "try-circle")
  public static let usdCircle = ImageAsset(name: "usd-circle")
  public static let usdtCircle = ImageAsset(name: "usdt-circle")
  public static let delete = ImageAsset(name: "delete")
  public static let devices = ImageAsset(name: "devices")
  public static let doorOpen = ImageAsset(name: "door-open")
  public static let dotsGroup = ImageAsset(name: "dots-group")
  public static let download = ImageAsset(name: "download")
  public static let euro = ImageAsset(name: "euro")
  public static let exit = ImageAsset(name: "exit")
  public static let eyeClosed = ImageAsset(name: "eye-closed")
  public static let eye = ImageAsset(name: "eye")
  public static let face = ImageAsset(name: "face")
  public static let fileArrowDown = ImageAsset(name: "file-arrow-down")
  public static let fileText = ImageAsset(name: "file-text")
  public static let fingerprint = ImageAsset(name: "fingerprint")
  public static let global = ImageAsset(name: "global")
  public static let google = ImageAsset(name: "google")
  public static let history = ImageAsset(name: "history")
  public static let home = ImageAsset(name: "home")
  public static let hourglass = ImageAsset(name: "hourglass")
  public static let identificationCard = ImageAsset(name: "identification-card")
  public static let imageSquare = ImageAsset(name: "image-square")
  public static let image = ImageAsset(name: "image")
  public static let inboxIn = ImageAsset(name: "inbox-in")
  public static let info = ImageAsset(name: "info")
  public static let invoice = ImageAsset(name: "invoice")
  public static let key = ImageAsset(name: "key")
  public static let lightningSlash = ImageAsset(name: "lightning-slash")
  public static let lightning = ImageAsset(name: "lightning")
  public static let lockOpen = ImageAsset(name: "lock-open")
  public static let lock = ImageAsset(name: "lock")
  public static let mail = ImageAsset(name: "mail")
  public static let mastercard = ImageAsset(name: "mastercard")
  public static let moneyMinus = ImageAsset(name: "money-minus")
  public static let moneyPlus = ImageAsset(name: "money-plus")
  public static let money = ImageAsset(name: "money")
  public static let moon = ImageAsset(name: "moon")
  public static let password = ImageAsset(name: "password")
  public static let pinCode = ImageAsset(name: "pin-code")
  public static let plus = ImageAsset(name: "plus")
  public static let printer = ImageAsset(name: "printer")
  public static let qrCodeCorner = ImageAsset(name: "qr-code-corner")
  public static let question = ImageAsset(name: "question")
  public static let radioButton = ImageAsset(name: "radio button")
  public static let receipt = ImageAsset(name: "receipt")
  public static let scan = ImageAsset(name: "scan")
  public static let search = ImageAsset(name: "search")
  public static let sepa = ImageAsset(name: "sepa")
  public static let settings = ImageAsset(name: "settings")
  public static let signIn = ImageAsset(name: "sign-in")
  public static let smartphone = ImageAsset(name: "smartphone")
  public static let snow = ImageAsset(name: "snow")
  public static let splash = ImageAsset(name: "splash")
  public static let splashPhoto = ImageAsset(name: "splash_photo")
  public static let square = ImageAsset(name: "square")
  public static let star = ImageAsset(name: "star")
  public static let support = ImageAsset(name: "support")
  public static let swift = ImageAsset(name: "swift")
  public static let testPhoto = ImageAsset(name: "test_photo")
  public static let transferHorizontal = ImageAsset(name: "transfer-horizontal")
  public static let transfer = ImageAsset(name: "transfer")
  public static let upload = ImageAsset(name: "upload")
  public static let user = ImageAsset(name: "user")
  public static let visa = ImageAsset(name: "visa")
  public static let wallet = ImageAsset(name: "wallet")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public struct ImageAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  public var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  public func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

public extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
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
