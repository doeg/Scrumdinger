//
//  SpeakerArc.swift
//  Scrumdinger
//
//  Created by Sara Bee on 2023-07-15.
//

import SwiftUI

struct SpeakerArc: Shape {
    let speakerIndex: Int
    let totalSpeakers: Int

    private var degreesPerSpeaker: Double {
        360.0 / Double(totalSpeakers)
    }

    private var startAngle: Angle {
        // The additional 1.0 degree is for visual separation between arc segments.
        Angle(degrees: degreesPerSpeaker * Double(speakerIndex) + 1.0)
    }

    private var endAngle: Angle {
        Angle(degrees: startAngle.degrees + degreesPerSpeaker - 1.0)
    }

    func path(in rect: CGRect) -> Path {
        // The coordinate system contains an origin in the lower left corner, with positive values extending up and to the right
        let diameter = min(rect.size.width, rect.size.height) - 24.0
        let radius = diameter / 2.0

        // The CGRect structure supplies two properties that provide the x- and y-coordinates for the center of the rectangle.
        let center = CGPoint(x: rect.midX, y: rect.midY)

        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
    }
}

