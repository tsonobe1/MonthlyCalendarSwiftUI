//
//  CustomBackground.swift
//  Calendar
//
//  Created by tsonobe on 2023/10/11.
//

import SwiftUI

// Eventの背景
struct EventBackground: View {
    let color: Color
    var body: some View {
        RoundedRectangle(cornerRadius: 5, style: .circular)
            .fill(color.gradient.opacity(0.6))
            .mask(
                HStack {
                    Rectangle()
                        .frame(width: 5)
                    Spacer()
                }
            )
            .background {
                RoundedRectangle(cornerRadius: 5, style: .circular)
                    .fill(color.gradient.opacity(0.2))
            }
    }
}
