import Foundation
struct ResultsTV : Codable {
	let backdrop_path : String?
	let genre_ids : [Int]?
	let original_name : String?
	let original_language : String?
	let poster_path : String?
	let id : Int?
	let name : String?
	let vote_average : Double?
	let overview : String?
	let vote_count : Int?
	let first_air_date : String?
	let origin_country : [String]?
	let popularity : Double?
	let media_type : String?

	enum CodingKeys: String, CodingKey {

		case backdrop_path = "backdrop_path"
		case genre_ids = "genre_ids"
		case original_name = "original_name"
		case original_language = "original_language"
		case poster_path = "poster_path"
		case id = "id"
		case name = "name"
		case vote_average = "vote_average"
		case overview = "overview"
		case vote_count = "vote_count"
		case first_air_date = "first_air_date"
		case origin_country = "origin_country"
		case popularity = "popularity"
		case media_type = "media_type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
		genre_ids = try values.decodeIfPresent([Int].self, forKey: .genre_ids)
		original_name = try values.decodeIfPresent(String.self, forKey: .original_name)
		original_language = try values.decodeIfPresent(String.self, forKey: .original_language)
		poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		vote_average = try values.decodeIfPresent(Double.self, forKey: .vote_average)
		overview = try values.decodeIfPresent(String.self, forKey: .overview)
		vote_count = try values.decodeIfPresent(Int.self, forKey: .vote_count)
		first_air_date = try values.decodeIfPresent(String.self, forKey: .first_air_date)
		origin_country = try values.decodeIfPresent([String].self, forKey: .origin_country)
		popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
		media_type = try values.decodeIfPresent(String.self, forKey: .media_type)
	}

}
