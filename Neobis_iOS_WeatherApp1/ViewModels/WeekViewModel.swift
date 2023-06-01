//
//  WeekViewModel.swift
//  Neobis_iOS_WeatherApp1
//
//  Created by user on 27/5/23.
//



import Foundation
import UIKit

protocol WeekViewModelType {
    var updateWeek: ((WeekWelcome) -> ())? { get set}
    func fetchWeekWeatherData(for cityName: String)
}

class WeekViewModel: WeekViewModelType {
    
    private var weekWeatherService: WeatherService!
    private var weekWeatherData : WeekWelcome?
    
    
    var updateWeek: ((WeekWelcome) -> ())?
    
    init() {
        self.weekWeatherService = WeatherService()
        fetchWeekWeatherData(for: "London")
    }
    
    func fetchWeekWeatherData(for cityName: String) {
        weekWeatherService.fetchWeekWeather(for : cityName) { (weekWeatherData) in
            self.weekWeatherData = weekWeatherData
            self.updateWeek?(weekWeatherData)
        }
    }
}
