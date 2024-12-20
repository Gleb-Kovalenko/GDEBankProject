//
//  MarkdownView.swift
//  GDEBank
//
//  Created by incetro on 2/23/24.
//

import SwiftUI
import MarkdownUI

// MARK: - MarkdownView

public struct MarkdownView: View {
    
    public let text: String
    
    public var body: some View {
        ScrollView(.vertical) {
            Markdown(
                MarkdownContent(
                    text
                )
            )
            .markdownTheme(.basic)
            .padding(.horizontal, 16)
            .padding(.top, 40)
        }
    }
}

#Preview {
    MarkdownView(text: testText)
}


extension Theme {

    /// A theme that mimics the GitHub style.
    ///
    /// Style | Preview
    /// --- | ---
    /// Inline text | ![](GitHubInlines)
    /// Headings | ![](GitHubHeading)
    /// Blockquote | ![](GitHubBlockquote)
    /// Code block | ![](GitHubCodeBlock)
    /// Image | ![](GitHubImage)
    /// Task list | ![](GitHubTaskList)
    /// Bulleted list | ![](GitHubNestedBulletedList)
    /// Numbered list | ![](GitHubNumberedList)
    /// Table | ![](GitHubTable)
    public static let gdeBank = Theme()
        .text {
            ForegroundColor(.text)
            BackgroundColor(.background)
            FontFamily(.system(.default))
            FontSize(17)
        }
        .code {
            FontFamilyVariant(.monospaced)
            FontFamily(.system(.default))
//            FontSize(.em(0.85))
            BackgroundColor(.secondaryBackground)
        }
        .strong {
            FontFamily(.system(.default))
            FontWeight(.semibold)
        }
        .link {
            FontFamily(.system(.default))
            ForegroundColor(.link)
        }
        .heading1 { configuration in
            VStack(alignment: .leading, spacing: 0) {
                configuration.label
//                    .relativePadding(.bottom, length: .em(0.3))
//                    .relativeLineSpacing(.em(0.125))
                    .markdownMargin(top: 24, bottom: 16)
                    .markdownTextStyle {
                        FontFamily(.system(.default))
                        FontWeight(.semibold)
//                        FontSize(.em(2))
                    }
                Divider().overlay(Color.divider)
            }
        }
        .heading2 { configuration in
            VStack(alignment: .leading, spacing: 0) {
                configuration.label
//                    .relativePadding(.bottom, length: .em(0.3))
//                    .relativeLineSpacing(.em(0.125))
                    .markdownMargin(top: 24, bottom: 16)
                    .markdownTextStyle {
                        FontFamily(.system(.default))
                        FontWeight(.semibold)
//                        FontSize(.em(1.5))
                    }
                Divider().overlay(Color.divider)
            }
        }
        .heading3 { configuration in
            configuration.label
//                .relativeLineSpacing(.em(0.125))
                .markdownMargin(top: 24, bottom: 16)
                .markdownTextStyle {
                    FontFamily(.system(.default))
                    FontWeight(.semibold)
//                    FontSize(.em(1.25))
                }
        }
        .heading4 { configuration in
            configuration.label
//                .relativeLineSpacing(.em(0.125))
                .markdownMargin(top: 24, bottom: 16)
                .markdownTextStyle {
                    FontFamily(.system(.default))
                    FontWeight(.semibold)
                }
        }
        .heading5 { configuration in
            configuration.label
//                .relativeLineSpacing(.em(0.125))
                .markdownMargin(top: 24, bottom: 16)
                .markdownTextStyle {
                    FontFamily(.system(.default))
                    FontWeight(.semibold)
//                    FontSize(.em(0.875))
                }
        }
        .heading6 { configuration in
            configuration.label
//                .relativeLineSpacing(.em(0.125))
                .markdownMargin(top: 24, bottom: 16)
                .markdownTextStyle {
                    FontFamily(.system(.default))
                    FontWeight(.semibold)
//                    FontSize(.em(0.85))
                    ForegroundColor(.tertiaryText)
                }
        }
        .paragraph { configuration in
            configuration.label
                .fixedSize(horizontal: false, vertical: true)
//                .relativeLineSpacing(.em(0.25))
                .markdownMargin(top: 0, bottom: 16)
        }
        .blockquote { configuration in
            HStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.border)
//                    .relativeFrame(width: .em(0.2))
                configuration.label
                    .markdownTextStyle {
                        FontFamily(.system(.default))
                        ForegroundColor(.secondaryText)
                    }
//                    .relativePadding(.horizontal, length: .em(1))
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .codeBlock { configuration in
            ScrollView(.horizontal) {
                configuration.label
                    .fixedSize(horizontal: false, vertical: true)
                    .relativeLineSpacing(.em(0.225))
                    .markdownTextStyle {
                        FontFamily(.system(.default))
                        FontFamilyVariant(.monospaced)
                        FontSize(.em(0.85))
                    }
                    .padding(16)
            }
            .background(Color.secondaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .markdownMargin(top: 0, bottom: 16)
        }
        .listItem { configuration in
            configuration.label
//                .markdownMargin(top: .em(0.25))
                .markdownMargin(top: 8, bottom: 8)
        }
        .taskListMarker { configuration in
            Image(systemName: configuration.isCompleted ? "checkmark.square.fill" : "square")
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(Color.checkbox, Color.checkboxBackground)
                .imageScale(.small)
//                .relativeFrame(minWidth: .em(1.5), alignment: .trailing)
        }
        .image { configuration in
            configuration.label
                .frame(maxWidth: .infinity)
                .clipShape(
                    RoundedRectangle(cornerRadius: 7, style: .continuous)
                )
        }
        .table { configuration in
            configuration.label
                .fixedSize(horizontal: false, vertical: true)
                .markdownTableBorderStyle(.init(color: .border))
                .markdownTableBackgroundStyle(
                    .alternatingRows(Color.background, Color.secondaryBackground)
                )
                .markdownMargin(top: 0, bottom: 16)
        }
        .tableCell { configuration in
            configuration.label
                .markdownTextStyle {
                    if configuration.row == 0 {
                        FontWeight(.semibold)
                    }
                    BackgroundColor(nil)
                }
                .fixedSize(horizontal: false, vertical: true)
                .padding(.vertical, 6)
                .padding(.horizontal, 13)
//                .relativeLineSpacing(.em(0.25))
        }
        .thematicBreak {
            Divider()
//                .relativeFrame(height: .em(0.25))
                .overlay(Color.border)
                .markdownMargin(top: 24, bottom: 24)
        }
}

extension Color {
    fileprivate static let text = Color(
        light: Color(rgba: 0x0606_06ff), dark: Color(rgba: 0xfbfb_fcff)
    )
    fileprivate static let secondaryText = Color(
        light: Color(rgba: 0x6b6e_7bff), dark: Color(rgba: 0x9294_a0ff)
    )
    fileprivate static let tertiaryText = Color(
        light: Color(rgba: 0x6b6e_7bff), dark: Color(rgba: 0x6d70_7dff)
    )
    fileprivate static let background = Color(
        light: .white, dark: Color(rgba: 0x1819_1dff)
    )
    fileprivate static let secondaryBackground = Color(
        light: Color(rgba: 0xf7f7_f9ff), dark: Color(rgba: 0x2526_2aff)
    )
    fileprivate static let link = Color(
        light: Color(rgba: 0x2c65_cfff), dark: Color(rgba: 0x4c8e_f8ff)
    )
    fileprivate static let border = Color(
        light: Color(rgba: 0xe4e4_e8ff), dark: Color(rgba: 0x4244_4eff)
    )
    fileprivate static let divider = Color(
        light: Color(rgba: 0xd0d0_d3ff), dark: Color(rgba: 0x3334_38ff)
    )
    fileprivate static let checkbox = Color(rgba: 0xb9b9_bbff)
    fileprivate static let checkboxBackground = Color(rgba: 0xeeee_efff)
}



public let testText = ""
