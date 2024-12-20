//
//  DetaileInfoLabel.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 21.08.24.
//

import Foundation
import SwiftUI

// MARK: - DescriptionTextView

public struct DescriptionTextView: UIViewRepresentable {
    
    // MARK: - Properties
    
    /// Text font
    private let font: UIFont
    
    /// Text color
    private let color: UIColor
    
    /// Amount of lines
    private let lines: Int
    
    /// Current text
    private let text: String
    
    /// Text height
    @Binding private var dynamicHeight: CGFloat
    
    /// If view is expandable
    @Binding private var isExpandable: Bool
    
    // MARK: - Initializers
    
    public init(
        font: UIFont,
        color: UIColor,
        lines: Int,
        text: String,
        dynamicHeight: Binding<CGFloat>,
        isExpandable: Binding<Bool>
    ) {
        self.font = font
        self.color = color
        self.lines = lines
        self.text = text
        _dynamicHeight = dynamicHeight
        _isExpandable = isExpandable
    }
    
    // MARK: - Label
    
    public func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.text = text
        textView.font = font
        textView.textColor = color
        textView.textContainerInset = .zero
        textView.backgroundColor = .clear
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainer.maximumNumberOfLines = lines
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.textAlignment = .left
        textView.setContentCompressionResistancePriority(
            .defaultLow,
            for: .horizontal
        )
        textView.isUserInteractionEnabled = false
        textView.setContentCompressionResistancePriority(
            .defaultLow,
            for: .vertical
        )
        textView.sizeToFit()
        return textView
    }
    
    public func updateUIView(_ textView: UITextView, context: Context) {
        DispatchQueue.main.async {
            isExpandable = textView.numberOfLine() > lines
            textView.textContainer.maximumNumberOfLines = lines
            dynamicHeight = textView.sizeThatFits(
                CGSize(width: textView.bounds.width, height: CGFloat.greatestFiniteMagnitude)
            ).height
            textView.sizeToFit()
            textView.textContainer.maximumNumberOfLines = 0
        }
    }
}
