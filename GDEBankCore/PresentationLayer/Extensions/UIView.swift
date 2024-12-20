//
//  UIView.swift
//  Auth IOS
//
//  Created by incetro on 5/23/21.
//

import UIKit
import Layout

// MARK: - UIView

public extension UIView {

    /// Make a view rounded with smooth corners
    /// - Parameters:
    ///   - corners: smooth corners type
    ///   - radius: necessary corner radius
    ///   - rect: a rect which should be used as a frame of the view
    func smoothlyRoundCourners(
        _ corners: UIRectCorner = .allCorners,
        radius: CGFloat,
        inRect rect: CGRect? = nil
    ) {
        let roundedRect = rect ?? bounds
        guard roundedRect.size != .zero else {
            return
        }
        let roundPath = UIBezierPath(
            roundedRect: roundedRect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.path = roundPath.cgPath
        layer.mask = maskLayer
    }

    /// Returns a new view which will wrap current view
    /// with full constraints to its sides
    /// - Parameter insets: wrapping insets value
    /// - Returns: a new view which will wrap current view
    func wrapped(withInsets insets: UIEdgeInsets) -> UIView {
        prepareForAutolayout()
        let wrapper = UIView()
        wrapper.addSubview(self)
        fullPinToSuperview(withInsets: insets)
        return wrapper
    }

    /// Returns a new view which will wrap current view
    /// with safe constraints to its sides (for every inset value
    /// that is not equal to 0)
    /// - Parameter insets: wrapping insets value
    /// - Returns: a new view which will wrap current view
    func safelyWrapped(withInsets insets: UIEdgeInsets) -> UIView {
        prepareForAutolayout()
        let wrapper = UIView()
        wrapper.addSubview(self)
        safePin(to: wrapper, withInsets: insets)
        return wrapper
    }

    /// Returns all subviews of the given type
    /// - Parameter type: view type
    /// - Returns: all subviews of the given type
    func subviews<T: UIView>(ofType type: T.Type) -> [T] {
        subviews.compactMap { $0 as? T }
    }

    /// Shake view
    ///
    /// - Parameters:
    ///   - direction: shake direction (horizontal or vertical), (default is .horizontal)
    ///   - duration: animation duration in seconds (default is 1 second)
    ///   - animationType: shake animation type (default is .easeOut)
    ///   - completion: optional completion handler to run with animation finishes (default is nil)
    func shake(
        direction: ShakeDirection = .horizontal,
        duration: TimeInterval = 0.62,
        animationType: ShakeAnimationType = .easeOut,
        completion: (() -> Void)? = nil
    ) {
        CATransaction.begin()
        let animation: CAKeyframeAnimation
        switch direction {
        case .horizontal:
            animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        case .vertical:
            animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        }
        switch animationType {
        case .linear:
            animation.timingFunction = CAMediaTimingFunction(name: .linear)
        case .easeIn:
            animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        case .easeOut:
            animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        case .easeInOut:
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        }
        CATransaction.setCompletionBlock(completion)
        animation.duration = duration
        animation.values = [-10.0, 10.0, -10.0, 10.0, -5.0, 5.0, -2.0, 2.0, 0.0]
        layer.add(animation, forKey: "shake")
        CATransaction.commit()
    }

    /// Shake directions of a view
    ///
    /// - horizontal: shake left and right
    /// - vertical: shake up and down
    enum ShakeDirection {

        /// Shake left and right
        case horizontal

        /// Shake up and down
        case vertical
    }

    /// Shake animations types
    ///
    /// - linear: linear animation
    /// - easeIn: easeIn animation
    /// - easeOut: easeOut animation
    /// - easeInOut: easeInOut animation
    enum ShakeAnimationType {

        /// linear animation.
        case linear

        /// easeIn animation.
        case easeIn

        /// easeOut animation.
        case easeOut

        /// easeInOut animation.
        case easeInOut
    }
    
    
    private static let kRotationAnimationKey = "rotationanimationkey"
    
    func rotate(duration: Double = 1) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }
    
    func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
}
