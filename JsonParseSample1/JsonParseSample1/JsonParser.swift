
let json = "{ \"temp\": -7, \"feels_like\": -11, \"temp_water\": 0, \"icon\": \"ovc\", \"condition\": \"overcast\", \"cloudness\": 1, \"wind_speed\": 1, \"wind_dir\": \"w\", \"humidity\": 87, \"season\": \"winter\" }"

import Foundation

enum WeatherCondition {
    case clear
}

extension Fact {
    func conditionLocalized() -> String {
        switch self.condition {
        case "clear":
            return "Ясно"
        case "partly-cloudy":
            return "Малооблачно"
        case "cloudy":
            return "Облачно с прояснениями"
        case "overcast":
            return "Пасмурно"
        case "drizzle":
            return "Морось"
        case "light-rain":
            return "Небольшой дождь"
        case "rain":
            return "Дождь"
        case "moderate-rain":
            return "Умеренно сильный дождь"
        case "heavy-rain":
            return "Сильный дождь"
        case "continuous-heavy-rain":
            return "Длительный сильный дождь"
        case "showers":
            return "Ливень"
        case "wet-snow ":
            return "Дождь со сгнегом"
        case "light-snow":
            return "Небольшой снег"
        case "snow":
            return "Снег"
        case "snow-showers":
            return "Снегопад"
        case "hail":
            return "Град"
        case "thunderstorm":
            return "Гроза"
        case "thunderstorm-with-rain":
            return "Дождь с грозой"
        case "thunderstorm-with-hail":
            return "Гроза с градом"
        default:
            print("Неизвестное условие погоды")
            fatalError("Неизвестное условие погоды")
        }
    }
}

struct Fact : Codable {
    let temp: Int
    let feelsLike: Int
    let condition: String
    
    let icon: String
    let windSpeed: Double
    let windDirection: String
    let humidity: Int
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case condition = "condition"
        case icon
        case windSpeed = "wind_speed"
        case windDirection = "wind_dir"
        case humidity
    }
}

final class JsonParser {
    static func parse() {
        let jsonDecoder = JSONDecoder()
        
        let aaa = try! jsonDecoder.decode(Fact.self, from: Data(json.utf8))
        print(aaa)
        print(aaa.conditionLocalized())
    }
}
