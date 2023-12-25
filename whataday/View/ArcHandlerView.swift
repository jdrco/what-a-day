//
//  ArcHandlerView.swift
//  whataday
//
//  Created by Jared Drueco on 2023-12-23.
//

import SwiftUI

struct ArcHandlerView: View {
    @State var isStart: Bool
    @Binding var angle: Double
    var body: some View {
        HStack(spacing: 0) {
            Line()
                .stroke(style: .init(lineWidth: 1, dash: [2.5]))
                .foregroundStyle(.black)
                .frame(height: 1)
            ZStack {
                Circle()
                    .stroke(.black, lineWidth: 1)
                    .frame(width: 24, height: 24)
                Text(isStart ? "α" : "ω")
                    .font(.system(size: 20))
                    .padding(.bottom, 2)
            }
            .rotationEffect(.init(degrees: 90))
            .rotationEffect(.init(degrees: -angle))
            .padding(.bottom, 2)
        }
        .frame(width: 60, height: 2)
        .foregroundColor(.black)
    }
}

struct Line:Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

#Preview {
    VStack {
        Spacer()
        ArcHandlerView(isStart: true, angle: .constant(90))
        Spacer()
        ArcHandlerView(isStart: false, angle: .constant(90))
        Spacer()
    }
}
