import UIKit

enum SelectedPage: Int {
    case movies
    case tvShows
}

class TrendingMoviesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectedSegment: UISegmentedControl!
    
    var selectedPage: SelectedPage = .movies
    
    var moviesList: [Results] = []
    var tvList: [ResultsTV] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupData()
    }
    
    private func setupUI() {
        tableView.register(nibWithCellClass: TableViewCell.self, in: nil)
        tableView.register(nibWithCellClass: TvTableViewCell.self, in: nil)
        self.tableView.delegate = self
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableView.setContentOffset(CGPoint(x: 0, y: 80), animated: true)
        self.tableView.tableFooterView = UIView()
    }
    
    private func setupData() {
        NetworkManager.shared.requestTrendingMovies(completion: { moviesList in
            self.moviesList = moviesList
            self.tableView.reloadData()
        })
        
        NetworkManagerTV.shared.requestTrendingTV(completion: { tvList in
            self.tvList = tvList
        })
    }
    
    // MARK: - Actions
    
    @IBAction func segmentControllDidPressed(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        selectedPage = SelectedPage(rawValue: selectedIndex) ?? .movies
        switch selectedPage {
        case .movies:
            tableView.reloadData()
        case .tvShows:
            tableView.reloadData()
        }
    }
}

extension TrendingMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedSegment.selectedSegmentIndex {
        case 0:
            return moviesList.count
        case 1:
            return tvList.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch selectedSegment.selectedSegmentIndex {
        case 0:
            let cell = tableView.dequeueReusableCell(withClass: TableViewCell.self)
            cell.configureWith(moviesList[indexPath.row])
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withClass: TvTableViewCell.self)
            cell.configureTVWith(tvList[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        240
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: Constants.mainStoryboard, bundle: nil)
        switch selectedSegment.selectedSegmentIndex {
        case 0:
            let movie = moviesList[indexPath.row]
            if let detailsViewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController {
                detailsViewController.movie = movie
                navigationController?.pushViewController(detailsViewController, animated: true)
            }
        case 1:
            let tv = tvList[indexPath.row]
            if let detailsViewController = storyboard.instantiateViewController(withIdentifier: "TVDetailViewController") as?
                TVDetailViewController {
                detailsViewController.tv = tv
                navigationController?.pushViewController(detailsViewController, animated: true)
            }
        default:
            break
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        selectedSegment.isHidden = scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 ? true : false
    }
}
