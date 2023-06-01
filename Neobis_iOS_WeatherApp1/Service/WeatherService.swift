//
//  WeatherService.swift
//  Neobis_iOS_WeatherApp1
//
//  Created by user on 26/5/23.
//

import Foundation


class WeatherService {
    
    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=London&appid=d082522b3afe9b359032ed4b0119d10a&units=metric")
    
    
 
    func fetchWeather(for cityName: String, completion: @escaping (Welcome) -> ()) {
        let baseUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=d082522b3afe9b359032ed4b0119d10a&units=metric")
        URLSession.shared.dataTask(with: baseUrl!) { (data, response, error) in
            if let error = error {
                print("Data Task Error: \(error.localizedDescription)")
                return
            }
            guard let data = data else { return }
            print("Success reponse: \(data)")

            do {
                let weather = try JSONDecoder().decode(Welcome  .self, from: data)
                completion(weather)
                print("Success reponse 2: \(data)")
            } catch {
                print("falied to convert \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func fetchWeekWeather(for cityName: String, completion: @escaping (WeekWelcome) -> ()) {
        let baseWeekUrl = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=d082522b3afe9b359032ed4b0119d10a&units=metric")
        URLSession.shared.dataTask(with: baseWeekUrl!) { (data, response, error) in
            if let error = error {
                print("Data Task Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let weather = try JSONDecoder().decode(WeekWelcome  .self, from: data)
                completion(weather)
            } catch {
                print("falied to convert week \(error.localizedDescription)")
            }
        }.resume()
    }
}
