
import UIKit
import SnapKit

class OpenImageViewController: UIViewController {
    
    private let fileSystemProvider: FileSystemProviderProtocol
    
    init(fileSystemProvider: FileSystemProviderProtocol) {
        self.fileSystemProvider = fileSystemProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(imageNameLabel)
        view.addSubview(imageView)
        
        imageNameLabel.snp.makeConstraints { maker in
            maker.left.top.right.equalTo(view.safeAreaLayoutGuide)
            maker.height.equalTo(50)
        }
        
        imageView.snp.makeConstraints { maker in
            maker.top.equalTo(imageNameLabel.snp.bottom)
            maker.left.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
    }
    
    private let imageNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    func openImage(url: URL) {
        do {
            let image = try fileSystemProvider.loadImageFromFile(url: url)
            imageNameLabel.text = url.lastPathComponent
            imageView.image = image
        }
        catch {
            
        }
    }
}
