//
//  TasksView.swift
//  Frostbreak_3
//
//  Created by Jose julian Lopez on 03/04/25.
//
import SwiftUI


struct ExerciseTimerView2: View {
    @State private var viewModel = ExerciseTimerViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var soundOn = true
    @Binding var tabSelection: Int
    
    // For preview only
    init(tabSelection: Binding<Int>? = nil) {
        self._tabSelection = tabSelection ?? Binding.constant(0)
    }
    
    var body: some View {
        ZStack {
            // Background image
            Image("HOME")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            
            // Main content
            VStack(spacing: 26) {
                // Header section
                HeaderSection(
                    viewModel: viewModel,
                    dismiss: dismiss,
                    soundOn: $soundOn
                )
                
                // Exercise content area
                ExerciseContentSection(viewModel: viewModel)
                
                // Control buttons
                ControlButtonsSection(viewModel: viewModel)
            }
            .padding(.horizontal, 24)
        }
        .navigationBarBackButtonHidden(true)
        .alert("¡Ejercicios completados!", isPresented: $viewModel.showCompletionAlert) {
            Button("OK") {
                dismiss()
                tabSelection = 0 // Ensure we return to home tab
            }
        } message: {
            Text("Has completado todos los ejercicios de descanso visual y estiramientos.")
        }
        .onAppear(perform: viewModel.startTimers)
    }
}

// MARK: - Header Section
struct HeaderSection: View {
    let viewModel: ExerciseTimerViewModel
    var dismiss: DismissAction
    @Binding var soundOn: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: -18) {
            // Controls row
            HStack {
                Button(action: {
                    viewModel.stopTimers()
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 24))
                        .foregroundColor(.white.opacity(0.70))
                }
                
                Spacer()
                
                Button(action: {
                    soundOn.toggle()
                }) {
                    Image(systemName: soundOn ? "speaker.wave.2" : "speaker.slash")
                        .font(.system(size: 24))
                        .foregroundColor(.white.opacity(0.70))
                }
            }
            
            VStack(alignment: .center, spacing: 16) {
                // Main timer display
                VStack(alignment: .center) {
                    Text(viewModel.mainTimeString)
                        .font(.largeTitle).bold()
                }
                .padding(0)
                .frame(width: 204, height: 86, alignment: .center)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.02, green: 0.73, blue: 0.74), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.01, green: 0.1, blue: 0.34), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.72, y: -0.64),
                        endPoint: UnitPoint(x: 0.72, y: 2.07)
                    ).opacity(0.37)
                )
                .cornerRadius(60)
                .overlay(
                    RoundedRectangle(cornerRadius: 60)
                        .inset(by: 1)
                        .stroke(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.04, green: 0.04, blue: 0.04), location: 0.00),
                                    Gradient.Stop(color: .white, location: 1.00),
                                ],
                                startPoint: UnitPoint(x: -0.57, y: 0.5),
                                endPoint: UnitPoint(x: 1.68, y: 0.5)
                            ).opacity(0.3).blendMode(.plusLighter),
                            lineWidth: 2
                        )
                )
                
                // Progress dots
                HStack(spacing: 10) {
                    ForEach(0..<viewModel.exercises.count, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 6)
                            .fill(index == viewModel.currentExerciseIndex ? Color.white : Color.gray)
                            .frame(width: 8, height: 8)
                    }
                }
                .frame(height: 24)
                .padding(.horizontal, 10)
                .background(Material.thick)
                .cornerRadius(25)
                
                // Next exercise text
                if let nextExercise = viewModel.nextExercise {
                    Text("Siguiente ejercicio: \(nextExercise.title)")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                } else {
                    Text("Último ejercicio")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .top)
        .background(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
        .cornerRadius(37)
        .overlay(
            RoundedRectangle(cornerRadius: 37)
                .inset(by: 0.5)
                .stroke(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.04, green: 0.04, blue: 0.04), location: 0.00),
                            Gradient.Stop(color: .white, location: 1.00),
                        ],
                        startPoint: UnitPoint(x: -0.57, y: 0.5),
                        endPoint: UnitPoint(x: 1.68, y: 0.5)
                    ).opacity(0.3).blendMode(.plusLighter),
                    lineWidth: 2
                )
        )
    }
}

// MARK: - Exercise Content Section
struct ExerciseContentSection: View {
    let viewModel: ExerciseTimerViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            // Title
            Text(viewModel.currentExercise.title)
                .font(.largeTitle)
            
            // Exercise type badge
            HStack {
                Text(viewModel.currentExercise.type == .visualRest ? "Descanso Visual" : "Estiramiento")
                    .font(.caption)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(
                        viewModel.currentExercise.type == .visualRest ?
                            Color.blue.opacity(0.3) : Color.green.opacity(0.3)
                    )
                    .cornerRadius(10)
                
                Spacer()
            }
            
            Spacer()
            
            // Instructions
            Text(viewModel.currentExercise.instructions)
                .font(.body)
                .padding(.vertical)
            
            Spacer()
            
            // 1 minute timer
            HStack {
                Spacer()
                VStack(alignment: .center, spacing: 10) {
                    Text(viewModel.shortTimeString)
                        .font(.system(size: 22, weight: .bold))
                }
                .padding(10)
                .frame(width: 129, alignment: .center)
                .background(Color(red: 0.23, green: 0.23, blue: 0.23))
                .cornerRadius(50)
                Spacer()
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, minHeight: 377, maxHeight: 377, alignment: .leading)
        .background(.black)
        .cornerRadius(14)
    }
}

// MARK: - Control Buttons Section
struct ControlButtonsSection: View {
    let viewModel: ExerciseTimerViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            // Pause/Resume button
            Button(action: {
                if viewModel.isTimerRunning {
                    viewModel.pauseTimers()
                } else if viewModel.isPaused {
                    viewModel.resumeTimers()
                }
            }) {
                Image(systemName: viewModel.isTimerRunning ? "pause.circle.fill" : "play.circle.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
            }
            .disabled(!viewModel.hasStarted)
            .opacity(viewModel.hasStarted ? 1.0 : 0.5)
            
            // Start/Next button
            Button(action: {
                if !viewModel.hasStarted {
                    viewModel.startTimers()
                } else {
                    viewModel.moveToNextExercise()
                }
            }) {
                Text(viewModel.hasStarted ? "Siguiente" : "Comenzar")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.black)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 40)
                    .background(
                        Capsule()
                            .fill(Color.white)
                    )
            }
        }
    }
}

#Preview {
    ExerciseTimerView2()
}
