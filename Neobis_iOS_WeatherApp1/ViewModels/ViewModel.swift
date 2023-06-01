//
//  ViewModel.swift
//  Neobis_iOS_WeatherApp1
//
//  Created by user on 27/5/23.
//



import Foundation
import UIKit

protocol WeatherViewModelType {
    
    var didTapSearch: (() -> ())? { get set }
    var updateSearch: ((Welcome) -> ())? { get set }
    func fetchWeatherData(for cityName: String)
}

class WeatherViewModel: WeatherViewModelType {
    
    private var weatherService: WeatherService!
    private(set) var weatherData : Welcome?
  
    
    
    private var weekWeatherService: WeatherService!
    private(set) var weekWeatherData : WeekWelcome?
    
    
    
    var updateSearch: ((Welcome) -> ())?
    
    var updateWeek: ((WeekWelcome) -> ())?

    lazy var didTapSearch: (() -> ())? = { [weak self] in
//        self?.updateSearch?(self?.weatherData ?? Weather(main: Main(temp: 2.0)))
    }
    
    init() {
        self.weatherService = WeatherService()
        self.weekWeatherService = WeatherService()
        fetchWeatherData(for: "London")
        fetchWeekWeatherData(for: "London")
    }
    
    func fetchWeatherData(for cityName: String) {
        weatherService.fetchWeather(for: cityName) { (weatherData) in
            self.weatherData = weatherData
            self.updateSearch?(weatherData)
        }
    }
    
    func fetchWeekWeatherData(for cityName: String) {
        weekWeatherService.fetchWeekWeather(for : cityName) { (weekWeatherData) in
            self.weekWeatherData = weekWeatherData
            self.updateWeek?(weekWeatherData)
        }
    }
}
