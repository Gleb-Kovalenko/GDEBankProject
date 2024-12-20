
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
  /// Apply
  public static var apply: String {
    L10n.tr("GDEBankCoreLocalizable", "apply", fallback: "Apply")
  }
  /// Balance
  public static var balance: String {
    L10n.tr("GDEBankCoreLocalizable", "balance", fallback: "Balance")
  }
  /// Done
  public static var done: String {
    L10n.tr("GDEBankCoreLocalizable", "done", fallback: "Done")
  }
  /// Download
  public static var download: String {
    L10n.tr("GDEBankCoreLocalizable", "download", fallback: "Download")
  }
  /// Plural format key: "%#@months@"
  public static func months(_ p1: Int) -> String {
    return L10n.tr("GDEBankCoreLocalizable", "months", p1, fallback: "Plural format key: \"%#@months@\"")
  }
  /// To skip entering the passcode every time
  public static var nsFaceIDUsageDescription: String {
    L10n.tr("GDEBankCoreLocalizable", "NSFaceIDUsageDescription", fallback: "To skip entering the passcode every time")
  }
  /// Plural format key: "%#@years@"
  public static func years(_ p1: Int) -> String {
    return L10n.tr("GDEBankCoreLocalizable", "years", p1, fallback: "Plural format key: \"%#@years@\"")
  }

  public enum Auth {

    public enum FirstTimeInApp {
      /// First time in GDEBank?
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "auth.first-time-in-app.title", fallback: "First time in GDEBank?")
      }
    }

    public enum Login {
      /// Log in to your account
      public static var navigationTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "auth.login.navigation-title", fallback: "Log in to your account")
      }
    }

    public enum Registration {
      /// Registration
      public static var navigationTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "auth.registration.navigation-title", fallback: "Registration")
      }
    }

    public enum SignUp {
      /// Sign up
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "auth.sign-up.title", fallback: "Sign up")
      }
    }
  }

  public enum Card {
    /// The card is blocked! To unlock, contact the support center
    public static var blockMessage: String {
      L10n.tr("GDEBankCoreLocalizable", "card.block-message", fallback: "The card is blocked! To unlock, contact the support center")
    }
  }

  public enum CashOperations {
    /// Country
    public static var country: String {
      L10n.tr("GDEBankCoreLocalizable", "cash-operations.country", fallback: "Country")
    }
    /// Branch/office
    public static var office: String {
      L10n.tr("GDEBankCoreLocalizable", "cash-operations.office", fallback: "Branch/office")
    }

    public enum Badge {
      /// Cash
      public static var cash: String {
        L10n.tr("GDEBankCoreLocalizable", "cash-operations.badge.cash", fallback: "Cash")
      }
      /// Manager Cheque
      public static var cheque: String {
        L10n.tr("GDEBankCoreLocalizable", "cash-operations.badge.cheque", fallback: "Manager Cheque")
      }
    }

    public enum Cheque {
      /// Continue
      public static var buttonTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "cash-operations.cheque.button-title", fallback: "Continue")
      }
      /// Contact the support center to receive the order
      public static var completeMessage: String {
        L10n.tr("GDEBankCoreLocalizable", "cash-operations.cheque.complete-message", fallback: "Contact the support center to receive the order")
      }
    }

    public enum Deposit {
      /// Issue
      public static var buttonTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "cash-operations.deposit.button-title", fallback: "Issue")
      }
      /// Your code for receiving cash
      public static var completeMessage: String {
        L10n.tr("GDEBankCoreLocalizable", "cash-operations.deposit.complete-message", fallback: "Your code for receiving cash")
      }
      /// For more information, contact the support center
      public static var completeMessageSubtitle: String {
        L10n.tr("GDEBankCoreLocalizable", "cash-operations.deposit.complete-message-subtitle", fallback: "For more information, contact the support center")
      }
    }

    public enum Transfer {
      /// Continue
      public static var buttonTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "cash-operations.transfer.button-title", fallback: "Continue")
      }
      /// Your code for receiving cash
      public static var completeMessage: String {
        L10n.tr("GDEBankCoreLocalizable", "cash-operations.transfer.complete-message", fallback: "Your code for receiving cash")
      }
      /// For more information, contact the support center
      public static var completeMessageSubtitle: String {
        L10n.tr("GDEBankCoreLocalizable", "cash-operations.transfer.complete-message-subtitle", fallback: "For more information, contact the support center")
      }
    }
  }

  public enum ChangePassword {
    /// Change password
    public static var changePasswordButtonText: String {
      L10n.tr("GDEBankCoreLocalizable", "change-password.change-password-button-text", fallback: "Change password")
    }
    /// Confirm new password
    public static var confirmPasswordTitle: String {
      L10n.tr("GDEBankCoreLocalizable", "change-password.confirm-password-title", fallback: "Confirm new password")
    }
    /// Change password
    public static var navigationTitle: String {
      L10n.tr("GDEBankCoreLocalizable", "change-password.navigation-title", fallback: "Change password")
    }
    /// New password
    public static var newPasswordTitle: String {
      L10n.tr("GDEBankCoreLocalizable", "change-password.new-password-title", fallback: "New password")
    }
    /// Old password
    public static var oldPasswordTitle: String {
      L10n.tr("GDEBankCoreLocalizable", "change-password.old-password-title", fallback: "Old password")
    }
  }

  public enum CodeConfirmation {

    public enum AnotherDevice {
      /// For security, enter the code that was sent to the mail
      public static var subtitle: String {
        L10n.tr("GDEBankCoreLocalizable", "code-confirmation.another-device.subtitle", fallback: "For security, enter the code that was sent to the mail")
      }
      /// We noticed the input from another device
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "code-confirmation.another-device.title", fallback: "We noticed the input from another device")
      }
    }

    public enum ChangeEmail {
      /// Change email
      public static var navigationTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "code-confirmation.change-email.navigation-title", fallback: "Change email")
      }

      public enum NewEmail {
        /// Enter the code
        public static var title: String {
          L10n.tr("GDEBankCoreLocalizable", "code-confirmation.change-email.new-email.title", fallback: "Enter the code")
        }
      }

      public enum OldEmail {
        /// To change the email address, enter the code that we sent to the address %@
        public static func subtitle(_ p1: String) -> String {
          return L10n.tr("GDEBankCoreLocalizable", "code-confirmation.change-email.old-email.subtitle", p1, fallback: "Plural format key: \"%#@code-confirmation.change-email.old-email.subtitle@\"")
        }
      }
    }

    public enum ChangePhone {
      /// Change phone Number
      public static var navigationTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "code-confirmation.change-phone.navigation-title", fallback: "Change phone Number")
      }
      /// Change phone number
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "code-confirmation.change-phone.title", fallback: "Change phone number")
      }

      public enum NewNumber {
        /// Enter the code
        public static var title: String {
          L10n.tr("GDEBankCoreLocalizable", "code-confirmation.change-phone.new-number.title", fallback: "Enter the code")
        }
      }

      public enum OldNumber {
        /// To change the phone number, enter the code that we sent to the number %@
        public static func subtitle(_ p1: String) -> String {
          return L10n.tr("GDEBankCoreLocalizable", "code-confirmation.change-phone.old-number.subtitle", p1, fallback: "Plural format key: \"%#@code-confirmation.change-phone.old-number.subtitle@\"")
        }
      }
    }

    public enum CheckCode {
      /// Code entered incorrectly
      public static var errorTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "code-confirmation.check-code.error-title", fallback: "Code entered incorrectly")
      }
    }

    public enum EmailRegistration {
      /// We have sent an email to your Email address. Click on the link in the email to confirm the Email.
      public static var subtitle: String {
        L10n.tr("GDEBankCoreLocalizable", "code-confirmation.email-registration.subtitle", fallback: "We have sent an email to your Email address. Click on the link in the email to confirm the Email.")
      }
      /// Confirm your Email
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "code-confirmation.email-registration.title", fallback: "Confirm your Email")
      }
    }

    public enum NoReceiveCodeButton {
      /// I didn't get the code
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "code-confirmation.no-receive-code-button.title", fallback: "I didn't get the code")
      }
    }

    public enum PhoneRegistration {
      /// Enter the code from the SMS
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "code-confirmation.phone-registration.title", fallback: "Enter the code from the SMS")
      }
    }

    public enum ResendButton {
      /// Get the code again through
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "code-confirmation.resend-button.title", fallback: "Get the code again through")
      }
    }

    public enum ResendCode {
      /// Get code again
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "code-confirmation.resend-code.title", fallback: "Get code again")
      }
    }

    public enum RestorePassword {

      public enum Email {
        /// To log in, enter the code sent to your email
        public static var subtitle: String {
          L10n.tr("GDEBankCoreLocalizable", "code-confirmation.restore-password.email.subtitle", fallback: "To log in, enter the code sent to your email")
        }
        /// We have sent you an email
        public static var title: String {
          L10n.tr("GDEBankCoreLocalizable", "code-confirmation.restore-password.email.title", fallback: "We have sent you an email")
        }
      }

      public enum Phone {
        /// To log in, enter the code sent to your phone
        public static var subtitle: String {
          L10n.tr("GDEBankCoreLocalizable", "code-confirmation.restore-password.phone.subtitle", fallback: "To log in, enter the code sent to your phone")
        }
        /// We have sent you an SMS
        public static var title: String {
          L10n.tr("GDEBankCoreLocalizable", "code-confirmation.restore-password.phone.title", fallback: "We have sent you an SMS")
        }
      }
    }

    public enum SendCode {
      /// Failed to send code
      public static var errorTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "code-confirmation.send-code.error-title", fallback: "Failed to send code")
      }
    }

    public enum SupportButton {
      /// Support Center
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "code-confirmation.support-button.title", fallback: "Support Center")
      }
    }
  }

  public enum Currency {

    public enum Aed {
      /// Dirhams AED
      public static var accountTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.aed.account-title", fallback: "Dirhams AED")
      }
      /// Dirham
      public static var localizedName: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.aed.localizedName", fallback: "Dirham")
      }
      /// Dirhams
      public static var walletDescription: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.aed.wallet-description", fallback: "Dirhams")
      }
    }

    public enum Btc {
      /// Bitcoin
      public static var accountTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.btc.account-title", fallback: "Bitcoin")
      }
      /// Bitcoin
      public static var localizedName: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.btc.localizedName", fallback: "Bitcoin")
      }
      /// Bitcoin
      public static var walletDescription: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.btc.wallet-description", fallback: "Bitcoin")
      }
    }

    public enum Eth {
      /// Ethereum
      public static var accountTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.eth.account-title", fallback: "Ethereum")
      }
      /// TRX
      public static var localizedName: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.eth.localizedName", fallback: "TRX")
      }
      /// Ethereum
      public static var walletDescription: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.eth.wallet-description", fallback: "Ethereum")
      }
    }

    public enum Eur {
      /// Euro EUR
      public static var accountTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.eur.account-title", fallback: "Euro EUR")
      }
      /// Euro
      public static var localizedName: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.eur.localizedName", fallback: "Euro")
      }
      /// Euro
      public static var walletDescription: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.eur.wallet-description", fallback: "Euro")
      }
    }

    public enum Gbp {
      /// Pound GBR
      public static var accountTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.gbp.account-title", fallback: "Pound GBR")
      }
      /// Pound
      public static var localizedName: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.gbp.localizedName", fallback: "Pound")
      }
      /// Pound
      public static var walletDescription: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.gbp.wallet-description", fallback: "Pound")
      }
    }

    public enum Gel {
      /// Lari GEL
      public static var accountTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.gel.account-title", fallback: "Lari GEL")
      }
      /// Lari
      public static var localizedName: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.gel.localizedName", fallback: "Lari")
      }
      /// Lari
      public static var walletDescription: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.gel.wallet-description", fallback: "Lari")
      }
    }

    public enum Group {

      public enum Crypto {
        /// Crypto accounts
        public static var title: String {
          L10n.tr("GDEBankCoreLocalizable", "currency.group.crypto.title", fallback: "Crypto accounts")
        }
      }

      public enum Fiat {
        /// Fiat accounts
        public static var title: String {
          L10n.tr("GDEBankCoreLocalizable", "currency.group.fiat.title", fallback: "Fiat accounts")
        }
      }
    }

    public enum Ton {
      /// Ton
      public static var accountTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.ton.account-title", fallback: "Ton")
      }
      /// Toncoin
      public static var localizedName: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.ton.localizedName", fallback: "Toncoin")
      }
      /// TON
      public static var walletDescription: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.ton.wallet-description", fallback: "TON")
      }
    }

    public enum Trx {
      /// TRX
      public static var accountTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.trx.account-title", fallback: "TRX")
      }
      /// TRON
      public static var localizedName: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.trx.localizedName", fallback: "TRON")
      }
      /// TRON
      public static var walletDescription: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.trx.wallet-description", fallback: "TRON")
      }
    }

    public enum Try {
      /// Lira TRY
      public static var accountTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.try.account-title", fallback: "Lira TRY")
      }
      /// Lira
      public static var localizedName: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.try.localizedName", fallback: "Lira")
      }
      /// Lira
      public static var walletDescription: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.try.wallet-description", fallback: "Lira")
      }
    }

    public enum Usd {
      /// Dollar USD
      public static var accountTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.usd.account-title", fallback: "Dollar USD")
      }
      /// Dollar
      public static var localizedName: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.usd.localizedName", fallback: "Dollar")
      }
      /// Dollar
      public static var walletDescription: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.usd.wallet-description", fallback: "Dollar")
      }
    }

    public enum Usdt {
      /// Tether USDT
      public static var accountTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.usdt.account-title", fallback: "Tether USDT")
      }
      /// Tether
      public static var localizedName: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.usdt.localizedName", fallback: "Tether")
      }
      /// Tether
      public static var walletDescription: String {
        L10n.tr("GDEBankCoreLocalizable", "currency.usdt.wallet-description", fallback: "Tether")
      }
    }
  }

  public enum DeviceDetail {
    /// Remove device
    public static var deleteButtonTitle: String {
      L10n.tr("GDEBankCoreLocalizable", "device-detail.delete-button-title", fallback: "Remove device")
    }
    /// Connect the device and log in without SMS confirmation
    public static var info: String {
      L10n.tr("GDEBankCoreLocalizable", "device-detail.info", fallback: "Connect the device and log in without SMS confirmation")
    }
    /// Details
    public static var title: String {
      L10n.tr("GDEBankCoreLocalizable", "device-detail.title", fallback: "Details")
    }

    public enum Characteristic {
      /// Connected
      public static var connectionDate: String {
        L10n.tr("GDEBankCoreLocalizable", "device-detail.characteristic.connection-date", fallback: "Connected")
      }
      /// Name
      public static var deviceName: String {
        L10n.tr("GDEBankCoreLocalizable", "device-detail.characteristic.device-name", fallback: "Name")
      }
      /// Operating system
      public static var deviceOS: String {
        L10n.tr("GDEBankCoreLocalizable", "device-detail.characteristic.device-OS", fallback: "Operating system")
      }
    }
  }

  public enum DeviceList {
    /// Connected devices
    public static var listTitle: String {
      L10n.tr("GDEBankCoreLocalizable", "device-list.list-title", fallback: "Connected devices")
    }
    /// Devices
    public static var navigationTitle: String {
      L10n.tr("GDEBankCoreLocalizable", "device-list.navigation-title", fallback: "Devices")
    }
    /// Mark these devices as connected so you can sign in to the app without SMS or verification code
    public static var subtitle: String {
      L10n.tr("GDEBankCoreLocalizable", "device-list.subtitle", fallback: "Mark these devices as connected so you can sign in to the app without SMS or verification code")
    }
    /// Your devices
    public static var title: String {
      L10n.tr("GDEBankCoreLocalizable", "device-list.title", fallback: "Your devices")
    }

    public enum Item {
      /// Connection date
      public static var subtitle: String {
        L10n.tr("GDEBankCoreLocalizable", "device-list.item.subtitle", fallback: "Connection date")
      }
    }
  }

  public enum DxDialog {

    public enum ButtonTitle {
      /// Allow
      public static var allow: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.button-title.allow", fallback: "Allow")
      }
      /// Back
      public static var back: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.button-title.back", fallback: "Back")
      }
      /// Block
      public static var block: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.button-title.block", fallback: "Block")
      }
      /// Cancel
      public static var cancel: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.button-title.cancel", fallback: "Cancel")
      }
      /// Confirm
      public static var confirm: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.button-title.confirm", fallback: "Confirm")
      }
      /// Continue
      public static var `continue`: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.button-title.continue", fallback: "Continue")
      }
      /// Decline
      public static var decline: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.button-title.decline", fallback: "Decline")
      }
      /// Delete
      public static var delete: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.button-title.delete", fallback: "Delete")
      }
      /// Exit
      public static var exit: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.button-title.exit", fallback: "Exit")
      }
      /// Get receipt
      public static var getReceipt: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.button-title.get-receipt", fallback: "Get receipt")
      }
      /// To main
      public static var toMain: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.button-title.to-main", fallback: "To main")
      }
    }

    public enum Title {
      /// Access denied
      public static var accessDenied: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.title.access-denied", fallback: "Access denied")
      }
      /// Are you sure you want to block the card?
      public static var blockCardConfirmation: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.title.block-card-confirmation", fallback: "Are you sure you want to block the card?")
      }
      /// Card deleted
      public static var cardDeleted: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.title.card-deleted", fallback: "Card deleted")
      }
      /// Code changed
      public static var codeChanged: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.title.code-changed", fallback: "Code changed")
      }
      /// Code saved
      public static var codeSaved: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.title.code-saved", fallback: "Code saved")
      }
      /// Are you sure you want to delete your account?
      public static var deleteAccountConfirmation: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.title.delete-account-confirmation", fallback: "Are you sure you want to delete your account?")
      }
      /// Are you sure you want to delete the card?
      public static var deleteCardConfirmation: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.title.delete-card-confirmation", fallback: "Are you sure you want to delete the card?")
      }
      /// Your email address has been changed
      public static var emailChanged: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.title.email-changed", fallback: "Your email address has been changed")
      }
      /// Insufficient funds for currency exchange
      public static var insufficientFunds: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.title.insufficient-funds", fallback: "Insufficient funds for currency exchange")
      }
      /// Confirm login
      public static var loginConfirmation: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.title.login-confirmation", fallback: "Confirm login")
      }
      /// Are you sure you want to logout?
      public static var logoutConfirmation: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.title.logout-confirmation", fallback: "Are you sure you want to logout?")
      }
      /// Password successfully changed
      public static var passwordChanged: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.title.password-changed", fallback: "Password successfully changed")
      }
      /// Your phone number has been changed
      public static var phoneNumberChanged: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.title.phone-number-changed", fallback: "Your phone number has been changed")
      }
      /// Allow photo access
      public static var photoAccess: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.title.photo-access", fallback: "Allow photo access")
      }
      /// PIN successfully changed
      public static var pinChanged: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.title.pin-changed", fallback: "PIN successfully changed")
      }
      /// Successful exchange
      public static var successfulExchange: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.title.successful-exchange", fallback: "Successful exchange")
      }
      /// Successful recharge
      public static var successfulRecharge: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.title.successful-recharge", fallback: "Successful recharge")
      }
      /// Successful transfer
      public static var successfulTransfer: String {
        L10n.tr("GDEBankCoreLocalizable", "dx-dialog.title.successful-transfer", fallback: "Successful transfer")
      }
    }
  }

  public enum EmailEntering {

    public enum EmailChanging {
      /// Next
      public static var next: String {
        L10n.tr("GDEBankCoreLocalizable", "email-entering.email-changing.next", fallback: "Next")
      }
      /// We will send a confirmation code to this address
      public static var subtitle: String {
        L10n.tr("GDEBankCoreLocalizable", "email-entering.email-changing.subtitle", fallback: "We will send a confirmation code to this address")
      }
      /// Enter a new email address
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "email-entering.email-changing.title", fallback: "Enter a new email address")
      }
    }

    public enum Login {
      /// Email
      public static var emailName: String {
        L10n.tr("GDEBankCoreLocalizable", "email-entering.login.email-name", fallback: "Email")
      }
      /// Forgot password?
      public static var forgotPassword: String {
        L10n.tr("GDEBankCoreLocalizable", "email-entering.login.forgot-password", fallback: "Forgot password?")
      }
      /// Password
      public static var passwordName: String {
        L10n.tr("GDEBankCoreLocalizable", "email-entering.login.password-name", fallback: "Password")
      }
      /// Sign in
      public static var signIn: String {
        L10n.tr("GDEBankCoreLocalizable", "email-entering.login.sign-in", fallback: "Sign in")
      }
    }

    public enum PasswordRestore {
      /// Email
      public static var emailName: String {
        L10n.tr("GDEBankCoreLocalizable", "email-entering.password-restore.email-name", fallback: "Email")
      }
      /// I don't have access to mail
      public static var noAccess: String {
        L10n.tr("GDEBankCoreLocalizable", "email-entering.password-restore.no-access", fallback: "I don't have access to mail")
      }
      /// Password
      public static var passwordName: String {
        L10n.tr("GDEBankCoreLocalizable", "email-entering.password-restore.password-name", fallback: "Password")
      }
      /// Go back to the login screen
      public static var returnToLogin: String {
        L10n.tr("GDEBankCoreLocalizable", "email-entering.password-restore.return-to-login", fallback: "Go back to the login screen")
      }
      /// Send
      public static var send: String {
        L10n.tr("GDEBankCoreLocalizable", "email-entering.password-restore.send", fallback: "Send")
      }
      /// Enter your email address and we will send you instructions for password recovery
      public static var subtitle: String {
        L10n.tr("GDEBankCoreLocalizable", "email-entering.password-restore.subtitle", fallback: "Enter your email address and we will send you instructions for password recovery")
      }
      /// Support center
      public static var supportCenter: String {
        L10n.tr("GDEBankCoreLocalizable", "email-entering.password-restore.support-center", fallback: "Support center")
      }
      /// Forgot your password?
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "email-entering.password-restore.title", fallback: "Forgot your password?")
      }
    }

    public enum Registration {
      /// Already registered?
      public static var alreadyRegistered: String {
        L10n.tr("GDEBankCoreLocalizable", "email-entering.registration.already-registered", fallback: "Already registered?")
      }
      /// Enter Email
      public static var enterEmail: String {
        L10n.tr("GDEBankCoreLocalizable", "email-entering.registration.enter-email", fallback: "Enter Email")
      }
      /// Next
      public static var next: String {
        L10n.tr("GDEBankCoreLocalizable", "email-entering.registration.next", fallback: "Next")
      }
      /// Sign in
      public static var signIn: String {
        L10n.tr("GDEBankCoreLocalizable", "email-entering.registration.sign-in", fallback: "Sign in")
      }
      /// Support center
      public static var supportCenter: String {
        L10n.tr("GDEBankCoreLocalizable", "email-entering.registration.support-center", fallback: "Support center")
      }
    }
  }

  public enum Errors {
    /// Something went wrong
    public static var general: String {
      L10n.tr("GDEBankCoreLocalizable", "errors.general", fallback: "Something went wrong")
    }
    /// Couldn't get a qr code link
    public static var noQrCodeLink: String {
      L10n.tr("GDEBankCoreLocalizable", "errors.no-qr-code-link", fallback: "Couldn't get a qr code link")
    }
    /// Can't get data
    public static var parseError: String {
      L10n.tr("GDEBankCoreLocalizable", "errors.parse-error", fallback: "Can't get data")
    }

    public enum AccountStatement {
      /// Couldn't get a link to the report
      public static var noStatement: String {
        L10n.tr("GDEBankCoreLocalizable", "errors.account-statement.no-statement", fallback: "Couldn't get a link to the report")
      }
    }

    public enum Email {
      /// Incorrect Email
      public static var incorrectEmail: String {
        L10n.tr("GDEBankCoreLocalizable", "errors.email.incorrect-email", fallback: "Incorrect Email")
      }
      /// Incorrect Email or password
      public static var incorrectEmailOrPassword: String {
        L10n.tr("GDEBankCoreLocalizable", "errors.email.incorrect-email-or-password", fallback: "Incorrect Email or password")
      }
    }

    public enum Phone {
      /// The number was entered incorrectly
      public static var incorrectPhone: String {
        L10n.tr("GDEBankCoreLocalizable", "errors.phone.incorrect-phone", fallback: "The number was entered incorrectly")
      }
      /// Incorrect phone number or password
      public static var incorrectPhoneOrPassword: String {
        L10n.tr("GDEBankCoreLocalizable", "errors.phone.incorrect-phone-or-password", fallback: "Incorrect phone number or password")
      }
    }
  }

  public enum ExternalAuth {

    public enum Apple {
      /// Continue with Apple
      public static var buttonTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "external-auth.apple.button-title", fallback: "Continue with Apple")
      }
    }

    public enum Google {
      /// Continue with Google
      public static var buttonTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "external-auth.google.button-title", fallback: "Continue with Google")
      }
    }
  }

  public enum ExternalSignIn {
    /// Apple / Google sign in
    public static var navigationTitle: String {
      L10n.tr("GDEBankCoreLocalizable", "external-sign-in.navigation-title", fallback: "Apple / Google sign in")
    }
  }

  public enum General {
    /// Cancel
    public static var cancel: String {
      L10n.tr("GDEBankCoreLocalizable", "general.cancel", fallback: "Cancel")
    }
    /// Can't dowload file
    public static var cannotObtainFile: String {
      L10n.tr("GDEBankCoreLocalizable", "general.cannot-obtain-file", fallback: "Can't dowload file")
    }
    /// Confirm
    public static var confirm: String {
      L10n.tr("GDEBankCoreLocalizable", "general.confirm", fallback: "Confirm")
    }
    /// Error
    public static var error: String {
      L10n.tr("GDEBankCoreLocalizable", "general.error", fallback: "Error")
    }
    /// Or
    public static var or: String {
      L10n.tr("GDEBankCoreLocalizable", "general.or", fallback: "Or")
    }
    /// We cannot create a translation without a memo. If you are sure that you do not need to specify it for translation, then you can enter any text in the memo field
    public static var requiredMemoMessage: String {
      L10n.tr("GDEBankCoreLocalizable", "general.required-memo-message", fallback: "We cannot create a translation without a memo. If you are sure that you do not need to specify it for translation, then you can enter any text in the memo field")
    }
    /// Settings
    public static var settings: String {
      L10n.tr("GDEBankCoreLocalizable", "general.settings", fallback: "Settings")
    }
  }

  public enum HistoryType {

    public enum All {
      /// All history
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "history-type.all.title", fallback: "All history")
      }
    }

    public enum Conversion {
      /// Conversion
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "history-type.conversion.title", fallback: "Conversion")
      }
    }

    public enum Deposit {
      /// Deposits
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "history-type.deposit.title", fallback: "Deposits")
      }
    }

    public enum Transfer {
      /// Transfers
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "history-type.transfer.title", fallback: "Transfers")
      }
    }
  }

  public enum LogIn {
    /// Email
    public static var email: String {
      L10n.tr("GDEBankCoreLocalizable", "log-in.email", fallback: "Email")
    }
    /// Phone
    public static var phone: String {
      L10n.tr("GDEBankCoreLocalizable", "log-in.phone", fallback: "Phone")
    }
    /// Sign in
    public static var signInButtonTitle: String {
      L10n.tr("GDEBankCoreLocalizable", "log-in.sign-in-button-title", fallback: "Sign in")
    }
  }

  public enum NetworkSelection {
    /// Arrival time %@ min
    public static func arriveTime(_ p1: String) -> String {
      return L10n.tr("GDEBankCoreLocalizable", "network-selection.arrive-time", p1, fallback: "Plural format key: \"%#@network-selection.arrive-time@\"")
    }
    /// Block confirmations
    public static var blockApproves: String {
      L10n.tr("GDEBankCoreLocalizable", "network-selection.block-approves", fallback: "Block confirmations")
    }
    /// Minimum input amount %@
    public static func inputMinSum(_ p1: String) -> String {
      return L10n.tr("GDEBankCoreLocalizable", "network-selection.input-min-sum", p1, fallback: "Plural format key: \"%#@network-selection.input-min-sum@\"")
    }
    /// Select network
    public static var title: String {
      L10n.tr("GDEBankCoreLocalizable", "network-selection.title", fallback: "Select network")
    }
  }

  public enum PasscodeFlow {

    public enum Changing {
      /// Change passcode
      public static var navigationTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "passcode-flow.changing.navigation-title", fallback: "Change passcode")
      }
    }

    public enum Verification {
      /// Passcode for entry
      public static var navigationTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "passcode-flow.verification.navigation-title", fallback: "Passcode for entry")
      }
    }
  }

  public enum PasscodeLock {
    /// To skip entering the passcode every time
    public static var biometricEvaluationReason: String {
      L10n.tr("GDEBankCoreLocalizable", "passcode-lock.biometric-evaluation-reason", fallback: "To skip entering the passcode every time")
    }
    /// Create a passcode
    public static var comeUpPasscode: String {
      L10n.tr("GDEBankCoreLocalizable", "passcode-lock.come-up-passcode", fallback: "Create a passcode")
    }
    /// Enter old passcode
    public static var enterOldPasscode: String {
      L10n.tr("GDEBankCoreLocalizable", "passcode-lock.enter-old-passcode", fallback: "Enter old passcode")
    }
    /// Enter passcode
    public static var enterPasscode: String {
      L10n.tr("GDEBankCoreLocalizable", "passcode-lock.enter-passcode", fallback: "Enter passcode")
    }
    /// Would you like to enable Touch ID or Face ID for entry?
    public static var faceAndTouchIdTitle: String {
      L10n.tr("GDEBankCoreLocalizable", "passcode-lock.face-and-touch-id-title", fallback: "Would you like to enable Touch ID or Face ID for entry?")
    }
    /// Later
    public static var laterButtonTitle: String {
      L10n.tr("GDEBankCoreLocalizable", "passcode-lock.later-button-title", fallback: "Later")
    }
    /// Repeat new passcode
    public static var repeatNewPasscode: String {
      L10n.tr("GDEBankCoreLocalizable", "passcode-lock.repeat-new-passcode", fallback: "Repeat new passcode")
    }
    /// Repeat passcode
    public static var repeatPasscode: String {
      L10n.tr("GDEBankCoreLocalizable", "passcode-lock.repeat-passcode", fallback: "Repeat passcode")
    }
    /// Set passcode
    public static var setupPasscode: String {
      L10n.tr("GDEBankCoreLocalizable", "passcode-lock.setup-passcode", fallback: "Set passcode")
    }
  }

  public enum PasswordEntering {
    /// Passwords don't match
    public static var passwordsNotEqual: String {
      L10n.tr("GDEBankCoreLocalizable", "password-entering.passwords-not-equal", fallback: "Passwords don't match")
    }
    /// The password doesn't match the requirements
    public static var passwordsNotMatchRequirements: String {
      L10n.tr("GDEBankCoreLocalizable", "password-entering.passwords-not-match-requirements", fallback: "The password doesn't match the requirements")
    }

    public enum CreatePassword {
      /// Register
      public static var actionButtonTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "password-entering.create-password.action-button-title", fallback: "Register")
      }
      /// Repeat
      public static var `repeat`: String {
        L10n.tr("GDEBankCoreLocalizable", "password-entering.create-password.repeat", fallback: "Repeat")
      }
      /// The password must contain at least 6 letters, including a capital letter, a symbol and a number
      public static var requirementDescription: String {
        L10n.tr("GDEBankCoreLocalizable", "password-entering.create-password.requirement-description", fallback: "The password must contain at least 6 letters, including a capital letter, a symbol and a number")
      }
      /// Support Center
      public static var supportCenter: String {
        L10n.tr("GDEBankCoreLocalizable", "password-entering.create-password.support-center", fallback: "Support Center")
      }
      /// Enter your password
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "password-entering.create-password.title", fallback: "Enter your password")
      }
    }

    public enum RestorePassword {
      /// Sign in
      public static var actionButtonTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "password-entering.restore-password.action-button-title", fallback: "Sign in")
      }
      /// Repeat
      public static var `repeat`: String {
        L10n.tr("GDEBankCoreLocalizable", "password-entering.restore-password.repeat", fallback: "Repeat")
      }
      /// The password must contain at least 6 letters, including a capital letter, a symbol and a number
      public static var requirementDescription: String {
        L10n.tr("GDEBankCoreLocalizable", "password-entering.restore-password.requirement-description", fallback: "The password must contain at least 6 letters, including a capital letter, a symbol and a number")
      }
      /// Support Center
      public static var supportCenter: String {
        L10n.tr("GDEBankCoreLocalizable", "password-entering.restore-password.support-center", fallback: "Support Center")
      }
      /// Enter new password
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "password-entering.restore-password.title", fallback: "Enter new password")
      }
    }
  }

  public enum Payment {

    public enum Deposit {

      public enum Card {
        /// Replenishment with a card
        public static var title: String {
          L10n.tr("GDEBankCoreLocalizable", "payment.deposit.card.title", fallback: "Replenishment with a card")
        }
      }

      public enum Cash {
        /// Cash replenishment
        public static var title: String {
          L10n.tr("GDEBankCoreLocalizable", "payment.deposit.cash.title", fallback: "Cash replenishment")
        }
      }

      public enum Crypto {
        /// Replenishment at the wallet address
        public static var title: String {
          L10n.tr("GDEBankCoreLocalizable", "payment.deposit.crypto.title", fallback: "Replenishment at the wallet address")
        }
      }

      public enum Iban {
        /// Issue an invoice
        public static var title: String {
          L10n.tr("GDEBankCoreLocalizable", "payment.deposit.iban.title", fallback: "Issue an invoice")
        }
      }
    }

    public enum Transfer {

      public enum Card {
        /// Transfer to card
        public static var title: String {
          L10n.tr("GDEBankCoreLocalizable", "payment.transfer.card.title", fallback: "Transfer to card")
        }
      }

      public enum Cash {
        /// Cash withdrawal
        public static var title: String {
          L10n.tr("GDEBankCoreLocalizable", "payment.transfer.cash.title", fallback: "Cash withdrawal")
        }
      }

      public enum Crypto {
        /// Transfer crypto
        public static var title: String {
          L10n.tr("GDEBankCoreLocalizable", "payment.transfer.crypto.title", fallback: "Transfer crypto")
        }
      }

      public enum Iban {
        /// Transfer by IBAN
        public static var title: String {
          L10n.tr("GDEBankCoreLocalizable", "payment.transfer.iban.title", fallback: "Transfer by IBAN")
        }
      }
    }
  }

  public enum PhoneEntering {

    public enum ExternalSignIn {
      /// Next
      public static var send: String {
        L10n.tr("GDEBankCoreLocalizable", "phone-entering.external-sign-in.send", fallback: "Next")
      }
      /// We will send an SMS with a confirmation code to this number
      public static var subtitle: String {
        L10n.tr("GDEBankCoreLocalizable", "phone-entering.external-sign-in.subtitle", fallback: "We will send an SMS with a confirmation code to this number")
      }
      /// Enter your phone number
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "phone-entering.external-sign-in.title", fallback: "Enter your phone number")
      }
    }

    public enum Login {
      /// Phone
      public static var emailName: String {
        L10n.tr("GDEBankCoreLocalizable", "phone-entering.login.email-name", fallback: "Phone")
      }
      /// Forgot password?
      public static var forgotPassword: String {
        L10n.tr("GDEBankCoreLocalizable", "phone-entering.login.forgot-password", fallback: "Forgot password?")
      }
      /// Password
      public static var passwordName: String {
        L10n.tr("GDEBankCoreLocalizable", "phone-entering.login.password-name", fallback: "Password")
      }
      /// Sign in
      public static var signIn: String {
        L10n.tr("GDEBankCoreLocalizable", "phone-entering.login.sign-in", fallback: "Sign in")
      }
    }

    public enum PasswordRestore {
      /// I don't have access to my phone
      public static var noAccess: String {
        L10n.tr("GDEBankCoreLocalizable", "phone-entering.password-restore.no-access", fallback: "I don't have access to my phone")
      }
      /// Phone number
      public static var phoneName: String {
        L10n.tr("GDEBankCoreLocalizable", "phone-entering.password-restore.phone-name", fallback: "Phone number")
      }
      /// Go back to the login screen
      public static var returnToLogin: String {
        L10n.tr("GDEBankCoreLocalizable", "phone-entering.password-restore.return-to-login", fallback: "Go back to the login screen")
      }
      /// Send
      public static var send: String {
        L10n.tr("GDEBankCoreLocalizable", "phone-entering.password-restore.send", fallback: "Send")
      }
      /// Enter your phone number and we will send you an SMS with instructions for password recovery
      public static var subtitle: String {
        L10n.tr("GDEBankCoreLocalizable", "phone-entering.password-restore.subtitle", fallback: "Enter your phone number and we will send you an SMS with instructions for password recovery")
      }
      /// Support Center
      public static var supportButtonTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "phone-entering.password-restore.support-button-title", fallback: "Support Center")
      }
      /// Forgot your password?
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "phone-entering.password-restore.title", fallback: "Forgot your password?")
      }
    }

    public enum PhoneChanging {
      /// Next
      public static var next: String {
        L10n.tr("GDEBankCoreLocalizable", "phone-entering.phone-changing.next", fallback: "Next")
      }
      /// We will send an SMS with a confirmation code to this number
      public static var subtitle: String {
        L10n.tr("GDEBankCoreLocalizable", "phone-entering.phone-changing.subtitle", fallback: "We will send an SMS with a confirmation code to this number")
      }
      /// Enter a new phone number
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "phone-entering.phone-changing.title", fallback: "Enter a new phone number")
      }
    }

    public enum Registration {
      /// Already registered?
      public static var alreadyRegistered: String {
        L10n.tr("GDEBankCoreLocalizable", "phone-entering.registration.already-registered", fallback: "Already registered?")
      }
      /// We will send a confirmation code to this number
      public static var description: String {
        L10n.tr("GDEBankCoreLocalizable", "phone-entering.registration.description", fallback: "We will send a confirmation code to this number")
      }
      /// Send code
      public static var next: String {
        L10n.tr("GDEBankCoreLocalizable", "phone-entering.registration.next", fallback: "Send code")
      }
      /// Sign in
      public static var signIn: String {
        L10n.tr("GDEBankCoreLocalizable", "phone-entering.registration.sign-in", fallback: "Sign in")
      }
      /// Support Center
      public static var supportCenter: String {
        L10n.tr("GDEBankCoreLocalizable", "phone-entering.registration.support-center", fallback: "Support Center")
      }
      /// Enter your phone number
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "phone-entering.registration.title", fallback: "Enter your phone number")
      }
    }
  }

  public enum QrCode {
    /// Place the QR code in the frame for scanning
    public static var instruction: String {
      L10n.tr("GDEBankCoreLocalizable", "qr-code.instruction", fallback: "Place the QR code in the frame for scanning")
    }
    /// Scan QR-code
    public static var title: String {
      L10n.tr("GDEBankCoreLocalizable", "qr-code.title", fallback: "Scan QR-code")
    }
  }

  public enum QrScanning {

    public enum Error {
      /// Failed to add metadata output
      public static var addMetadataOutput: String {
        L10n.tr("GDEBankCoreLocalizable", "qr-scanning.error.add-metadata-output", fallback: "Failed to add metadata output")
      }
      /// Failed to add video input
      public static var addVideoInput: String {
        L10n.tr("GDEBankCoreLocalizable", "qr-scanning.error.add-video-input", fallback: "Failed to add video input")
      }
      /// Please grant access to the camera in the device settings.
      public static var cameraAccessDeniedMessage: String {
        L10n.tr("GDEBankCoreLocalizable", "qr-scanning.error.camera-access-denied-message", fallback: "Please grant access to the camera in the device settings.")
      }
      /// Camera access denied
      public static var cameraAccessDeniedTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "qr-scanning.error.camera-access-denied-title", fallback: "Camera access denied")
      }
      /// The QR code is empty
      public static var emptyQrCode: String {
        L10n.tr("GDEBankCoreLocalizable", "qr-scanning.error.empty-qr-code", fallback: "The QR code is empty")
      }
      /// Failed to process the image for QR code detection
      public static var failedImageProcessing: String {
        L10n.tr("GDEBankCoreLocalizable", "qr-scanning.error.failed-image-processing", fallback: "Failed to process the image for QR code detection")
      }
      /// Failed to retrieve the selected image
      public static var failedImageSelection: String {
        L10n.tr("GDEBankCoreLocalizable", "qr-scanning.error.failed-image-selection", fallback: "Failed to retrieve the selected image")
      }
      /// No QR code detected
      public static var noQrCode: String {
        L10n.tr("GDEBankCoreLocalizable", "qr-scanning.error.no-qr-code", fallback: "No QR code detected")
      }
      /// No QR code found in the selected image
      public static var noQrCodeInImage: String {
        L10n.tr("GDEBankCoreLocalizable", "qr-scanning.error.no-qr-code-in-image", fallback: "No QR code found in the selected image")
      }
      /// No video device found
      public static var noVideoDevice: String {
        L10n.tr("GDEBankCoreLocalizable", "qr-scanning.error.no-video-device", fallback: "No video device found")
      }
      /// Failed to toggle the flash
      public static var toggleFlash: String {
        L10n.tr("GDEBankCoreLocalizable", "qr-scanning.error.toggle-flash", fallback: "Failed to toggle the flash")
      }
      /// Torch is not available on this device
      public static var torchUnavailable: String {
        L10n.tr("GDEBankCoreLocalizable", "qr-scanning.error.torch-unavailable", fallback: "Torch is not available on this device")
      }
      /// Unable to process the detected code
      public static var unableToProcessCode: String {
        L10n.tr("GDEBankCoreLocalizable", "qr-scanning.error.unable-to-process-code", fallback: "Unable to process the detected code")
      }
      /// Unknown error occurred while accessing the camera
      public static var unknownCameraError: String {
        L10n.tr("GDEBankCoreLocalizable", "qr-scanning.error.unknown-camera-error", fallback: "Unknown error occurred while accessing the camera")
      }
    }
  }

  public enum SumSub {
    /// Something went wrong.\nPlease try again
    public static var errorMessage: String {
      L10n.tr("GDEBankCoreLocalizable", "sum-sub.error-message", fallback: "Something went wrong.\nPlease try again")
    }
  }

  public enum Transaction {

    public enum Status {

      public enum Error {
        /// Error
        public static var name: String {
          L10n.tr("GDEBankCoreLocalizable", "transaction.status.error.name", fallback: "Error")
        }
      }

      public enum New {
        /// New
        public static var name: String {
          L10n.tr("GDEBankCoreLocalizable", "transaction.status.new.name", fallback: "New")
        }
      }

      public enum Pending {
        /// Pending
        public static var name: String {
          L10n.tr("GDEBankCoreLocalizable", "transaction.status.pending.name", fallback: "Pending")
        }
      }

      public enum Success {
        /// Success
        public static var name: String {
          L10n.tr("GDEBankCoreLocalizable", "transaction.status.success.name", fallback: "Success")
        }
      }
    }
  }

  public enum TransactionCheck {

    public enum Cheque {
      /// The release of Manager Cheque
      public static var navigationTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-check.cheque.navigation-title", fallback: "The release of Manager Cheque")
      }
    }

    public enum Conversion {
      /// Conversion
      public static var navigationTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-check.conversion.navigation-title", fallback: "Conversion")
      }
    }

    public enum DepositCard {
      /// Card deposit
      public static var navigationTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-check.deposit-card.navigation-title", fallback: "Card deposit")
      }
    }

    public enum DepositCash {
      /// Deposit cash
      public static var navigationTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-check.deposit-cash.navigation-title", fallback: "Deposit cash")
      }
    }

    public enum DepositCrypto {
      /// Crypto deposit
      public static var navigationTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-check.deposit-crypto.navigation-title", fallback: "Crypto deposit")
      }
    }

    public enum DepositIban {
      /// SEPA deposit
      public static var navigationTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-check.deposit-iban.navigation-title", fallback: "SEPA deposit")
      }
    }

    public enum DepositPay {
      /// GDEBank deposit
      public static var navigationTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-check.deposit-pay.navigation-title", fallback: "GDEBank deposit")
      }
    }

    public enum Fee {
      /// Transaction fee
      public static var navigationTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-check.fee.navigation-title", fallback: "Transaction fee")
      }
    }

    public enum PaymentCard {
      /// Card payment
      public static var navigationTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-check.payment-card.navigation-title", fallback: "Card payment")
      }
    }

    public enum TransferCard {
      /// Transfer to card
      public static var navigationTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-check.transfer-card.navigation-title", fallback: "Transfer to card")
      }
    }

    public enum TransferCash {
      /// Сash withdrawal
      public static var navigationTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-check.transfer-cash.navigation-title", fallback: "Сash withdrawal")
      }
    }

    public enum TransferCrypto {
      /// Crypto transfer
      public static var navigationTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-check.transfer-crypto.navigation-title", fallback: "Crypto transfer")
      }
    }

    public enum TransferIban {
      /// SEPA transfer
      public static var navigationTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-check.transfer-iban.navigation-title", fallback: "SEPA transfer")
      }
    }

    public enum TransferPay {
      /// GDEBank transfer
      public static var navigationTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-check.transfer-pay.navigation-title", fallback: "GDEBank transfer")
      }
    }
  }

  public enum TransactionInfo {

    public enum Address {
      /// Address
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-info.address.title", fallback: "Address")
      }
    }

    public enum Commission {
      /// Fee
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-info.commission.title", fallback: "Fee")
      }
    }

    public enum Country {
      /// Country
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-info.country.title", fallback: "Country")
      }
    }

    public enum Currency {
      /// Currency
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-info.currency.title", fallback: "Currency")
      }
    }

    public enum DateAndTime {
      /// Date and time
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-info.date-and-time.title", fallback: "Date and time")
      }
    }

    public enum DepositAmount {
      /// Deposit amount
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-info.deposit-amount.title", fallback: "Deposit amount")
      }
    }

    public enum Direction {
      /// Direction
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-info.direction.title", fallback: "Direction")
      }
    }

    public enum DpayRecipientUserEmail {
      /// Recipient
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-info.dpay-recipient-user-email.title", fallback: "Recipient")
      }
    }

    public enum DpaySenderUserEmail {
      /// Sender
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-info.dpay-sender-user-email.title", fallback: "Sender")
      }
    }

    public enum ExchangeNumber {
      /// Exchange number
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-info.exchange-number.title", fallback: "Exchange number")
      }
    }

    public enum OrderNumber {
      /// Order number
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-info.order-number.title", fallback: "Order number")
      }
    }

    public enum Recipient {
      /// Recipient
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-info.recipient.title", fallback: "Recipient")
      }
    }

    public enum RecipientIban {
      /// Recipient IBAN
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-info.recipient-iban.title", fallback: "Recipient IBAN")
      }
    }

    public enum RecipientName {
      /// Recipient name
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-info.recipient-name.title", fallback: "Recipient name")
      }
    }

    public enum SenderId {
      /// Sender ID
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-info.sender-id.title", fallback: "Sender ID")
      }
    }

    public enum Status {
      /// Status
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-info.status.title", fallback: "Status")
      }
    }

    public enum ToCard {
      /// To card
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-info.to-card.title", fallback: "To card")
      }
    }

    public enum Transaction {
      /// Transaction
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-info.transaction.title", fallback: "Transaction")
      }
    }

    public enum TransactionTxtId {
      /// Transaction TxtId
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-info.transaction-txt-id.title", fallback: "Transaction TxtId")
      }
    }

    public enum Wallet {
      /// Wallet
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-info.wallet.title", fallback: "Wallet")
      }
    }

    public enum WalletNumber {
      /// Wallet number
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-info.wallet-number.title", fallback: "Wallet number")
      }
    }

    public enum WithdrawalAmount {
      /// Withdrawal amount
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-info.withdrawal-amount.title", fallback: "Withdrawal amount")
      }
    }
  }

  public enum TransactionList {

    public enum Empty {
      /// All new transactions in this currency will be reflected here
      public static var subtitle: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-list.empty.subtitle", fallback: "All new transactions in this currency will be reflected here")
      }
      /// It's empty here for now
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-list.empty.title", fallback: "It's empty here for now")
      }
    }
  }

  public enum TransactionType {

    public enum Cheque {
      /// Manager Cheque
      public static var name: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-type.cheque.name", fallback: "Manager Cheque")
      }
    }

    public enum Deposit {
      /// Deposit
      public static var name: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-type.deposit.name", fallback: "Deposit")
      }
    }

    public enum DepositСash {
      /// Deposit cash
      public static var name: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-type.deposit-сash.name", fallback: "Deposit cash")
      }
    }

    public enum Exchange {
      /// Exchange
      public static var name: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-type.exchange.name", fallback: "Exchange")
      }
    }

    public enum Fee {
      /// Fee
      public static var name: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-type.fee.name", fallback: "Fee")
      }
    }

    public enum Payment {
      /// Payment
      public static var name: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-type.payment.name", fallback: "Payment")
      }
    }

    public enum Transfer {
      /// Transfer
      public static var name: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-type.transfer.name", fallback: "Transfer")
      }
    }

    public enum TransferСash {
      /// Сash withdrawal
      public static var name: String {
        L10n.tr("GDEBankCoreLocalizable", "transaction-type.transfer-сash.name", fallback: "Сash withdrawal")
      }
    }
  }

  public enum VerificationSuccess {
    /// To the main page
    public static var buttonTitle: String {
      L10n.tr("GDEBankCoreLocalizable", "verification-success.button-title", fallback: "To the main page")
    }

    public enum Email {
      /// Your email address has been changed
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "verification-success.email.title", fallback: "Your email address has been changed")
      }
    }

    public enum Phone {
      /// Your phone number has been changed
      public static var title: String {
        L10n.tr("GDEBankCoreLocalizable", "verification-success.phone.title", fallback: "Your phone number has been changed")
      }
    }
  }

  public enum WalletRequisites {
    /// The details for the deposit are not available
    public static var emptyMessage: String {
      L10n.tr("GDEBankCoreLocalizable", "wallet-requisites.empty-message", fallback: "The details for the deposit are not available")
    }

    public enum Crypto {
      /// Memo
      public static var memoTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "wallet-requisites.crypto.memo-title", fallback: "Memo")
      }
      /// Network
      public static var networkTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "wallet-requisites.crypto.network-title", fallback: "Network")
      }
      /// Wallet address
      public static var walletAddressTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "wallet-requisites.crypto.wallet-address-title", fallback: "Wallet address")
      }
    }

    public enum Fiat {
      /// Beneficiary name
      public static var beneficiaryTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "wallet-requisites.fiat.beneficiary-title", fallback: "Beneficiary name")
      }
      /// Comment
      public static var commentTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "wallet-requisites.fiat.comment-title", fallback: "Comment")
      }
      /// Fee
      public static var feeTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "wallet-requisites.fiat.fee-title", fallback: "Fee")
      }
      /// Maximum amount
      public static var maxSumTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "wallet-requisites.fiat.max-sum-title", fallback: "Maximum amount")
      }
      /// Minimum amount
      public static var minSumTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "wallet-requisites.fiat.min-sum-title", fallback: "Minimum amount")
      }
      /// Wabada Number
      public static var wabadaNumberTitle: String {
        L10n.tr("GDEBankCoreLocalizable", "wallet-requisites.fiat.wabada-number-title", fallback: "Wabada Number")
      }

      public enum Sepa {
        /// Sepa requisites
        public static var title: String {
          L10n.tr("GDEBankCoreLocalizable", "wallet-requisites.fiat.sepa.title", fallback: "Sepa requisites")
        }
      }

      public enum Swift {
        /// Swift requisites
        public static var title: String {
          L10n.tr("GDEBankCoreLocalizable", "wallet-requisites.fiat.swift.title", fallback: "Swift requisites")
        }
      }
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
