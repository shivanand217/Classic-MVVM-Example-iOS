import UIKit

class WeatherViewController: UIViewController {
  
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var currentIcon: UIImageView!
  @IBOutlet weak var currentSummaryLabel: UILabel!
  @IBOutlet weak var forecastSummary: UITextView!
  
  private let viewModel = WeatherViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadViewModel()
  }
  
  func loadViewModel(){
    viewModel.locationName.bind { [weak self] (locationName) in
      self?.cityLabel.text = locationName
    }
    
    viewModel.date.bind { [weak self] (date) in
      self?.dateLabel.text = date
    }
    
    viewModel.icon.bind { [weak self] (image) in
      self?.currentIcon.image = image
    }
    
    viewModel.summary.bind { [weak self] (summary) in
      self?.currentSummaryLabel.text = summary
    }
    
    viewModel.forecastSummary.bind { [weak self] (fSummary) in
      self?.forecastSummary.text = fSummary
    }
  }
}
