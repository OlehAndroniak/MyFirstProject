import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView.clipsToBounds = true
        shadowView.layer.cornerRadius = 30
        shadowView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        moviePosterImageView.clipsToBounds = true
        moviePosterImageView.layer.cornerRadius = 30
        gradientLayer()
    }
    
    private func gradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        shadowView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func configureWith(_ item: Results){
        movieTitleLabel.text = item.title
        var urlString = ""
        if let backdropPath = item.backdrop_path {
            urlString = Constants.imageURL + backdropPath
            let imageURL = URL(string: urlString)
            moviePosterImageView.sd_setImage(with: imageURL, completed: nil)
        }
    }
}

