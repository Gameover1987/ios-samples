
import UIKit

class JokeViewController: UIViewController {
    
    @IBOutlet weak var jokeRefreshButton: UIBarButtonItem!
    
    @IBAction func jokeRefreshAction(_ sender: Any) {
        refreshJokeAndStore()
    }
    
    @IBOutlet weak var labelJoke: UILabel!
    
    var joke: JokeEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(displayP3Red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        
        if let joke = joke {
            self.labelJoke.text = joke.text
            self.labelJoke.tintColor = .systemGray
        } else {
            refreshJokeAndStore()
        }
    }
    
    private func refreshJokeAndStore() {
        jokeRefreshButton.isEnabled = false
        ChuckNorrisApi.shared.getRandomJoke(byCategory: nil) { result in
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                switch result {
                case .failure(let error):
                    self.labelJoke.text  = "Chuck Norris API error!\r\n\(error)"
                    self.labelJoke.tintColor = .systemRed
                    
                case .success(let joke):
                    self.labelJoke.text = joke.value
                    self.labelJoke.tintColor = .systemGray
                    
                    CoreDataManager.shared.addJoke(joke)
                }
                
                self.jokeRefreshButton.isEnabled = true
            }
        }
    }

}
