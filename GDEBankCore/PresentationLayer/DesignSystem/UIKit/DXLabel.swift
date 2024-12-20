//
//  DXLabel.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 02.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import UIKit
import Layout

// MARK: - DXInfoLabel

public class DXInfoLabel: StylableUIView<DXInfoLabel.Appearance> {
    
    // MARK: - Subviews
    
    /// Info image icon view instance
    private let image = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    /// Info label view instance
    private let label = UILabel().then {
        $0.numberOfLines = 2
    }
    
    /// Auxillary stack view instance
    private let stack = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
    }
    
    // MARK: - Useful
    
    public var text: String? {
        didSet {
            label.text = text
            stack.isHidden = (text ?? "").isEmpty
        }
    }
    
    public var state: UIState = .normal {
        didSet {
            style(with: appearance)
        }
    }
    
    // MARK: - Initializers
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setup() {
        prepareForAutolayout()
        setupStack()
        setupImage()
        setupText()
    }
    
    private func setupStack() {
        stack.prepareForAutolayout()
        addSubview(stack)
        stack.pin(to: self)
    }
    
    private func setupImage() {
        image.prepareForAutolayout()
        stack.addArrangedSubview(image)
        image.size(LayoutConstants.imageSize)
    }
    
    private func setupText() {
        label.prepareForAutolayout()
        stack.addArrangedSubview(label)
    }
    
    // MARK: - Style
    
    public override func style(with appearance: Appearance) {
        styleStack(with: appearance)
        styleImage(with: appearance)
        styleLabel(with: appearance)
    }
    
    private func styleStack(with appearance: Appearance) {
        stack.spacing = appearance.stackSpacing
    }
    
    private func styleImage(with appearance: Appearance) {
        image.image = (state == .normal ? appearance.infoImage : appearance.errorImage).withRenderingMode(.alwaysTemplate)
        image.tintColor = (state == .normal ? appearance.imageColor : appearance.errorColor)
    }
    
    private func styleLabel(with appearance: Appearance) {
        label.font = appearance.textFont
        label.textColor = (state == .normal ? appearance.textColor : appearance.errorColor)
    }
}

// MARK: - Appearance

extension DXInfoLabel {
    
    public struct Appearance: Default {
        
        // MARK: - Images
        
        public let infoImage: UIImage
        public let errorImage: UIImage
        
        // MARK: - Colors
        
        public let textColor: UIColor
        public let imageColor: UIColor
        public let errorColor: UIColor
        
        // MARK: - Fonts
        
        public let textFont: UIFont
        
        // MARK: - Dimensions
        
        public let imageSize: CGSize
        public let stackSpacing: CGFloat
        
        // MARK: - Initializers
        
        public init(
            infoImage: UIImage = Assets.info.image,
            errorImage: UIImage = Assets.alertCircle.image,
            textColor: UIColor = Colors.gray2.color,
            imageColor: UIColor = Colors.gray1.color,
            errorColor: UIColor = Colors.alert1.color,
            textFont: UIFont = .inter(size: 11, weight: .medium),
            imageSize: CGSize = LayoutConstants.imageSize,
            stackSpacing: CGFloat = LayoutConstants.stackSpacing
        ) {
            self.infoImage = infoImage
            self.errorImage = errorImage
            self.textColor = textColor
            self.imageColor = imageColor
            self.errorColor = errorColor
            self.textFont = textFont
            self.imageSize = imageSize
            self.stackSpacing = stackSpacing
        }
        
        // MARK: - Default
        
        public static let `default` = Appearance()
    }
}

// MARK: - LayoutConstants

extension DXInfoLabel {
    
    public enum LayoutConstants {
        
        // MARK: - Constants
        
        public static let stackSpacing: CGFloat = 12
        public static let imageSize = CGSize(width: 16, height: 16)
    }
}

// MARK: - Preview

import SwiftUI
import Then

private struct TestView: View {
    
    let label = DXInfoLabel().then {
        $0.text = "Hello"
        $0.state = .normal
        $0.prepareForAutolayout()
        $0.width(200)
    }
    
    @State var subtitle = "Hello"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            Text("View for test")
                .font(.title2)
            label
                .swiftUI()
                .frame(width: 200, height: 24)
                .padding()
                .background(Colors.bg2.swiftUIColor)
                .cornerRadius(12, corners: .allCorners)
            Text("Test it out!")
                .font(.title2)
            HStack(spacing: 45) {
                Button(role: .cancel) {
                    label.state = .normal
                } label: {
                    Text("NORMAL")
                }
                .padding()
                .background(Color.blue.opacity(0.6))
                .clipShape(Capsule())
                Button(role: .destructive) {
                    label.state = .error()
                } label: {
                    Text("ERROR")
                }
                .padding()
                .background(Color.red.opacity(0.6))
                .clipShape(Capsule())
            }
            if #available(iOS 17.0, *) {
                TextField("Enter text", text: $subtitle)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 13).stroke(lineWidth: 1))
                    .onChange(of: subtitle) {
                        label.text = subtitle
                    }
            }
        }
        .padding()
    }
}

#Preview {
    TestView()
}
