//
//  ColorConverter.swift
//  ColorConverter
//
//  Created by Honma Masaru on 2022/11/05.
//

import SwiftUI

struct ColorConverter: View {
    /// カラーコード入力
    @State private var colorCode: String = ""

    /// UIColorの出力
    @State private var uiColorString: String = "UIColor"

    /// Colorの出力
    @State private var colorString: String = "Color"

    /// パレットのカラー
    @State private var color: Color?

    /// メッセージ
    @State private var messege: String = ""

    /// body
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(color ?? .black)
                .frame(width: 80, height: 80)
            VStack {
                TextField("カラーコード", text: $colorCode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text(uiColorString)
                    .foregroundColor(uiColorString == "UIColor" ? .gray : nil)
                    .font(.caption)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .onTapGesture() { clip(uiColorString) }
                Text(colorString)
                    .foregroundColor(colorString == "Color" ? .gray : nil)
                    .font(.caption)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .onTapGesture() { clip(colorString) }
                Text(messege)
                    .frame(maxHeight: .infinity)
            }
        }
        .frame(maxWidth: 400, maxHeight: 120)
        .padding()
        .onChange(of: colorCode, perform: convert)
    }

    /// 出力
    private func convert(_ colorCode: String) {
        if let c = ColorCode.convert(from: colorCode) {
            uiColorString = "UIColor(red: \(c.r), green: \(c.g), blue: \(c.b), alpha: \(c.a))"
            colorString = "Color(red: \(c.r), green: \(c.g), blue: \(c.b), opacity: \(c.a))"
            color = .init(red: c.r, green: c.g, blue: c.b, opacity: c.a)
        } else {
            uiColorString = "UIColor"
            colorString = "Color"
            color = nil
        }
    }

    /// クリップボードにコピー
    /// - Parameter string: 文字列
    private func clip(_ string: String) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(string, forType: .string)
        messege = "コピーしました"
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            messege = ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ColorConverter()
    }
}
