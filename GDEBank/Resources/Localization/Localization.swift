
import Foundation
import GDEBankCore

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces

public enum L10n {

  /// Update bundle if you need to change app language
  public static var bundle: Bundle?
  public static var locale: Locale?

  public enum Intro {
    /// Connect
    public static var connect: String {
      L10n.tr("GDEBankPayLocalizable", "intro.connect", fallback: "Connect")
    }
  }

  public enum IntroQrCode {
    /// Scan the wallet QR code to transfer funds
    public static var subTitle: String {
      L10n.tr("GDEBankPayLocalizable", "intro-qr-code.sub-title", fallback: "Scan the wallet QR code to transfer funds")
    }
  }

  public enum Main {
    /// GDEBank
    public static var navigationTitle: String {
      L10n.tr("GDEBankPayLocalizable", "main.navigation-title", fallback: "GDEBank")
    }
    /// Receive
    public static var receiveButtonTitle: String {
      L10n.tr("GDEBankPayLocalizable", "main.receive-button-title", fallback: "Receive")
    }
    /// Total balance
    public static var totalBalance: String {
      L10n.tr("GDEBankPayLocalizable", "main.total-balance", fallback: "Total balance")
    }
    /// Transfer
    public static var transferButtonTitle: String {
      L10n.tr("GDEBankPayLocalizable", "main.transfer-button-title", fallback: "Transfer")
    }

    public enum TransferHistory {
      /// Transfer history
      public static var title: String {
        L10n.tr("GDEBankPayLocalizable", "main.transfer-history.title", fallback: "Transfer history")
      }
    }
  }

  public enum PayTransfer {
    /// Amount
    public static var amountLabel: String {
      L10n.tr("GDEBankPayLocalizable", "pay-transfer.amount-label", fallback: "Amount")
    }
    /// Currency
    public static var currencyLabel: String {
      L10n.tr("GDEBankPayLocalizable", "pay-transfer.currency-label", fallback: "Currency")
    }
    /// Insufficient funds on the account
    public static var insufficientFundsError: String {
      L10n.tr("GDEBankPayLocalizable", "pay-transfer.insufficient-funds-error", fallback: "Insufficient funds on the account")
    }
    /// Transfers
    public static var navigationTitle: String {
      L10n.tr("GDEBankPayLocalizable", "pay-transfer.navigation-title", fallback: "Transfers")
    }
    /// Recipient
    public static var recipientLabel: String {
      L10n.tr("GDEBankPayLocalizable", "pay-transfer.recipient-label", fallback: "Recipient")
    }
    /// Transfer
    public static var transferButtonTitle: String {
      L10n.tr("GDEBankPayLocalizable", "pay-transfer.transfer-button-title", fallback: "Transfer")
    }
  }

  public enum PayTransferIntro {
    /// Scan QR
    public static var scanButtonTitle: String {
      L10n.tr("GDEBankPayLocalizable", "pay-transfer-intro.scan-button-title", fallback: "Scan QR")
    }
    /// Scan the wallet QR code to transfer funds
    public static var subtitle: String {
      L10n.tr("GDEBankPayLocalizable", "pay-transfer-intro.subtitle", fallback: "Scan the wallet QR code to transfer funds")
    }
    /// Scan QR
    public static var title: String {
      L10n.tr("GDEBankPayLocalizable", "pay-transfer-intro.title", fallback: "Scan QR")
    }
  }

  public enum QrReceiving {
    /// Add to Wallet
    public static var addToWalletButton: String {
      L10n.tr("GDEBankPayLocalizable", "qr-receiving.add-to-wallet-button", fallback: "Add to Wallet")
    }
    /// Amount
    public static var amountPlaceholder: String {
      L10n.tr("GDEBankPayLocalizable", "qr-receiving.amount-placeholder", fallback: "Amount")
    }
    /// Currency
    public static var currencyLabel: String {
      L10n.tr("GDEBankPayLocalizable", "qr-receiving.currency-label", fallback: "Currency")
    }
    /// Generate QR-Code
    public static var generateQrButtonTitle: String {
      L10n.tr("GDEBankPayLocalizable", "qr-receiving.generate-qr-button-title", fallback: "Generate QR-Code")
    }
    /// Receive
    public static var navigationTitle: String {
      L10n.tr("GDEBankPayLocalizable", "qr-receiving.navigation-title", fallback: "Receive")
    }
    /// Share
    public static var shareButton: String {
      L10n.tr("GDEBankPayLocalizable", "qr-receiving.share-button", fallback: "Share")
    }

    public enum DynamicQrCode {
      /// Dynamic qr-code
      public static var tabName: String {
        L10n.tr("GDEBankPayLocalizable", "qr-receiving.dynamic-qr-code.tab-name", fallback: "Dynamic qr-code")
      }
      /// This QR code is valid only for this transfer
      public static var warning: String {
        L10n.tr("GDEBankPayLocalizable", "qr-receiving.dynamic-qr-code.warning", fallback: "This QR code is valid only for this transfer")
      }
    }

    public enum StaticQrCode {
      /// Receive transfers to your accounts using this qr-code
      public static var description: String {
        L10n.tr("GDEBankPayLocalizable", "qr-receiving.static-qr-code.description", fallback: "Receive transfers to your accounts using this qr-code")
      }
      /// Static qr-code
      public static var tabName: String {
        L10n.tr("GDEBankPayLocalizable", "qr-receiving.static-qr-code.tab-name", fallback: "Static qr-code")
      }
    }

    public enum TransferData {
      /// Transfer Details
      public static var title: String {
        L10n.tr("GDEBankPayLocalizable", "qr-receiving.transfer-data.title", fallback: "Transfer Details")
      }
    }
  }

  public enum Tabs {
    /// Exit
    public static var exit: String {
      L10n.tr("GDEBankPayLocalizable", "tabs.exit", fallback: "Exit")
    }
    /// Main
    public static var main: String {
      L10n.tr("GDEBankPayLocalizable", "tabs.main", fallback: "Main")
    }
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback: String = "") -> String {
    let format = (bundle ?? BundleToken.bundle).localizedString(forKey: key, value: fallback, table: table)
    return String(format: format, locale: locale ?? Locale.current, arguments: args)
  }
}

extension L10n: LocalizationStore {
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
