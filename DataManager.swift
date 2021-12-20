import Foundation
import RealmSwift

struct DataManager {
    
    let realm = try? Realm()

    func getMovies() -> [MovieAndTvUI] {
        var movies = [MovieAndTvUI]()
        guard let moviesResults = realm?.objects(MovieAndTvRealm.self) else { return [] }
        for movie in moviesResults {
            let movieUI = MovieAndTvUI(title: movie.title,
                                  popularity: movie.popularity,
                                  overview: movie.overview,
                                  id: movie.id,
                                  backdropPath: movie.backdropPath,
                                  mediaType: movie.mediaType,
                                  posterPath: movie.posterPath)
            movies.append(movieUI)
        }
        return movies
    }
   
    func saveMovie(movie: Results?) {
        let movieRealm = MovieAndTvRealm()
        movieRealm.title = movie?.title ?? "No title"
        movieRealm.popularity = movie?.popularity ?? 0.0
        movieRealm.overview = movie?.overview ?? ""
        movieRealm.id = movie?.id ?? 0
        movieRealm.backdropPath = movie?.backdrop_path ?? ""
        movieRealm.mediaType = movie?.media_type ?? ""
        movieRealm.posterPath = movie?.poster_path ?? ""
        try? realm?.write {
            realm?.add(movieRealm, update: .modified)
        }
    }
    
    func deleteMovie(id: Int, completion: @escaping(()->())) {
        if let cellToDelete = realm?.objects(MovieAndTvRealm.self).filter("id = %@", id).first {
           try! realm?.write {
                realm?.delete(cellToDelete)
               completion()
            }
        }
    }
}

// MARK: - TV DATA MANAGER

struct DataManagerTV {
    
    let realm = try? Realm()
    
    func saveTV(tv: ResultsTV) {
        let tvRealm = MovieAndTvRealm()
        tvRealm.title = tv.name ?? "No title"
        tvRealm.popularity = tv.popularity ?? 0.0
        tvRealm.overview = tv.overview ?? ""
        tvRealm.id = tv.id ?? 0
        tvRealm.backdropPath = tv.backdrop_path ?? ""
        tvRealm.mediaType = tv.media_type ?? ""
        tvRealm.posterPath = tv.poster_path ?? ""
        try? realm?.write {
            realm?.add(tvRealm, update: .modified )
        }
    }
}

