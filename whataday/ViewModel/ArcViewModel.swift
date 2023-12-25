//
//  ArcViewModel.swift
//  whataday
//
//  Created by Jared Drueco on 2023-12-24.
//

import Foundation
import SwiftUI

class ArcViewModel: ObservableObject {
    @Published var arc: ArcModel
    
    init(arc: ArcModel = ArcModel(startAngle: 0, endAngle: 45, startRange: 0, endRange: 0.125, isActive: true, color: .blue)) {
        self.arc = arc
    }

    func toggleActive() {
        withAnimation {
            arc.isActive.toggle()
        }
    }

    func onDrag(value: DragGesture.Value, isStartHandler: Bool) {
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        let radians = atan2(vector.dy, vector.dx)
        var angle = radians * 180 / .pi
        if angle < 0 { angle = 360 + angle }
        
        let tickAngle = 360 / 96.0
        let closestTick = round(angle / tickAngle) * tickAngle
        
        if isStartHandler {
            arc.startAngle = closestTick
            arc.startRange = closestTick / 360
        } else {
            arc.endAngle = closestTick
            arc.endRange = closestTick / 360
        }
    }
}

