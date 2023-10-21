//
//  TextStyle.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 21.10.2023.
//

import SwiftUI

struct TitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .bold()
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
