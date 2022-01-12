//
//  ViewController.swift
//  challenge-1
//
//  Created by Bruno Guirra on 06/01/22.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flag Viewer"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.contains(".png") {
                pictures.append(item)
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = pictures[indexPath.row]
        
        // Create an image and resize it to insert in the cell
        let image = UIImage(named: pictures[indexPath.row])
        let size = CGSize(width: 20, height: 16)
        let resizedImage = image?.resized(to: size)
        content.image = resizedImage
        
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Try to load the View Controller on Storyboard with the identifier as a DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // Set the selectedImage property on DetailViewController as the
            // image that user selected
            vc.selectedImage = pictures[indexPath.row]
            
            // Navigate to DetailViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// Extends UIImage to add a method that resizes images
extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
