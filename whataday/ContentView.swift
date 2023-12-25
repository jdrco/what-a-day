//
//  ContentView.swift
//  whataday
//
//  Created by Jared Drueco on 2023-12-23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            ClockView()
            ArcView(viewModel: ArcViewModel())
            ArcView(viewModel: ArcViewModel(arc: ArcModel(startAngle: 90, endAngle: 180, startRange: 0.25, endRange: 0.5, isActive: false, color: .red)))
        }
    }
}

#Preview {
    ContentView()
}
