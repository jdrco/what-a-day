//
//  Slider.swift
//  whataday
//
//  Created by Jared Drueco on 2023-12-23.
//

import SwiftUI

struct Slider: View {
    @State var startAngle: Double = 0
    @State var endAngle: Double = 45
    @State var startRange: CGFloat = 0
    @State var endRange: CGFloat = 0.125
    @State var isActive: Bool = true
    @State var color: Color = .blue
    
    var body: some View {
        VStack {
            CircularSlider()
        }
    }
    
    @ViewBuilder
    func CircularSlider() ->some View {
        GeometryReader{ proxy in
            
            let width = proxy.size.width
            
            ZStack {
                let reverseRotation = (startRange > endRange) ? -Double((1 - startRange) * 360) : 0
                
                Circle() // 
                    .trim(from: startRange > endRange ? 0 : startRange, to: endRange + (-reverseRotation / 360))
                    .stroke(color, style: StrokeStyle(lineWidth: isActive ? 18 : 5))
                    .scaleEffect(isActive ? (1 - 12/260) : 1)
                    .rotationEffect(.init(degrees: -90))
                    .rotationEffect(.init(degrees: reverseRotation))
                    .onTapGesture {
                        withAnimation {
                            self.isActive.toggle()
                        }
                    }

                
                if isActive {
                    Dragger(isStart: true, angle: $startAngle)
                        .foregroundColor(.black)
                        .offset(x: width / 2 + 15)
                        .rotationEffect(.init(degrees: startAngle))
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    onDrag(value: value, isStartSlider: true)
                                })
                        )
                        .rotationEffect(.init(degrees: -90))
                    
                    Dragger(isStart: false, angle: $endAngle)
                        .foregroundColor(.black)
                        .offset(x: width / 2 + 15)
                        .rotationEffect(.init(degrees: endAngle))
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    onDrag(value: value, isStartSlider: false)
                                })
                        )
                        .rotationEffect(.init(degrees: -90))
                }
            }
        }
        .frame(width: 260, height: 260)
    }
    
    func onDrag(value: DragGesture.Value, isStartSlider: Bool = false) {
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        let radians = atan2(vector.dy, vector.dx)
        var angle = radians * 180 / .pi
        if angle < 0 { angle = 360 + angle }
        
        // Calculate the closest tick mark angle
        let tickAngle = 360 / 96.0
        let closestTick = round(angle / tickAngle) * tickAngle
        
        if isStartSlider {
            self.startAngle = closestTick
            self.startRange = closestTick / 360
        } else {
            self.endAngle = closestTick
            self.endRange = closestTick / 360
        }
    }
}

#Preview {
    ZStack {
        Clock()
        Slider()
        Slider(startAngle: 90, endAngle: 180, startRange: 0.25, endRange: 0.5, isActive: false, color: .red)
    }
}

