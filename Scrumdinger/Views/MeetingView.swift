//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Sara Bee on 2023-07-11.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    
    // Wrapping a property as a @StateObject means MeetingView owns
    // the source of truth for the object. @StateObject ties the
    // ScrumTimer, which is an ObservableObject, to the MeetingView
    // life cycle. In other words, wrapping a reference type property
    // as a @StateObject keeps the object alive for the life cycle
    // of the view.
    @StateObject var scrumTimer = ScrumTimer()

    // This is a computed var; it is equivalent to:
    //
    //      private var player: AVPlayer {
    //          get {
    //              return AVPlayer.sharedDingPlayer
    //          }
    //         }
    private var player: AVPlayer {
        AVPlayer.sharedDingPlayer
    }
    
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

                MeetingTimerView(
                    speakers: scrumTimer.speakers,
                    theme: scrum.theme
                )

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
            startScrum()
        })
        .onDisappear(perform: {
            endScrum()
        })
    }
    
    private func startScrum() {
        // Reset the ScrumTimer each time an instance of
        // MeetingView shows on screen, indicating that
        // a meeting should begin.
        scrumTimer.reset(
            lengthInMinutes: scrum.lengthInMinutes,
            attendees: scrum.attendees
        )
        
        scrumTimer.speakerChangedAction = {
            // Seeking to time .zero ensures that the audio file
            // always plays from the beginning.
            player.seek(to: .zero)
            player.play()
        }
        
        scrumTimer.startScrum()
    }
    
    private func endScrum() {
        // Stop the ScrumTimer each time an instance of MeetingView
        // leaves the screen, indicating that a meeting has ended.
        scrumTimer.stopScrum()
        
        scrum.history.insert(
            History(attendees: scrum.attendees),
            at: 0
        )
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
