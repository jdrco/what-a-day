//
//  ArcView.swift
//  whataday
//
//  Created by Jared Drueco on 2023-12-23.
//

import SwiftUI

struct ArcView: View {
    @ObservedObject var viewModel: ArcViewModel

    var body: some View {
        GeometryReader { proxy in
            let diameter = proxy.size.width
            let reverseRotation = (viewModel.arc.startRange > viewModel.arc.endRange) ? -Double((1 - viewModel.arc.startRange) * 360) : 0
            
            ZStack {
                Circle()
                    .trim(from: viewModel.arc.startRange > viewModel.arc.endRange ? 0 : viewModel.arc.startRange, to: viewModel.arc.endRange + (-reverseRotation / 360))
                    .stroke(viewModel.arc.color, style: StrokeStyle(lineWidth: viewModel.arc.isActive ? 18 : 5))
                    .scaleEffect(viewModel.arc.isActive ? (1 - 12/260) : 1)
                    .rotationEffect(.init(degrees: -90))
                    .rotationEffect(.init(degrees: reverseRotation))
                    .onTapGesture { viewModel.toggleActive() }
                
                if viewModel.arc.isActive {
                    ArcHandlerView(isStart: true, diameter: diameter, viewModel: viewModel, angle: $viewModel.arc.startAngle)
                    ArcHandlerView(isStart: false, diameter: diameter, viewModel: viewModel, angle: $viewModel.arc.endAngle)
                }
            }
        }
        .frame(width: 260, height: 260)
    }
}

#Preview {
    ZStack {
        ArcView(viewModel: ArcViewModel(arc: ArcModel(startAngle: 0, endAngle: 45, startRange: 0, endRange: 0.125, isActive: true, color: .blue)))
    }
}

