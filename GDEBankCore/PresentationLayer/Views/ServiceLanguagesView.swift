//
//  ServiceLanguagesView.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 16.08.2024.
//

import SwiftUI
import SwiftMacrosKit

// MARK: - ServiceLanguagesView

@WithLocalizationUpdater
public struct ServiceLanguagesView: View {
    
    // MARK: - Properties
    
    /// Service languages
    public let serviceLanguages: [ServiceLanguageType]
    
    // MARK: - View
    
    public var body: some View {
        ZStack {
            ForEach(Array(0..<serviceLanguages.count).reversed(), id: \.self) { index in
                ZStack {
                    Circle()
                        .fill()
                        .foregroundColor(Colors.bg2.swiftUIColor)
                        .frame(size: Constants.imageSize + 6)
                    Image(serviceLanguages[index].imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(size: Constants.imageSize)
                }
                .offset(x: Constants.xOffset(for: index))
            }
        }
        .frame(
            width: Constants.viewWidth(for: serviceLanguages.count),
            height: Constants.imageSize
        )
        .offset(x: -Constants.viewXOffset(for: serviceLanguages.count))
    }
}

// MARK: - ServiceLanguagesView

extension ServiceLanguagesView: Skeletonable {
    
    public static var skeletonBody: some View {
        ZStack {
            ForEach(Array(0..<4).reversed(), id: \.self) { index in
                ZStack {
                    Circle()
                        .fill()
                        .foregroundColor(Colors.bg2.swiftUIColor)
                        .frame(size: Constants.imageSize + 6)
                    SkeletonElement()
                        .dxSkeleton(
                            size: CGSize(
                                width: Constants.imageSize,
                                height: Constants.imageSize
                            ),
                            shape: .circle
                        )
                }
                .offset(x: Constants.xOffset(for: index))
            }
        }
        .frame(
            width: Constants.viewWidth(for: 4),
            height: Constants.imageSize
        )
        .offset(x: -Constants.viewXOffset(for: 4))
    }
    
}

// MARK: - Constants

private enum Constants {
    static let imageSize: CGFloat = 24
    static let padding: CGFloat = 4
    
    static func xOffset(for index: Int) -> CGFloat {
        CGFloat(index) * (imageSize - padding)
    }
    
    static func viewWidth(for count: Int) -> CGFloat {
        CGFloat(count) * imageSize - CGFloat((count - 1)) * padding
    }
    
    static func viewXOffset(for count: Int) -> CGFloat {
        CGFloat(count - 1) * (padding * 2 + padding / 2)
    }
}

#Preview {
    ZStack {
        Color.black
        VStack {
            Color.red
        }
        .frame(size: 250)
        ServiceLanguagesView(serviceLanguages: [
            .el,
            .rus,
            .eng,
            .tr
        ])
    }
}


#Preview("skeleton") {
    ZStack {
        Color.black
        VStack {
            Color.red
        }
        .frame(size: 250)
        ServiceLanguagesView.skeleton()
    }
}
