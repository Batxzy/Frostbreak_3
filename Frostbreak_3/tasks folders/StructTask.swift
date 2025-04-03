//
//  StructTask.swift
//  Frostbreak_3
//
//  Created by Jose julian Lopez on 03/04/25.
//

import SwiftUI

struct ExerciseTask: Identifiable {
    let id = UUID()
    let title: String
    let timeInSeconds: Int
    let instructions: String
    let type: ExerciseType
    
    enum ExerciseType {
        case visualRest
        case stretch
    }
    
    // Formatted time string (e.g., "11:00" or "1:00")
    var formattedTime: String {
        let minutes = timeInSeconds / 60
        let seconds = timeInSeconds % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

