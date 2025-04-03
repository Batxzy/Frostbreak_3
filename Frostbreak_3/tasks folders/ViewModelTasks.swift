//
//  ViewModelTasks.swift
//  Frostbreak_3
//
//  Created by Jose julian Lopez on 03/04/25.
//

import Foundation
import SwiftUI
import Combine
import Observation

@Observable
class ExerciseTimerViewModel {
    var exercises: [ExerciseTask] = []
    var currentExerciseIndex: Int = 0
    var mainTimeRemaining: Int = 660 // 11 minutes total (fixed)
    var shortTimeRemaining: Int = 60 // 1 minute per task
    var isTimerRunning: Bool = false
    var isPaused: Bool = false
    var hasStarted: Bool = false
    var showCompletionAlert: Bool = false
    
    private var timerPublisher: AnyCancellable?
    
    init() {
        setupExercises()
    }
    
    private func setupExercises() {
        exercises = [
            ExerciseTask(title: "Veo veo", timeInSeconds: 660, instructions: "Mira a lo lejos. Enfoca en un objeto distante por 20 segundos, luego cerca por 20 segundos.", type: .visualRest),
            ExerciseTask(title: "20/20/20", timeInSeconds: 60, instructions: "Mira algo a 20 pies (6 metros) durante 20 segundos, cada 20 minutos.", type: .visualRest),
            ExerciseTask(title: "Parpadeo", timeInSeconds: 45, instructions: "Parpadea rápidamente durante 15 segundos, descansa 5 segundos y repite.", type: .visualRest),
            ExerciseTask(title: "Círculos oculares", timeInSeconds: 30, instructions: "Rota los ojos suavemente en círculos, en ambas direcciones.", type: .visualRest),
            ExerciseTask(title: "Estiramiento de cuello", timeInSeconds: 45, instructions: "Inclina la cabeza hacia adelante y a los lados suavemente.", type: .stretch),
            ExerciseTask(title: "Estiramiento de hombros", timeInSeconds: 30, instructions: "Rota los hombros hacia atrás y adelante 10 veces cada dirección.", type: .stretch),
            ExerciseTask(title: "Palmas calientes", timeInSeconds: 30, instructions: "Frota las palmas hasta calentarlas y colócalas sobre los ojos cerrados.", type: .visualRest),
        ]
        
        resetTimers()
    }
    
    func resetTimers() {
        // Reset only the short timer, main timer remains continuous
        shortTimeRemaining = 60 // 1 minute per task
    }
    
    func startTimers() {
        stopTimers()
        isTimerRunning = true
        hasStarted = true
        isPaused = false
        
        // Use a single timer for both countdowns
        timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                // Update both timers
                if self.mainTimeRemaining > 0 {
                    self.mainTimeRemaining -= 1
                }
                
                if self.shortTimeRemaining > 0 {
                    self.shortTimeRemaining -= 1
                } else {
                    self.moveToNextExercise()
                }
                
                // Check if overall session is complete
                if self.mainTimeRemaining <= 0 {
                    self.completeSession()
                }
            }
    }
    
    private func completeSession() {
        timerPublisher?.cancel()
        timerPublisher = nil
        hasStarted = false
        isPaused = false
        showCompletionAlert = true
    }
    
    func pauseTimers() {
        timerPublisher?.cancel()
        timerPublisher = nil
        isPaused = true
        isTimerRunning = false
    }
    
    func resumeTimers() {
        if isPaused {
            startTimers()
        }
    }
    
    func stopTimers() {
        timerPublisher?.cancel()
        timerPublisher = nil
        isTimerRunning = false
    }
    
    func moveToNextExercise() {
        if currentExerciseIndex < exercises.count - 1 {
            currentExerciseIndex += 1
            resetTimers() // Only reset the short timer
        } else {
            completeSession()
        }
    }
    
    var currentExercise: ExerciseTask {
        exercises[currentExerciseIndex]
    }
    
    var nextExercise: ExerciseTask? {
        if currentExerciseIndex < exercises.count - 1 {
            return exercises[currentExerciseIndex + 1]
        }
        return nil
    }
    
    // Formatted times for UI
    var mainTimeString: String {
        return formattedTime(mainTimeRemaining)
    }
    
    var shortTimeString: String {
        return formattedTime(shortTimeRemaining)
    }
    
    private func formattedTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%d:%02d", minutes, remainingSeconds)
    }
}
