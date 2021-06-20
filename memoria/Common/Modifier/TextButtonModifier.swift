//
//  TextButtonModifier.swift
//  memoria
//
//  Created by Randell Quitain on 20/6/21.
//

import SwiftUI

struct TextBButtonDefaultStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 112, height: 42)
            .font(.custom("Comfortaa-SemiBold", size: 21))
            .foregroundColor(Color("carolinaBlue"))
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color("ivory"))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color("ivory"), lineWidth: 1)
            )
    }
}

struct TextBButtonActiveStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 112, height: 42)
            .font(.custom("Comfortaa-SemiBold", size: 21))
            .foregroundColor(Color.white)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color("carolinaBlue"))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color("carolinaBlue"), lineWidth: 1)
            )
    }
}
