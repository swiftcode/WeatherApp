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
    static let location = CLLocation(latitude: .init(floatLiteral: 39.313015),
                                     longitude: .init(floatLiteral:-94.941147))
    
    @State var weather: Weather?
    
    var body: some View {

        ZStack { EmptyView() }
          .background(
             Image("clouds")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
          )
        
        if let weather = weather {
            let celcius = weather.currentWeather.temperature.converted(to: .celsius).value
            let fahrenheit = weather.currentWeather.temperature.converted(to: .fahrenheit).value
                        
            let c = celcius.round()
            let f = fahrenheit.round()
            
            HudView {
                Text("Leavenworth, KS")
                    .font(.largeTitle)
            }
            
            HudView {
                VStack {
                    Text(verbatim: "\(c)")
                    Text(verbatim: "\(f)")
                    Text(weather.currentWeather.condition.description)
                    Image(systemName: weather.currentWeather.symbolName)
                }
                .padding()
            }
        } else {
          ProgressView()
            .task { await getWeather() }
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

extension Double {
    func round() -> String {
        return String(format: "%.0f", self)
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
