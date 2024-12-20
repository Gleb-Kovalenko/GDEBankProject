//
//  ViewInput.swift
//  CityGuide
//
//  Created by Gleb Kovalenko on 5.08.24.
//

import Foundation
import UIKit
import Toast

// MARK: - UIView

var currentWindow: UIWindow? {
    UIApplication.shared.currentWindow
}

private var rootVC: UIViewController? {
    currentWindow?.rootViewController.unsafelyUnwrapped
}

/// Show some toast
/// - Parameters:
///   - text: toast text
///   - image: toast image
func showToast(
    text: String,
    image: UIImage,
    location: Toast.Location = .top,
    in viewController: UIViewController? = rootVC
) {
    guard let viewController else { return }
    Toast(
        text,
        state: .custom(
            .init(
                backgroundColor: .init(hexString: "#3A3A3B").withAlphaComponent(0.87),
                font: .systemFont(ofSize: 15),
                accessory: .custom(UIImageView(image: image)),
                accessorySize: 24,
                textAlignment: .left,
                isBlurred: true
            )
        ),
        location: location,
        source: viewController
    )
    .showView()
}

func showToastView(
    text: String,
    image: UIImage,
    location: Toast.Location = .top,
    in viewController: UIViewController? = rootVC
) {
    guard let viewController else { return }
    let toast = Toast(
        text,
        state: .custom(
            .init(
                backgroundColor: .init(hexString: "#3A3A3B").withAlphaComponent(0.87),
                font: .systemFont(ofSize: 15),
                accessory: .custom(UIImageView(image: image)),
                accessorySize: 24,
                textAlignment: .left,
                isBlurred: true
            )
        ),
        location: location,
        source: viewController
    )
    let toastView = ToastView(toast: toast)
    toastView.show(in: viewController)
}

/// Show success toast
/// - Parameters:
///   - text: toast text
///   - image: toast image
func showSuccessToast(
    text: String,
    imageColor: UIColor = .white,
    backgroundColor: UIColor = .init(hexString: "#3A3A3B").withAlphaComponent(0.87),
    location: Toast.Location = .top,
    in viewController: UIViewController? = rootVC
) {
    guard let viewController else { return }
    Toast(
        text,
        state: .custom(
            .init(
                backgroundColor: backgroundColor,
                tintColor: imageColor,
                font: .systemFont(ofSize: 15),
                accessory: .standard(.system("checkmark.circle.fill")),
                accessorySize: 24,
                textAlignment: .left,
                isBlurred: true
            )
        ),
        location: location,
        source: viewController
    )
    .showView()
}

/// Show success toast
/// - Parameters:
///   - text: toast text
///   - image: toast image
func showErrorToast(
    text: String,
    imageColor: UIColor = .init(hexString: "#FF453A"),
    backgroundColor: UIColor = .init(hexString: "#3A3A3B").withAlphaComponent(0.87),
    location: Toast.Location = .top,
    in viewController: UIViewController? = rootVC
) {
    guard let viewController else { return }
    Toast(
        text,
        state: .custom(
            .init(
                backgroundColor: backgroundColor,
                tintColor: imageColor,
                font: .systemFont(ofSize: 15),
                accessory: .standard(.system("xmark.circle.fill")),
                accessorySize: 24,
                textAlignment: .left,
                isBlurred: true
            )
        ),
        location: location,
        source: viewController
    )
    .showView()
}

/// Show toast
/// - Parameters:
///   - text: toast text
///   - image: toast image
func showToast(
    text: String,
    image: UIImage,
    imageColor: UIColor = .init(hexString: "#FFFFFF"),
    backgroundColor: UIColor = .init(hexString: "#3A3A3B").withAlphaComponent(0.87),
    location: Toast.Location = .top,
    in viewController: UIViewController? = rootVC
) {
    guard let viewController else { return }
    Toast(
        text,
        state: .custom(
            .init(
                backgroundColor: backgroundColor,
                tintColor: imageColor,
                font: .systemFont(ofSize: 15),
                accessory: .standard(image),
                accessorySize: 24,
                textAlignment: .left,
                isBlurred: true
            )
        ),
        location: location,
        source: viewController
    )
    .showView()
}

func hideToast(source viewController: UIViewController? = rootVC, animated: Bool = false) {
    guard let viewController else { return }
    Toast.dismiss(source: viewController, animated: animated)
}
