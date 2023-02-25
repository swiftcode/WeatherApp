//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Michael Campbell on 2/24/23.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

extension WeatherView {
    @MainActor final class ViewModel: Identifiable, ObservableObject {
        func getTemperature() { }
        func getCondition() { }
        func getPrecipitation() { }
        func getPressure() { }
        func getUVIndex() { }
        func getWind() { }
        func getHumidity() { }
        func getDate() { }
        func getCloudCover() { }
        func getVisibility() { }
        func getSymbolName() { }        
    }
}
