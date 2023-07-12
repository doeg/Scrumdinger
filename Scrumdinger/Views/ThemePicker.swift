//
//  ThemePicker.swift
//  Scrumdinger
//
//  Created by Sara Bee on 2023-07-12.
//

import SwiftUI

struct ThemePicker: View {
    // References a theme structure defined in the parent view
    @Binding var selection: Theme
    
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
        .pickerStyle(.navigationLink)
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        // .constant creates a binding to a hard-coded, immutable value
        ThemePicker(selection: .constant(.periwinkle))
    }
}
