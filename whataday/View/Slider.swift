//
//  Slider.swift
//  whataday
//
//  Created by Jared Drueco on 2023-12-23.
//

import SwiftUI

struct Slider: View {
    @State var startAngle: Double = 0
    @State var startRange: CGFloat = 0
    @State var endAngle: Double = 180
    @State var endRange: CGFloat = 0.5
    
    var body: some View {
        VStack {
            TimeSlider()
        }
    }
    
    @ViewBuilder
    func TimeSlider() ->some View {
        GeometryReader{ proxy in
            
            let width = proxy.size.width
            
            ZStack {
                Circle() // outline
                    .stroke(.black.opacity(0.06), lineWidth: 40)
                
                let reverseRotation = (startRange > endRange) ? -Double((1 - startRange) * 360) : 0
                Circle() // range
                    .trim(from: startRange > endRange ? 0 : startRange, to: endRange + (-reverseRotation / 360))
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 10))
                    .rotationEffect(.init(degrees: -90))
                    .rotationEffect(.init(degrees: reverseRotation))
                
                Circle() // start
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .rotationEffect(.init(degrees: 90))
                    .rotationEffect(.init(degrees: -startAngle))
                    .offset(x: width / 2)
                    .rotationEffect(.init(degrees: startAngle))
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                onDrag(value: value, isStartSlider: true)
                            })
                    )
                    .rotationEffect(.init(degrees: -90))
                
                Circle() // end
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
                    .rotationEffect(.init(degrees: 90))
                    .rotationEffect(.init(degrees: -endAngle))
                    .offset(x: width / 2)
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
        .frame(width: screenBounds().width/1.6, height: screenBounds().height/1.6)
    }
    
    func onDrag(value: DragGesture.Value, isStartSlider: Bool = false) {
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        let radians = atan2(vector.dy, vector.dx)
        var angle = radians * 180 / .pi
        if angle < 0 { angle = 360 + angle }
        
        let range = angle / 360
        if isStartSlider {
            self.startAngle = angle
            self.startRange = range
        } else {
            self.endAngle = angle
            self.endRange = range
        }
        
    }
}

#Preview {
    Slider()
}

extension View {
    func screenBounds()->CGRect {
        return UIScreen.main.bounds
    }
}
