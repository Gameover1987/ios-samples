
import Foundation

// Business
// https://newsapi.org/v2/top-headlines?country=rus&category=business&apiKey=34f4c8a4cfe647f5acd1e7d709464b34

// Tesla
// https://newsapi.org/v2/everything?q=tesla&from=2022-12-05&sortBy=publishedAt&apiKey=34f4c8a4cfe647f5acd1e7d709464b34

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    func downloadJson(query: String, completion: ((_ articles: [Article]?) -> Void)?) {
        let session = URLSession(configuration: .default)
        
        let request = URLRequest(url: URL(string: "https://newsapi.org/v2/everything?q=\(query)&from=2022-12-05&sortBy=publishedAt&apiKey=34f4c8a4cfe647f5acd1e7d709464b34")!)
        
        let task = session.dataTask(with: request) { data, responcse, error in
            if let error = error {
                print("Error when downloading json: " + error.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("Data is nil!!")
                return
            }
            
            do {
                let answer = try JSONDecoder().decode(Answer.self, from: data)
                completion?(answer.articles)
            } catch {
                print("Parse JSON error: \(error)")
            }
        }
        
        task.resume()
    }
}
