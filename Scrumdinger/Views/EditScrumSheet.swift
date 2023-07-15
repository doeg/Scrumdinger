//
//  EditScrumSheet.swift
//  Scrumdinger
//
//  Created by Sara Bee on 2023-07-14.
//

import SwiftUI

struct EditScrumSheet: View {
    @Binding var isPresentingEditView: Bool
    @Binding var scrum: DailyScrum
    
    @State private var editingScrum: DailyScrum
    
    init(isPresentingEditView: Binding<Bool>, scrum: Binding<DailyScrum>) {
        _isPresentingEditView = isPresentingEditView
        _scrum = scrum
        
        _editingScrum = State(initialValue: scrum.wrappedValue)
    }
    
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: $editingScrum)
                .navigationTitle($editingScrum.title)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isPresentingEditView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            isPresentingEditView = false
                            scrum = editingScrum
                        }
                    }
                }
        }
    }
}

struct EditScrumSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditScrumSheet(
            isPresentingEditView: .constant(true),
            scrum: .constant(DailyScrum.sampleData[0])
        )
    }
}
