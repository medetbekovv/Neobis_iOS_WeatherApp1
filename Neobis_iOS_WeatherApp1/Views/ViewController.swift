//
//  ViewController.swift
//  Neobis_iOS_WeatherApp1
//
//  Created by user on 27/5/23.
//


import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var weatherViewModel: WeatherViewModelType!
    var weekWeatherViewModel: WeekViewModelType!
    let mainView = MainView()
    
    var weatherModel: Welcome? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                if let viewController = self {
                    viewController.updateUI()
                }
            }
        }
    }
    
    var weekWeatherModel: WeekWelcome? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                if let viewController = self {
                    viewController.updateWeekUI()
                }
            }
        }
    }
    
    init(vm: WeatherViewModelType, vm2: WeekViewModelType) {
            weatherViewModel = vm
            weekWeatherViewModel = vm2
            super.init(nibName: nil, bundle: nil)
        }
    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherViewModelSelf()
        setupViews()
        mainView.searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
    }
    
    func weatherViewModelSelf() {
        weatherViewModel.updateSearch = { [weak self] weather in
            self?.weatherModel = weather
        }
        weekWeatherViewModel.updateWeek = { [weak self] weekWeather in
            self?.weekWeatherModel = weekWeather
        }
        
    }
    
    func setupViews() {
        view.addSubview(mainView)
        
        mainView.snp.makeConstraints{make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func searchTapped() {
        let searchController = SearchController()
        
        searchController.onSearch = { [weak self] cityName in
            // Fetch new weather data when city changes
            self?.weatherViewModel.fetchWeatherData(for: cityName)
            self?.weekWeatherViewModel.fetchWeekWeatherData(for: cityName)
        }
        
        let navController = UINavigationController(rootViewController: searchController)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }

    func updateUI() {
        guard let weatherModel = weatherModel else { return }
        let intTemp: Int = Int(round(weatherModel.main.temp))
        mainView.tempLabel.text = "\(intTemp)°C"
        mainView.cityLabel.text = weatherModel.name
        mainView.countryLabel.text = weatherModel.sys.country
        mainView.windStatusValue.text = "\(Int(weatherModel.wind.speed)) mph"
        mainView.humidityStatusValue.text = "\(weatherModel.main.humidity)%"
        mainView.visibilityStatusValue.text = "\((weatherModel.visibility) / 1760) miles"
        mainView.pressureStatusValue.text = "\(weatherModel.main.pressure) mb"
        
        if let weatherCondition = weatherModel.weather.first?.main.lowercased() {
            mainView.mainImage.image = selectImageForWeather(weatherCondition)
        }
    }
    
    func updateWeekUI() {
        guard let weekModel = weekWeatherModel else { return }
        let day1List = Array(weekModel.list.prefix(8))
        let day1MaxTemp = day1List.reduce(Double.leastNormalMagnitude) { max($0, $1.main.tempMax) }
        mainView.view1.tempLabel.text = "\(Int(round(day1MaxTemp)))°C"
        if let weatherCondition = day1List.first?.weather.first {
            mainView.view1.weatherIcon.image = getImageForWeatherCondition(weatherCondition.main)
        }
        
        if weekModel.list.count >= 16 {
            let day2List = Array(weekModel.list[8..<16])
            let day2MaxTemp = day2List.reduce(Double.leastNormalMagnitude) { max($0, $1.main.tempMax) }
            mainView.view2.tempLabel.text = "\(Int(round(day2MaxTemp)))°C"
            if let weatherCondition = day2List.first?.weather.first {
                mainView.view2.weatherIcon.image = getImageForWeatherCondition(weatherCondition.main)
            }
        }
        
        if weekModel.list.count >= 24 {
            let day3List = Array(weekModel.list[16..<24])
            let day3MaxTemp = day3List.reduce(Double.leastNormalMagnitude) { max($0, $1.main.tempMax) }
            mainView.view3.tempLabel.text = "\(Int(round(day3MaxTemp)))°C"
            if let weatherCondition = day3List.first?.weather.first {
                mainView.view3.weatherIcon.image = getImageForWeatherCondition(weatherCondition.main)
            }
        }

        if weekModel.list.count >= 32 {
            let day4List = Array(weekModel.list[24..<32])
            let day4MaxTemp = day4List.reduce(Double.leastNormalMagnitude) { max($0, $1.main.tempMax) }
            mainView.view4.tempLabel.text = "\(Int(round(day4MaxTemp)))°C"
            if let weatherCondition = day4List.first?.weather.first {
                mainView.view4.weatherIcon.image = getImageForWeatherCondition(weatherCondition.main)
            }
        }

        if weekModel.list.count >= 40 {
            let day5List = Array(weekModel.list[32..<40])
            let day5MaxTemp = day5List.reduce(Double.leastNormalMagnitude) { max($0, $1.main.tempMax) }
            mainView.view5.tempLabel.text = "\(Int(round(day5MaxTemp)))°C"
            if let weatherCondition = day5List.first?.weather.first {
                mainView.view5.weatherIcon.image = getImageForWeatherCondition(weatherCondition.main)
            }
        }
    }
    
    func selectImageForWeather(_ weatherCondition: String) -> UIImage? {
        switch weatherCondition {
        case "clouds":
            return UIImage(named: "cloud")
        case "rain":
            return UIImage(named: "rain")
        case "clear":
            return UIImage(named: "sun")
        case "snow":
            return UIImage(named: "snow")
        default:
            return UIImage(named: "flash")
        }
    }
    
    func getImageForWeatherCondition(_ weatherCondition: weekMainEnum) -> UIImage? {
        switch weatherCondition {
        case .clouds:
            return UIImage(named: "cloud")
        case .clear:
            return UIImage(named: "sun")
        case .rain:
            return UIImage(named: "rain")
        }
    }
}
