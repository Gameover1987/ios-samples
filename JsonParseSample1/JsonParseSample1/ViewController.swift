//
//  ViewController.swift
//  JsonParseSample1
//
//  Created by Вячеслав on 17.01.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.layer.cornerRadius = 10
        stack.layer.borderWidth = 0.5
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.spacing = 0.5
        stack.clipsToBounds = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var details24HoursLabel: UILabel = {
        let label = UILabel()
        label.text = "Подробнее на 24 часа"
        label.textAlignment = .right
        label.backgroundColor = .white
        //label.font = Fonts.rubikRegular16
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImageView()
        image.image = UIImage(named: "ClintEastwood")
    
        let label = UILabel()
        label.text = "The good, the bad and the ugly"
        
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(label)
        
        view.addSubview(details24HoursLabel)
        
        details24HoursLabel.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }


}

