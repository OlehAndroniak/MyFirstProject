//
//  TableViewCell.swift
//  MyTMDB
//
//  Created by Орест Дерзкий on 26.11.2021.
//

import UIKit
import SDWebImage

class TvTableViewCell: UITableViewCell {

    @IBOutlet weak var tvImageView: UIImageView!
    @IBOutlet weak var tvNameLabel: UILabel!
    @IBOutlet weak var tvShadowView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gradientLayer()
    }
    
    private func gradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        tvShadowView.layer.insertSublayer(gradientLayer, at: 0)
        tvShadowView.clipsToBounds = true
    }

    func configureTVWith(_ item: ResultsTV){
        tvNameLabel.text = item.name
        var urlString = ""
        if let backdropPath = item.backdrop_path {
            urlString = Constants.imageURL + backdropPath
            let imageURL = URL(string: urlString)
            tvImageView.sd_setImage(with: imageURL, completed: nil)
        }
    }
}
