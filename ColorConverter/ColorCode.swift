//
//  ColorCode.swift
//  ColorConverter
//
//  Created by Honma Masaru on 2022/11/05.
//

import SwiftUI

enum ColorCode {
    /// 6文字および8文字のカラーコードの正規表現
    private static let pattern8 = /^#*([0-9A-Fa-f]{2})([0-9A-Fa-f]{2})([0-9A-Fa-f]{2})([0-9A-Fa-f]{2})*$/

    /// 3文字のカラーコードの正規表現
    private static let pattern3 = /^#*([0-9A-Fa-f])([0-9A-Fa-f])([0-9A-Fa-f])$/

    /// カラーコードをRGB値に変換
    /// - Parameter hexStr: カラーコード
    /// - Returns: RGB値
    static func convert(from hexStr: String) -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)? {
        // 6文字および8文字
        if let match = hexStr.firstMatch(of: pattern8) {
            let (_, r, g, b, a) = match.output
            return (toDecimal(r), toDecimal(g), toDecimal(b), toDecimal(a ?? "ff"))
        }
        // 3文字
        if let match = hexStr.firstMatch(of: pattern3) {
            let (_, r, g, b) = match.output
            return (toDecimal(r), toDecimal(g), toDecimal(b), 1.0)
        }
        return nil
    }

    /// 16進をカラー値に変換
    /// - Parameter hex: 16進 (文字列)
    /// - Returns: カラー値
    private static func toDecimal(_ hex: Substring) -> CGFloat {
        let h: String = hex.count == 1 ? .init(repeating: .init(hex), count: 2) : .init(hex)
        return .init(Int(h, radix: 16) ?? 0) / 255.0
    }
}
