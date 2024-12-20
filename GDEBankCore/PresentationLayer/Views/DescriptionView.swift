//
//  DetailedInfoView.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 16.08.24.
//

import SwiftUI

// MARK: - DescriptionView

public struct DescriptionView: View, Skeletonable {
    
    // MARK: - Properties
    
    /// Amount of text lines when view isn't expanded
    private let linesLimit: Int
    
    /// Current text
    private let text: String
    
    /// Text color
    private let textColor: UIColor
    
    /// Text font
    private let textFont: UIFont
    
    /// If view is expanded
    @State var isExpanded = false
    
    /// If view is expandable
    @State var isExpandable = false
    
    /// Label height
    @State var height: CGFloat
    
    // MARK: - Initializers
    
    public init(
        linesLimit: Int,
        text: String,
        textColor: UIColor,
        textFont: UIFont
    ) {
        self.linesLimit = linesLimit
        self.text = text
        self.textColor = textColor
        self.textFont = textFont
        self.height = 18
    }
    
    // MARK: - View
    
    public var body: some View {
        DXInformationView(
            title: "Description"
        ) {
            HStack(alignment: .top, spacing: 0) {
                ZStack(alignment: .bottomTrailing) {
                    DescriptionTextView(
                        font: textFont,
                        color: textColor,
                        lines: isExpanded ? 0 : linesLimit,
                        text: text,
                        dynamicHeight: $height,
                        isExpandable: $isExpandable
                    )
                    .frame(height: height, alignment: .top)
                    .padding(.trailing, 18)
                    if !isExpanded && isExpandable {
                        HStack(spacing: 0) {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 24, height: 18)
                                .background(
                                    LinearGradient(
                                        stops: [
                                            Gradient.Stop(color: .white.opacity(0), location: 0.02),
                                            Gradient.Stop(color: Colors.bg2.swiftUIColor, location: 1.00),
                                        ],
                                        startPoint: UnitPoint(x: 0, y: 0.5),
                                        endPoint: UnitPoint(x: 1, y: 0.5)
                                    )
                                )
                            Button {
                                isExpanded.toggle()
                            } label: {
                                Text("more")
                                    .foregroundColor(.accentColor)
                                    .font(.inter(size: 15, weight: .regular))
                                    .background(Colors.bg2.swiftUIColor)
                            }
                        }
                    }
                }
            }
            if isExpanded {
                Button {
                    isExpanded.toggle()
                } label: {
                    Text("Hide description")
                        .foregroundColor(.accentColor)
                }
                .font(.inter(size: 15, weight: .regular))
            }
        }
        .animation(.spring(duration: 0.2), value: isExpanded)
    }
    
    // MARK: - Skeletonable
    
    public static var skeletonBody: some View {
        DXContainerView {
            VStack(alignment: .leading, spacing: .smallPadding) {
                HorizontalSkeletonElement()
                    .dxSkeleton(shape: .rounded(.radius(18)))
                    .frame(height: 18)
                SkeletonElement()
                    .dxSkeleton(
                        size: CGSize(width: 200, height: 18),
                        shape: .rounded(.radius(18))
                    )
            }
        }
    }
}
