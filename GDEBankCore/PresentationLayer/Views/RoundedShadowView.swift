//
//  RoundedShadowView.swift
//  Auth IOS
//
//  Created by incetro on 5/24/21.
//
// 101-ui

import UIKit

// MARK: - RoundedShadowView

final public class RoundedShadowView: UIView {

    // MARK: - Properties

    /// Corner radius value
    public var cornerRadius: CGFloat = 13

    /// Current shadow layer
    private var shadowLayer: CAShapeLayer?

    /// Fill color value
    private var fillColor: UIColor?

    /// View background color (proxy property)
    override public var backgroundColor: UIColor? {
        get {
            fillColor
        }
        set {
            fillColor = newValue
            shadowLayer?.fillColor = newValue?.cgColor
        }
    }

    // MARK: - Initializers

    public init() {
        super.init(frame: .zero)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIView

    override public func layoutIfNeeded() {
        super.layoutIfNeeded()
        setupShadowLayer()
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        setupShadowLayer()
    }

    // MARK: - Private

    private func setupShadowLayer() {
        if shadowLayer == nil, bounds != .zero {
            let shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(
                roundedRect: bounds,
                byRoundingCorners: .allCorners,
                cornerRadii: .init(
                    width: cornerRadius,
                    height: cornerRadius
                )
            ).cgPath
            shadowLayer.fillColor = fillColor?.cgColor
            shadowLayer.shadowColor = UIColor.lightGray.cgColor
            let shadowRadius: CGFloat = 7
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
            shadowLayer.shadowOpacity = 0.13
            shadowLayer.shadowRadius = shadowRadius
            layer.insertSublayer(shadowLayer, at: 0)
            self.shadowLayer = shadowLayer
        }
    }
}
