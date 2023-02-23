//
//  ContentView.swift
//  WeatherApp
//
//  Created by mpc on 10/24/22.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct ContentView: View {
    static let location = CLLocation(latitude: .init(floatLiteral: 39.3111),
                                     longitude: .init(floatLiteral: 94.9225))
    
    @State var weather: Weather?
    
    var body: some View {
        if let weather = weather {
            VStack {
//                ContentView.location.fetchCityAndCountry { city, country, error in
//                    guard let city = city,
//                          let country = country,
//                          error == nil else { return }
//                    print(city + ", " + country)
//                }
                
                Text(weather.currentWeather.temperature.description)
                Text("\(weather.currentWeather.temperature.converted(to: .fahrenheit).formatted().description)")
                Text(weather.currentWeather.condition.description)
                Image(systemName: weather.currentWeather.symbolName)
            }
            .padding()
            
        } else {
            ProgressView()
                .task {
                    await getWeather()
                }
        }
    }

    func getWeather() async {
        do {
            weather = try await Task {
                try await WeatherService.shared.weather(for: ContentView.location)
            }.value
        } catch {
            fatalError("\(error)")
        }
    }
}

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
