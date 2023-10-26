//
//  CircleAvatarView.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 18.10.2023.
//

import SwiftUI
import Kingfisher

struct CircleAvatarView: View {
    let image: ImageSourceType
    var size: CGSize = CGSize(width: 80, height: 80)

    var body: some View {
        switch image {
        case let .link(url):
            AdaptiveKFImage(url: url)
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: size.width, height: size.height)
                .overlay(
                    Circle()
                        .stroke(Color.black, lineWidth: 2)
                )
            
        case let .image(uIImage):
            Image(uiImage: uIImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: size.width, height: size.height)
                .overlay(
                    Circle()
                        .stroke(Color.black, lineWidth: 2)
                )
        case .none:
            Image(systemName: "person")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: size.width, height: size.height)
                .overlay(
                    Circle()
                        .stroke(Color.black, lineWidth: 2)
                )
        }

    }
}

#if DEBUG
#Preview {
    CircleAvatarView(image: .link(URL(string: "https://scontent.fbeg7-2.fna.fbcdn.net/v/t39.30808-6/307279357_632405371581769_4617907306119132376_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=5f2048&_nc_ohc=77ZU8hCI0rcAX8jSRIR&_nc_oc=AQkikEyer_PfcDghMFHg5SnQcabM2xl2-r7T9gGX4x_t-nwxeeq7LvH8Vp9Q8ntK5RE&_nc_ht=scontent.fbeg7-2.fna&oh=00_AfBTjYWkTfbOjFXqd6n3VuRMr485NXOzeWU0HSpl-6Bj5w&oe=6534804D")))
}
#endif
