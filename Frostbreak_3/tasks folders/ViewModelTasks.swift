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
    var mainTimeRemaining: Int = 0
    var shortTimeRemaining: Int = 0
    var isTimerRunning: Bool = false
    var isPaused: Bool = false
    var hasStarted: Bool = false
    var showCompletionAlert: Bool = false
    
    private var mainTimerPublisher: AnyCancellable?
    private var shortTimerPublisher: AnyCancellable?
    
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
        if currentExerciseIndex < exercises.count {
            mainTimeRemaining = exercises[currentExerciseIndex].timeInSeconds
            shortTimeRemaining = 60 // 1 minute transition timer
        }
    }
    
    func startTimers() {
        stopTimers()
        isTimerRunning = true
        hasStarted = true
        isPaused = false
        
        // Using DispatchQueue for better UI updates
        mainTimerPublisher = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                if self.mainTimeRemaining > 0 {
                    self.mainTimeRemaining -= 1
                } else {
                    self.moveToNextExercise()
                }
            }
        
        shortTimerPublisher = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                if self.shortTimeRemaining > 0 {
                    self.shortTimeRemaining -= 1
                }
            }
    }
    
    func pauseTimers() {
        stopTimers()
        isPaused = true
        isTimerRunning = false
    }
    
    func resumeTimers() {
        if isPaused {
            startTimers()
        }
    }
    
    func stopTimers() {
        mainTimerPublisher?.cancel()
        mainTimerPublisher = nil
        shortTimerPublisher?.cancel()
        shortTimerPublisher = nil
        isTimerRunning = false
    }
    
    func moveToNextExercise() {
        // Don't call stopTimers(), just pause temporarily
        isTimerRunning = false
        
        if currentExerciseIndex < exercises.count - 1 {
            currentExerciseIndex += 1
            resetTimers()
            // Resume the timers instead of recreating them
            isTimerRunning = true
        } else {
            // Finished all exercises
            mainTimerPublisher?.cancel()
            shortTimerPublisher?.cancel()
            mainTimerPublisher = nil
            shortTimerPublisher = nil
            hasStarted = false
            isPaused = false
            showCompletionAlert = true
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
