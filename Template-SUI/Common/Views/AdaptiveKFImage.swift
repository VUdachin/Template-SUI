//
//  AdaptiveKFImage.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 08.10.2023.
//

import SwiftUI
import Kingfisher

struct AdaptiveKFImage: View {
    let url: URL?

    var body: some View {
        KFImage.url(url)
            .cacheOriginalImage()
            .resizable()
    }
}
