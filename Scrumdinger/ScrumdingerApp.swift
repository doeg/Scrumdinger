//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Sara Bee on 2023-07-11.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.sampleData
    
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $scrums)
        }
    }
}
