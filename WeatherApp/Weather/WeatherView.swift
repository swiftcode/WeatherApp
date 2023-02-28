//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Michael Campbell on 2/24/23.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct WeatherView: View {
    @State private var weather: Weather?
    
    let location = CLLocation(latitude: .init(floatLiteral: 39.313015),
                              longitude: .init(floatLiteral:-94.941147))
    
    var body: some View {
        let x = WeatherData()
        Text(verbatim: "x: \(x.currentWeather?.condition)")        
    }
    
    func getWeather() async {
        do {
            weather = try await Task {
                try await WeatherService.shared.weather(for: location)
            }.value
        } catch {
            print("error: \(error)")
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

@MainActor class WeatherData: ObservableObject {
    static let shared = WeatherData()
    let service = WeatherService.shared
    @Published var currentWeather: CurrentWeather?
    
    func updateCurrentWeather(userLocation: CLLocation) {
        Task.detached(priority: .userInitiated) {
            do {
                let forecast = try await self.service.weather(
                    for: userLocation,
                    including: .current)
                DispatchQueue.main.async {
                    print(forecast)
                    self.currentWeather = forecast
                }
            } catch {
                print(error.localizedDescription)
            }
        }
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
        func getIsDaylight() { }
    }
}
