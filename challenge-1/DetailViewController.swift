//
//  DetailViewController.swift
//  challenge-1
//
//  Created by Bruno Guirra on 07/01/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var countrieFlag: UIImageView!
    
    var selectedImage: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the name of the countrie an sets as
        // the title of the navigation item
        let countrieName = selectedImage?.replacingOccurrences(of: ".png", with: "")
        title = countrieName?.uppercased()
        
        // Disable large title at navigation items
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
        
        // Create an UIImage and pass to UIImageView with
        // the picture of the selected countrie flag
        if let selectedImage = selectedImage {
            countrieFlag.image = UIImage(named: selectedImage)
            countrieFlag.layer.borderWidth = 1
            countrieFlag.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    @objc func share() {
        guard let flag = countrieFlag.image, let name = selectedImage else { return }
        
        let ac = UIActivityViewController(activityItems: [flag, name], applicationActivities: [])
        
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }

}
