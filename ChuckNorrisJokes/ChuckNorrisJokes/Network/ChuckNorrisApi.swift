
import Foundation

struct Joke : Codable {
    var id: String
    var value: String
    var icon_url: String
    var url: String
}

enum NetworkErrors : String, Error {
    case dataIsNil = "Data is nil!"
    case jsonParseError = "JSON parse error"
}

final class ChuckNorrisApi {
    private let randomJokesUrl = "https://api.chucknorris.io/jokes/random"
    
    static let shared = ChuckNorrisApi()
    
    private init() {
        
    }
    
    func getRandomJoke(completion: ((_ result: Result<Joke, Error>) -> Void)?) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: URL(string: randomJokesUrl)!) { data, response, error in
            
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
