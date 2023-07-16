//
//  MeetingTimerView.swift
//  Scrumdinger
//
//  Created by Sara Bee on 2023-07-15.
//

import SwiftUI

struct MeetingTimerView: View {
    let isRecording: Bool
    let speakers: [ScrumTimer.Speaker]
    let theme: Theme

    private var currentSpeaker: String {
        speakers.first(where: { speaker in
            !speaker.isCompleted
        })?.name ?? "Someone"
    }

    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack {
                    Text(currentSpeaker)
                        .font(.title)
                    Text("is speaking")

                    Image(systemName: isRecording ? "mic" : "mic.slash")
                        .font(.title)
                        .padding(.top, 2)
                        .accessibilityLabel(isRecording ? "with transcription" : "without transcription")
                }
            }
            .accessibilityElement(children: .combine)
            .foregroundStyle(theme.accentColor)
            .overlay {
                ForEach(speakers) { speaker in
                    if speaker.isCompleted, let index = speakers.firstIndex(where: { $0.id == speaker.id }) {
                        SpeakerArc(speakerIndex: index, totalSpeakers: speakers.count)
                            .rotation(Angle(degrees: -90))
                            // The stroke modifier traces a line along the path of the shape.
                            .stroke(theme.mainColor, lineWidth: 12)
                    }
                }
            }
            .padding(.horizontal)
    }
}

struct MeetingTimerView_Previews: PreviewProvider {
    static var speakers: [ScrumTimer.Speaker] {
        [
            ScrumTimer.Speaker(name: "Barty", isCompleted: true),
            ScrumTimer.Speaker(name: "Bunny", isCompleted: false),
        ]
    }

    static var previews: some View {
        MeetingTimerView(
            isRecording: true,
            speakers: speakers,
            theme: .bubblegum
        )
    }
}
