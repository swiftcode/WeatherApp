//
//  HudView.swift
//  WeatherApp
//
//  Created by Michael Campbell on 2/23/23.
//

import SwiftUI

struct HudView<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        content
            .padding(.horizontal, 12)
            .padding(16)
            .foregroundColor(Color.white)
            .background(
                RoundedRectangle(cornerRadius: 10.0)
                    .foregroundColor(Color("HudBlue"))
                    .opacity(0.70)
                    .shadow(color: Color(.black).opacity(0.50), radius: 5, x: 0, y: 5))
    }
}

struct HudView_Previews: PreviewProvider {
    static var previews: some View {
        
        HudView {
            VStack {
                Text("This is one line")
                Text("This is another line")
            }
        }
    }
}
