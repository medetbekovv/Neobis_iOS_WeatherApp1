import UIKit

// MARK: - Welcome
struct WeekWelcome: Codable {
    let cod: String
    let message, cnt: Int
    let list: [WeekList]
    let city: WeekCity
}

// MARK: - City
struct WeekCity: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct WeekCoord: Codable {
    let lat, lon: Double
}

/// MARK: - List
struct WeekList: Codable {
    let dt: Int
    let main: WeekMainClass
    let weather: [WeekWeather]
    let clouds: WeekClouds
    let wind: WeekWind
    let visibility: Int
    let pop: Double
    let sys: WeekSys?
    let dtTxt: String
    let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain
    }
}


// MARK: - Clouds
struct WeekClouds: Codable {
    let all: Int
}

// MARK: - MainClass
struct WeekMainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
typealias Rain = [String: Double]

// MARK: - Sys
struct WeekSys: Codable {
    let pod: Pod
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct WeekWeather: Codable {
    let id: Int
    let main: WeekMainEnum
    let description: WeekDescription
    let icon: String
}

enum WeekDescription: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

enum WeekMainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}



// MARK: - Wind
struct WeekWind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}
