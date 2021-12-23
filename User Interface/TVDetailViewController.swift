import UIKit
import SDWebImage


class TVDetailViewController: UIViewController {
    
    @IBOutlet weak var tvPosterImageView: UIImageView!
    @IBOutlet weak var titleTVLabel: UILabel!
    @IBOutlet weak var tvOverviewLabel: UILabel! 
    @IBOutlet weak var tvAirDateLabel: UILabel!
    @IBOutlet weak var imageRating: UIImageView!
    @IBOutlet weak var tvRatingLabel: UILabel!
    
    
    
    var tv: ResultsTV?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlString = ""
        if let backdropPath = self.tv?.backdrop_path {
            urlString = Constants.imageURL + backdropPath
            let imageURL = URL(string: urlString)
            self.tvPosterImageView.sd_setImage(with: imageURL, completed: nil)
        }
        
        self.titleTVLabel.text = tv?.name
        self.tvOverviewLabel.text = tv?.overview

        self.tvOverviewLabel.numberOfLines = 0
        
        if let doubleRating = tv?.vote_average {
            self.tvRatingLabel.text = String(describing: doubleRating)
        }
       
        let imageRatingVar = Constants.imageRating
        imageRating.image = UIImage(named: imageRatingVar)
        if let tvAirDate = self.tv?.first_air_date {
            let tvFullAirDateLabel = Constants.airDate + tvAirDate
        self.tvAirDateLabel.text = tvFullAirDateLabel
        }
    }
    
    @IBAction func savedTVdidPressedButton(_ sender: Any) {
        DataManagerTV().saveTV(tv: self.tv!)
        let tvName = tv?.name ?? "TV Show"
        let alertMessage = tvName + Constants.added
        let alert = UIAlertController(title: Constants.alertName, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: Constants.alertAction, style: .default, handler: { (action) in
            self.didMove(toParent: TVDetailViewController())
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
