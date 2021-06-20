//
//  Text++.swift
//  memoria
//
//  Created by Randell Quitain on 20/6/21.
//

import SwiftUI

extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}
