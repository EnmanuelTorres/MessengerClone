//
//  PhotoViewerViewController.swift
//  MessengerClone
//
//  Created by ENMANUEL TORRES on 17/02/23.
//

import UIKit
import SDWebImage

final class PhotoViewerViewController: UIViewController {
    
    private let url: URL
    
    init(with url: URL){
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor.self: UIColor.systemBlue]
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = UIColor.black
        view.addSubview(imageView)
        imageView.sd_setImage(with: url)
    }
    
    override func viewDidLayoutSubviews() {
        imageView.frame = view.bounds
    }
}

