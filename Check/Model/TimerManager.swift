//
//  TimerManager.swift
//  Check
//
//  Created by Nixon Pastor on 4/4/22.
//

import Foundation

class TimerManager: ObservableObject {
    @Published var secondsPassed: Int = 0
    
    var timer: Timer = Timer()

    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.secondsPassed += 1
        }
    }

    func stop() {
        timer.invalidate()
        secondsPassed = 0
    }

    func pause() {
        timer.invalidate()
    }
}
