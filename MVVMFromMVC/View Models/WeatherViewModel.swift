import Foundation
import UIKit.UIImage

public class WeatherViewModel {
  
  private static let defaultAddress = "Patna, bihar"
  
  private let geocoder = LocationGeocoder()
  
  let locationName = Box("Loading..")
  let date = Box(" ")
  let icon: Box<UIImage?> = Box(nil)
  let summary = Box(" ")
  let forecastSummary = Box(" ")
  
  private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM d"
    return dateFormatter
  }()
  
  private let tempFormatter: NumberFormatter = {
    let tempFormatter = NumberFormatter()
    tempFormatter.numberStyle = .none
    return tempFormatter
  }()
  
  init() {
    changeLocation(to: Self.defaultAddress)
  }
  
  func changeLocation(to newLocation: String){
    locationName.value = "Loading..."
    
    geocoder.geocode(addressString: newLocation) { [weak self] (locations) in
      
      guard let self = self else {
        return
      }
      
      self.flushApiValues()
      if let location = locations.first {
        self.locationName.value = location.name
        self.fetchWeatherForLocation(location)
        
        return
      }
    }
  }
  
  func flushApiValues(){
    self.locationName.value = "Not Found"
    self.date.value = ""
    self.icon.value = nil
    self.summary.value = ""
    self.forecastSummary.value = ""
  }
  
  private func fetchWeatherForLocation(_ location: Location) {
    WeatherbitService.weatherDataForLocation(
      latitude: location.latitude,
      longitude: location.longitude) { [weak self] (weatherData, error) in
      guard
        let self = self,
        let weatherData = weatherData
      else {
        return
      }
      
      self.date.value = self.dateFormatter.string(from: weatherData.date)
      self.icon.value = UIImage(named: weatherData.iconName)
      let tempFormat = self.tempFormatter.string(from: weatherData.currentTemp as NSNumber) ?? ""
      self.summary.value = "\(weatherData.description) - \(String(describing: tempFormat))°C"
      self.forecastSummary.value = "\nSummary: \(weatherData.description)"
    }
  }
  
}
