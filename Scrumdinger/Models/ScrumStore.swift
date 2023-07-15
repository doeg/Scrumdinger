//
//  ScrumStore.swift
//  Scrumdinger
//
//  Created by Sara Bee on 2023-07-15.
//

import SwiftUI

@MainActor
class ScrumStore: ObservableObject {
    @Published var scrums: [DailyScrum] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        ).appendingPathComponent("scrums.data")
    }
    
    func load() async throws {
        // "task" is stored as a constant (with "let") so that later
        // we can access values returned or catch errors thrown from the task
        let task = Task<[DailyScrum], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }

            // In Swift, when you use .self with a type name, it represents
            // the metatype value of that type. A metatype value is an instance
            // of the metatype type, which represents the type itself.
            let dailyScrums = try JSONDecoder().decode([DailyScrum].self, from: data)
            return dailyScrums
        }
        
        // The class must be marked as @MainActor so that it is safe to
        // update the published "scrums" property from the asynchronous
        // load() method. (Not doing so doesn't indicate a compiler error though...?)
        let scrums = try await task.value
        self.scrums = scrums
    }
    
    func save(scrums: [DailyScrum]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(scrums)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        
        _ = try await task.value
    }
}
