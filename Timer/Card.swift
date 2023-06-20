//
//  Card.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-19.
//

import SwiftUI

struct Card: View {
    var body: some View {
        
        Color.cyan
            .cornerRadius(16)
            .padding()
            .aspectRatio(2, contentMode: .fill)
            .opacity(0.7)
            .shadow(color: .gray, radius: 3, x: 3, y: 5)
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card()
    }
}
