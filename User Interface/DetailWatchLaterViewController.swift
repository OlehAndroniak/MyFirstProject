import UIKit

class DetailWatchLaterViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie2: MovieAndTvUI?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlString = ""
        if let backdropPath = self.movie2?.backdropPath {
            urlString = Constants.imageURL + backdropPath
            let imageURL = URL(string: urlString)
            self.posterImageView.sd_setImage(with: imageURL, completed: nil)
        }
        self.titleView.text = movie2?.title
        self.overviewLabel.text = movie2?.overview
        overviewLabel.numberOfLines = 0
    }
}
