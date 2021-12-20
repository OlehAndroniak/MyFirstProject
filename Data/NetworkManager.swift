import Foundation
import Alamofire

struct NetworkManager {
    
    static let shared = NetworkManager()
    private let queue = DispatchQueue.global()
    
    func requestTrendingMovies(completion: @escaping(([Results]) -> ())) {
        let url = Constants.baseURL + "trending/movie/day" + Constants.apiKey
        AF.request(url).responseJSON { response in
            let decoder = JSONDecoder()
            if let data = try? decoder.decode(JSONRespons.self, from: response.data!) {
                let movies = data.results ?? []
                completion(movies)
            }
        }
    }
    
    func requestMovies(_ query: String, segmentTitle: String, completion: @escaping(([ResultsSearch]) -> ())) {
        let url = Constants.baseURL + "search/\(segmentTitle)" + Constants.apiKey + "&query="
           let newQuery = query.replacingOccurrences(of: " ", with: "+")
           queue.async {
               AF.request(url + newQuery).responseJSON { responce in
                   let decoder = JSONDecoder()
                   guard let responceData = responce.data else { return }
                   guard let data = try? decoder.decode(JsonSearch.self, from: responceData) else { return }
                   guard let movies = data.results else { return }
                   completion(movies)
               }
               completion([])
           }
       }
    
    func requestVideoDetails(_ id: Int, completion: @escaping(([VideoResults]) -> ())) {
        let url = Constants.baseURL + "movie/\(id)/videos" + Constants.apiKey
        AF.request(url).responseJSON { responce in
            let decoder = JSONDecoder()
            guard let responceData = responce.data else { return }
            guard let data = try? decoder.decode(JSONVideo.self, from: responceData) else  { return }
            guard let video = data.results else { return }
            completion(video)
        }
    }
}

struct NetworkManagerTV {
    
    static let shared = NetworkManagerTV()
    
    func requestTrendingTV(completion: @escaping(([ResultsTV]) -> ())) {
        let url = Constants.baseURL + "trending/tv/day" + Constants.apiKey
        AF.request(url).responseJSON { response in
            let decoder = JSONDecoder()
            if let data = try? decoder.decode(Json4Swift_Base.self, from: response.data!) {
                let tv = data.results ?? []
                completion(tv)
            }
        }
    }
}
