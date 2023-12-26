//
//  ClockView.swift
//  whataday
//
//  Created by Jared Drueco on 2023-12-23.
//

import SwiftUI

struct ClockView: View {
    let timeMarks = ["12PM", "6PM", "12AM", "6AM"]

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 1)
            ForEach(0..<96) { tick in
                VStack {
                    Rectangle()
                        .fill(tick % 4 == 0 ? Color.black : Color.gray)
                        .opacity(1)
                        .frame(
                            width: tick % 4 == 0 ? 1.5 : 0.6,
                            height: 6)
                    Spacer()
                }
                .rotationEffect(.degrees(Double(tick)/96 * 360))
            }
            ForEach(0..<4) { markIdx in
                VStack {
                    Text(timeMarks[markIdx])
                        .font(.subheadline)
                        .rotationEffect(.degrees(-Double(markIdx)/4) * 360)
                        .foregroundColor(Color.black)
                    Spacer()
                }
                .rotationEffect(.degrees(Double(markIdx)/4) * 360)
            }
            .padding(20)
        }
        .frame(width: 230, height: 230)
        
    }
}

#Preview {
    ClockView()
}
