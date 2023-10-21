//
//  ProfileSummaryView.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 18.10.2023.
//

import SwiftUI

struct ProfileSummaryView: View {
    let userName: String
    let email: String
    let image: ImageSourceType

    var body: some View {
        HStack(alignment: .top) {
            CircleAvatarView(image: image)

            VStack(alignment: .leading) {
                Text(userName)
                    .font(.title2)
                Text(email)
            }
            Spacer()
        }
        .padding(16)
    }
}

#if DEBUG
#Preview {
    ProfileSummaryView(
        userName: "Test Username",
        email: "test@gmail.com",
        image: .link("https://scontent.fbeg7-2.fna.fbcdn.net/v/t39.30808-6/307279357_632405371581769_4617907306119132376_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=5f2048&_nc_ohc=77ZU8hCI0rcAX8jSRIR&_nc_oc=AQkikEyer_PfcDghMFHg5SnQcabM2xl2-r7T9gGX4x_t-nwxeeq7LvH8Vp9Q8ntK5RE&_nc_ht=scontent.fbeg7-2.fna&oh=00_AfBTjYWkTfbOjFXqd6n3VuRMr485NXOzeWU0HSpl-6Bj5w&oe=6534804D")
    )
}
#endif
