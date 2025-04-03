//
//  ViewModelTasks.swift
//  Frostbreak_3
//
//  Created by Jose julian Lopez on 03/04/25.
//

import Foundation
import SwiftUI
import Combine

class ExerciseTimerViewModel: ObservableObject {
    @Published var exercises: [ExerciseTask] = []
    @Published var currentExerciseIndex: Int = 0
    @Published var mainTimeRemaining: Int = 0
    @Published var shortTimeRemaining: Int = 0
    @Published var isTimerRunning: Bool = false
    @Published var showCompletionAlert: Bool = false
    
    private var mainTimer: Timer?
    private var shortTimer: Timer?
    private var cancellables = Set<AnyCancellable>()
    
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
        
        // Main timer for the exercise
        mainTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self, self.mainTimeRemaining > 0 else {
                self?.moveToNextExercise()
                return
            }
            self.mainTimeRemaining -= 1
        }
        
        // 1-minute timer
        shortTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self, self.shortTimeRemaining > 0 else {
                // When the short timer ends, we don't move to next exercise yet
                self?.shortTimeRemaining = 0
                return
            }
            self.shortTimeRemaining -= 1
        }
    }
    
    func stopTimers() {
        mainTimer?.invalidate()
        mainTimer = nil
        shortTimer?.invalidate()
        shortTimer = nil
        isTimerRunning = false
    }
    
    func moveToNextExercise() {
        stopTimers()
        
        if currentExerciseIndex < exercises.count - 1 {
            currentExerciseIndex += 1
            resetTimers()
            startTimers()
        } else {
            // Finished all exercises
            isTimerRunning = false
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
