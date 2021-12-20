import UIKit



class WatchLaterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
 
    var movies: [MovieAndTvUI] = []
    var movie: Results?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let cellNib = UINib(nibName: "WatchLaterTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "WatchLaterTableViewCell")
        movies = DataManager().getMovies()
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        title = "The Movie Database"
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    

}

// MARK: - DataSource, Delegate

extension WatchLaterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = movies[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: Constants.mainStoryboard, bundle: nil)
            let movie = movies[indexPath.row]
            if let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailWatchLaterViewController") as? DetailWatchLaterViewController {
                detailsViewController.movie2 = movie
                navigationController?.pushViewController(detailsViewController, animated: true)
            }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataManager().deleteMovie(id: movies[indexPath.row].id, completion: {
                self.movies = DataManager().getMovies()
                tableView.reloadData()
            })
        }
    }
}


