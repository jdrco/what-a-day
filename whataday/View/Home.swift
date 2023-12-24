//
//  Home.swift
//  whataday
//
//  Created by Jared Drueco on 2023-12-23.
//

import SwiftUI

struct Home: View {
    var body: some View {
        ZStack {
            Clock()
            Slider()
            Slider(startAngle: 90, endAngle: 180, startRange: 0.25, endRange: 0.5, isActive: false, color: .red)
        }
    }
}

#Preview {
    Home()
}
