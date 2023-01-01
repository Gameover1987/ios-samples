
import Foundation
import UIKit


final class FileManagerTableViewCell : UITableViewCell {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(entryTypeImage)
        addSubview(titleLabel)
        
        entryTypeImage.snp.makeConstraints { maker in
            maker.left.equalTo(contentView).offset(4)
            maker.top.equalTo(contentView).offset(4)
            maker.bottom.equalTo(contentView).offset(-4)
            maker.width.equalTo(45)
        }
        
        titleLabel.snp.makeConstraints { maker in
            maker.left.equalTo(entryTypeImage.snp.right).offset(8)
            maker.centerY.equalTo(contentView.center)
            maker.right.equalTo(contentView).inset(8)
        }
    }
    
    var fileSystemEntry: FileSystemEntry? {
        didSet {
            guard let entry = fileSystemEntry else { return }
          
            if (entry.isFolder) {
                entryTypeImage.image = UIImage(systemName: "folder")
                titleLabel.text = entry.name
            }
            else {
                entryTypeImage.image = UIImage(contentsOfFile: entry.fullName)
                titleLabel.text = entry.name
            }
        }
    }
    
    private lazy var entryTypeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
}
