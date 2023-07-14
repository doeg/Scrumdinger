//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Sara Bee on 2023-07-11.
//

import SwiftUI

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    
    // Wrapping a property as a @StateObject means MeetingView owns
    // the source of truth for the object. @StateObject ties the
    // ScrumTimer, which is an ObservableObject, to the MeetingView
    // life cycle.
    @StateObject var scrumTimer = ScrumTimer()
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            
            VStack {
                MeetingHeaderView(
                    secondsElapsed: scrumTimer.secondsElapsed,
                    secondsRemaining: scrumTimer.secondsRemaining,
                    theme: scrum.theme
                )
                
                Circle()
                    .strokeBorder(lineWidth: 24)
                
                HStack {
                    Text("Speaker 1 of 3")
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                }
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            // Reset the ScrumTimer each time an instance of
            // MeetingView shows on screen, indicating that
            // a meeting should begin.
            scrumTimer.reset(
                lengthInMinutes: scrum.lengthInMinutes,
                attendees: scrum.attendees
            )
            scrumTimer.startScrum()
        })
        .onDisappear(perform: {
            // Stop the ScrumTimer each time an instance of MeetingView
            // leaves the screen, indicating that a meeting has ended.
            scrumTimer.stopScrum()
        })
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
