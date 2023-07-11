//
//  TrailingIconLabelStyle.swift
//  Scrumdinger
//
//  Created by Sara Bee on 2023-07-11.
//

import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {
    // The system calls this method for each Label instance in a view
    // hierarchy where this style is the current label style.
    func makeBody(configuration: Configuration) -> some View {
        HStack{
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: Self { Self() }
}
