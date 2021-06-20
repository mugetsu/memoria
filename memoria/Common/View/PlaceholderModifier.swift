//
//  PlaceholderModifier.swift
//  memoria
//
//  Created by Randell Quitain on 20/6/21.
//

import SwiftUI

struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                    .padding(.horizontal, 15)
            }
            content
                .foregroundColor(Color.white)
                .padding(5.0)
        }
    }
}
