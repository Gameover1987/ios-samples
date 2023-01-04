//
//  ViewController.swift
//  BundleLoadingSsample1
//
//  Created by Вячеслав on 19.12.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(view.safeAreaLayoutGuide.layoutFrame)
        
        view.backgroundColor = .systemBlue
        
        if let orangeView = Bundle.main.loadNibNamed("TestView", owner: nil, options: nil)?.first as? UIView {
            let safeAreaFrame = view.safeAreaLayoutGuide.layoutFrame
            let newFrame = CGRect(x: safeAreaFrame.minX, y: safeAreaFrame.minY, width: safeAreaFrame.width, height: safeAreaFrame.height - 10)
            orangeView.frame = newFrame
            
            orangeView.layer.cornerRadius = 10
            orangeView.layer.borderWidth = 1
            orangeView.layer.borderColor = UIColor.black.cgColor
            
            view.addSubview(orangeView)
        }
    }


}

