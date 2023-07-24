import Foundation

struct WeatherManager {
    let weateherURL = "https://api.openweathermap.org/data/2.5/weather?appid=f469fa17a8fe4e600b3995acacabb1e4&&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weateherURL)&q=\(cityName)"
        print(urlString)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].describtion)
        } catch {
            print(error)
        }
    
    }
}
