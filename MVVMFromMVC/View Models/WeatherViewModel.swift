import Foundation
import UIKit.UIImage

public class WeatherViewModel {
  
  private static let defaultAddress = "Patna, bihar"
  
  private let geocoder = LocationGeocoder()
  
  let locationName = Box("Loading..")
  
  init() {
    changeLocation(to: Self.defaultAddress)
  }
  
  func changeLocation(to newLocation: String){
    locationName.value = "Loading..."
    
    geocoder.geocode(addressString: newLocation) { [weak self] (locations) in
      
      guard let self = self else {
        return
      }
      
      if let location = locations.first {
        self.locationName.value = location.name
        self.fetchWeatherForLocation(location)
        return
      }
    }
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
    }
  }
  
}
