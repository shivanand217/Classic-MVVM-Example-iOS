
import Foundation
import XCTest

@testable import Grados

class WeatherViewModelTests: XCTestCase {

  func testChangeLocationUpdatesLocation(){
    
    let expectation = self.expectation(description: "Find location using geocoder.")
    
    let viewModel = WeatherViewModel()
    
    viewModel.locationName.bind {
      if $0.caseInsensitiveCompare("Richmond, VA") == .orderedSame{
        expectation.fulfill()
      }
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now()+2) {
      viewModel.changeLocation(to: "Richmond, VA")
    }
    waitForExpectations(timeout: 8, handler: nil)
  }

}
