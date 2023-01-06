
import Foundation

struct Joke : Codable {
    var id: String
    var value: String
    var categories: [String]
    var icon_url: String
    var url: String
}

enum NetworkErrors : String, Error {
    case dataIsNil = "Data is nil!"
    case jsonParseError = "JSON parse error"
}

final class ChuckNorrisApi {
    private let randomJokesUrl = "https://api.chucknorris.io/jokes/random"
    private let randomJokesByCategoryUrl = "https://api.chucknorris.io/jokes/random?category="
    
    static let shared = ChuckNorrisApi()
    
    private init() {
        
    }
    
    func getRandomJoke(byCategory category: String?, completion: ((_ result: Result<Joke, Error>) -> Void)?) {
        let session = URLSession(configuration: .default)
        
        var url = URL(string: randomJokesUrl)
        if category != nil {
            url = URL(string: randomJokesByCategoryUrl + category!)
        }
        
        let task = session.dataTask(with: url!) { data, response, error in
            
            if let error = error {
                print(error)
                completion?(Result.failure(error))
                return
            }
            
            guard let data = data else {
                completion?(Result.failure(NetworkErrors.dataIsNil))
                return
            }
            
            do {
                let randomJoke = try JSONDecoder().decode(Joke.self, from: data)
                completion?(Result.success(randomJoke))
            } catch {
                completion?(Result.failure(NetworkErrors.jsonParseError))
            }
        }
        task.resume()
    }
}
