//
// UIFontExtensions.swift
//
// Copyright © 2015 Zeeshan Mian
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import UIKit

extension UIFont {
    public enum TextStyle: RawRepresentable {
        case title1, title2, title3, headline, subheadline, body, callout, footnote, caption1, caption2

        public var rawValue: String {
            switch self {
                case .title1:      return UIFontTextStyle.title1.rawValue
                case .title2:      return UIFontTextStyle.title2.rawValue
                case .title3:      return UIFontTextStyle.title3.rawValue
                case .headline:    return UIFontTextStyle.headline.rawValue
                case .subheadline: return UIFontTextStyle.subheadline.rawValue
                case .body:        return UIFontTextStyle.body.rawValue
                case .callout:     return UIFontTextStyle.callout.rawValue
                case .footnote:    return UIFontTextStyle.footnote.rawValue
                case .caption1:    return UIFontTextStyle.caption1.rawValue
                case .caption2:    return UIFontTextStyle.caption2.rawValue
            }
        }

        public init?(rawValue: String) {
            switch rawValue {
                case UIFontTextStyle.title1.rawValue:      self = .title1
                case UIFontTextStyle.title2.rawValue:      self = .title2
                case UIFontTextStyle.title3.rawValue:      self = .title3
                case UIFontTextStyle.headline.rawValue:    self = .headline
                case UIFontTextStyle.subheadline.rawValue: self = .subheadline
                case UIFontTextStyle.body.rawValue:        self = .body
                case UIFontTextStyle.callout.rawValue:     self = .callout
                case UIFontTextStyle.footnote.rawValue:    self = .footnote
                case UIFontTextStyle.caption1.rawValue:    self = .caption1
                case UIFontTextStyle.caption2.rawValue:    self = .caption2
                default: fatalError("Unsupported `TextStyle`")
            }
        }
    }

    public static func systemFont(_ style: TextStyle) -> UIFont {
        return preferredFont(forTextStyle: UIFontTextStyle(rawValue: style.rawValue))
    }
}

extension UIFont {
    public enum Style {
        case normal, italic, monospace
    }

    public enum Weight {
        case ultralight, thin, light, regular, medium, semibold, bold, heavy, black
    }

    public struct Size {
        public static let headline: CGFloat    = 16
        public static let subheadline: CGFloat = 14
        public static let body: CGFloat        = 16
        public static let label                = UIFont.labelFontSize
        public static let button               = UIFont.buttonFontSize
        public static let small                = UIFont.smallSystemFontSize
        public static let system               = UIFont.systemFontSize
    }

    public static func systemFont(_ size: CGFloat, style: Style = .normal, weight: Weight = .regular) -> UIFont {
        let fontWeight: CGFloat

        switch weight {
            case .ultralight:
                fontWeight = UIFontWeightUltraLight
            case .thin:
                fontWeight = UIFontWeightThin
            case .light:
                fontWeight = UIFontWeightLight
            case .regular:
                fontWeight = UIFontWeightRegular
            case .medium:
                fontWeight = UIFontWeightMedium
            case .semibold:
                fontWeight = UIFontWeightSemibold
            case .bold:
                fontWeight = UIFontWeightBold
            case .heavy:
                fontWeight = UIFontWeightHeavy
            case .black:
                fontWeight = UIFontWeightBlack
        }

        switch style {
            case .normal:
                return systemFont(ofSize: size, weight: fontWeight)
            case .italic:
                return italicSystemFont(ofSize: size)
            case .monospace:
                return monospacedDigitSystemFont(ofSize: size, weight: fontWeight)
        }
    }
}

extension UIFont {
    public static func printAvailableFontNames() {
        for family in familyNames {
            let count = fontNames(forFamilyName: family).count
            print("▿ \(family) (\(count) \(count == 1 ? "font" : "fonts"))")
            for name in fontNames(forFamilyName: family) {
                print("  - \(name)")
            }
        }
    }

    /// Returns a font matching the given font descriptor.
    ///
    /// - parameter traits: The new symbolic traits.
    ///
    /// - returns: The new font matching the given font descriptor.
    public func traits(_ traits: UIFontDescriptorSymbolicTraits...) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(UIFontDescriptorSymbolicTraits(traits))
        return UIFont(descriptor: descriptor!, size: 0)
    }

    public var monospacedDigitFont: UIFont {
        let featureSettings = [[UIFontFeatureTypeIdentifierKey: kNumberSpacingType, UIFontFeatureSelectorIdentifierKey: kMonospacedNumbersSelector]]
        let attributes      = [UIFontDescriptorFeatureSettingsAttribute: featureSettings]
        let oldDescriptor   = fontDescriptor
        let newDescriptor   = oldDescriptor.addingAttributes(attributes)
        return UIFont(descriptor: newDescriptor, size: 0)
    }
}
