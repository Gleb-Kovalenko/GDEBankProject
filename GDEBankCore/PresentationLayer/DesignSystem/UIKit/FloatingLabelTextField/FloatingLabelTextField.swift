//
//  FloatingLabelTextField.swift
//  Auth IOS
//
//  Created by incetro on 5/25/21.
//
// 101-ui

import UIKit

// MARK: - FloatingLabelTextField

open class FloatingLabelTextField: ChainableTextField {

    // MARK: - Step

    /// Current textfield step
    public enum Step {

        /// Active state
        case active

        /// Passive state
        case inactive
    }

    // MARK: - Properties

    /// Current text field state
    private var step: Step = .inactive {
        didSet {
            animatePlaceholderIfNeeded(with: step)
        }
    }

    /// Animatable placeholder label
    private let placeholderLabel: UILabel = {
        let placeholderLabel = UILabel()
        placeholderLabel.layoutMargins = .zero
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.insetsLayoutMarginsFromSafeArea = false
        return placeholderLabel
    }()

    /// Ative state constraints
    private var editingConstraints = [NSLayoutConstraint]()

    /// Inactive state constraints
    private var notEditingConstraints = [NSLayoutConstraint]()

    /// Current state constraints
    private var activeConstraints = [NSLayoutConstraint]()

    /// Placeholder text font
    public var placeholderFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            setNeedsLayout()
        }
    }

    /// Text field text value
    public override var text: String? {
        didSet {
            animatePlaceholderIfNeeded(with: step)
        }
    }

    /// Placeholder text value
    public var placeholderText: String? {
        didSet {
            placeholderLabel.text = placeholderText
            animatePlaceholderIfNeeded(with: step)
        }
    }

    /// Placeholder transforming ratio
    public var placeholderSizeFactor: CGFloat = 0.7 {
        didSet {
            setNeedsLayout()
        }
    }

    /// Border color value in a valid state
    public var borderColor: UIColor = .clear {
        didSet {
            setNeedsLayout()
        }
    }

    /// Border color value in an error state
    public  var errorBorderColor: UIColor = UIColor(red: 1, green: 0, blue: 131 / 255, alpha: 1) {
        didSet {
            setNeedsLayout()
        }
    }

    /// Main placeholder text color
    public var placeholderTextColor: UIColor = UIColor(white: 183 / 255, alpha: 1) {
        didSet {
            setNeedsLayout()
        }
    }

    /// Input text color
    public var textFieldTextColor: UIColor = UIColor(white: 74 / 255, alpha: 1) {
        didSet {
            setNeedsLayout()
        }
    }

    /// Disabled state text color
    public var disabledTextColor: UIColor = UIColor(white: 183 / 255, alpha: 1) {
        didSet {
            setNeedsLayout()
        }
    }

    /// Disabled state background color
    public var disabledBackgroundColor: UIColor = UIColor(white: 247 / 255, alpha: 1) {
        didSet {
            setNeedsLayout()
        }
    }

    /// Enabled state background color
    public var enabledBackgroundColor: UIColor = .clear {
        didSet {
            setNeedsLayout()
        }
    }

    /// True if the current text field should be disabled
    public var disabled = false {
        didSet {
            step = .inactive
            textColor = disabled ? disabledTextColor : textFieldTextColor
            backgroundColor = disabled ? disabledBackgroundColor : enabledBackgroundColor
            isEnabled = !disabled
        }
    }

    /// True if we should show an error state
    public var error = false {
        didSet {
            layer.borderColor = error
                ? errorBorderColor.cgColor
                : step == .active
                ? borderColor.cgColor
                : UIColor(white: 236 / 255, alpha: 1).cgColor
        }
    }

    // MARK: - Initializers

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    // MARK: - UITextField

    public override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.font = placeholderFont
        placeholderLabel.textColor = placeholderTextColor
    }

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        return calculateTextRect(forBounds: bounds)
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        return calculateTextRect(forBounds: bounds)
    }

    // MARK: - Private

    /// Setup views layout
    private func setupViews() {

        addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)

        addSubview(placeholderLabel)

        notEditingConstraints = [
            NSLayoutConstraint(
                item: placeholderLabel,
                attribute: .left,
                relatedBy: .equal,
                toItem: self,
                attribute: .left,
                multiplier: 1,
                constant: Constants.leftPadding
            ),
            NSLayoutConstraint(
                item: placeholderLabel,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: self,
                attribute: .centerY,
                multiplier: 1,
                constant: 0
            )
        ]

        NSLayoutConstraint.activate(notEditingConstraints)
        activeConstraints = notEditingConstraints
        setNeedsLayout()
    }

    /// Calculate constraints in editing mode
    private func calculateEditingConstraints() {

        let attributedStringPlaceholder = NSAttributedString(
            string: placeholderText ?? "",
            attributes: [
                .font: placeholderFont
            ]
        )

        let originalWidth = attributedStringPlaceholder.boundingRect(
            with: CGSize(
                width: .greatestFiniteMagnitude,
                height: frame.height
            ),
            options: [],
            context: nil
        ).width

        let xOffset = (originalWidth - (originalWidth * placeholderSizeFactor)) / 2

        editingConstraints = [
            NSLayoutConstraint(
                item: placeholderLabel,
                attribute: .left,
                relatedBy: .equal,
                toItem: self,
                attribute: .left,
                multiplier: 1,
                constant: -xOffset + Constants.leftPadding
            ),
            NSLayoutConstraint(
                item: placeholderLabel,
                attribute: .top,
                relatedBy: .equal,
                toItem: self,
                attribute: .top,
                multiplier: 1,
                constant: Constants.topPadding
            )
        ]
    }

    /// Animate current placeholder label if needed
    /// - Parameter step: current field state
    private func animatePlaceholderIfNeeded(with step: Step) {
        switch step {
        case .active:
            animatePlaceholderToActivePosition()
        case .inactive:
            if text?.isEmpty == true {
                animatePlaceholderToInactivePosition()
            } else {
                animatePlaceholderToActivePosition()
            }
        }
        setNeedsLayout()
    }

    /// Animate placeholder to active position (top)
    /// - Parameter animated: true if need to use animation
    private func animatePlaceholderToActivePosition(animated: Bool = true) {

        calculateEditingConstraints()
        layoutIfNeeded()

        NSLayoutConstraint.deactivate(activeConstraints)
        NSLayoutConstraint.activate(editingConstraints)

        activeConstraints = editingConstraints

        let animationBlock = { [weak self] in
            guard let self = self else { return }
            self.layoutIfNeeded()
            self.placeholderLabel.transform = CGAffineTransform(
                scaleX: self.placeholderSizeFactor,
                y: self.placeholderSizeFactor
            )
        }
        if animated {
            UIView.animate(withDuration: 0.2) {
                animationBlock()
            }
        } else {
            animationBlock()
        }
    }

    /// Animate placeholder to inactive position (normal)
    /// - Parameter animated: true if need to use animation
    private func animatePlaceholderToInactivePosition(animated: Bool = true) {

        layoutIfNeeded()

        NSLayoutConstraint.deactivate(activeConstraints)
        NSLayoutConstraint.activate(notEditingConstraints)

        activeConstraints = notEditingConstraints

        let animationBlock = { [weak self] in
            guard let self = self else { return }
            self.layoutIfNeeded()
            self.placeholderLabel.transform = .identity
        }
        if animated {
            UIView.animate(withDuration: 0.2) {
                animationBlock()
            }
        } else {
            animationBlock()
        }
    }

    /// Calculate current text rect
    /// - Parameter bounds: current view bounds
    /// - Returns: current text rect
    private func calculateTextRect(forBounds bounds: CGRect) -> CGRect {
        let textInset = placeholderText?.isEmpty == true ? 0 : Constants.textRectYInset
        return CGRect(
            x: Constants.leftPadding,
            y: textInset,
            width: bounds.width - (Constants.leftPadding * 2),
            height: bounds.height
        )
    }
}

// MARK: - Actions

private extension FloatingLabelTextField {

    @objc func editingDidBegin() {
        step = .active
    }

    @objc func editingDidEnd() {
        step = .inactive
    }
}

// MARK: - Constants

public extension FloatingLabelTextField {

    enum Constants {
        static let textRectYInset: CGFloat = 7
        static let topPadding: CGFloat = 4
        static let leftPadding: CGFloat = 14
    }
}
