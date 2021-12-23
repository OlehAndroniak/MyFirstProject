import UIKit
import SDWebImage
import youtube_ios_player_helper


class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var overviewMovieLabel: UILabel!
    @IBOutlet weak var airDateLabel: UILabel!
    @IBOutlet weak var saveMovieButton: UIButton!
    @IBOutlet weak var videoView: YTPlayerView!
    
    

    
    var movie: Results? = nil
    var movie2: MovieAndTvUI?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlString = ""
        if let backdropPath = self.movie?.backdrop_path {
            urlString = Constants.imageURL + backdropPath
            let imageURL = URL(string: urlString)
            self.posterImageView.sd_setImage(with: imageURL, completed: nil)
        }
        self.titleMovieLabel.text = movie?.title
        self.overviewMovieLabel.text = movie?.overview
        overviewMovieLabel.numberOfLines = 0
        if let airDate = self.movie?.release_date {
            let fullAirDateLabel = Constants.airDate + airDate
        self.airDateLabel.text = fullAirDateLabel
        }
        
        guard let id = movie?.id else { return }
        NetworkManager().requestVideoDetails(id) { video in
            if let key = video.first?.key {
                    self.videoView.load(withVideoId: key)
            } else {
                self.videoView.isHidden = true
            }
        }
    }
    
    
    @IBAction func movieSavedPressedButton(_ sender: Any) {
        DataManager().saveMovie(movie: self.movie)
        let movieName = movie?.title ?? "Movie"
        let alertMessage = movieName + Constants.added
        let alert = UIAlertController(title: Constants.alertName, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: Constants.alertAction, style: .default, handler: { (action) in
            self.didMove(toParent: MovieDetailsViewController())
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
