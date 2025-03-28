//
//  ProductViewController.swift
//  A2_iOS_ian_101419262
//
//  Created by ian mcdonald on 2025-03-28.
//


import UIKit
import CoreData

class ProductViewController: UIViewController {
    // UI elements
    @IBOutlet weak var productIDLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productProviderLabel: UILabel!
    
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    // Products data
    var products: [Product] = []
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Product Details"
        
        // Add navigation bar buttons
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProductTapped))
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
        let viewAllButton = UIBarButtonItem(title: "View All", style: .plain, target: self, action: #selector(viewAllTapped))
        
        navigationItem.leftBarButtonItem = viewAllButton
        navigationItem.rightBarButtonItems = [navigationItem.rightBarButtonItem!, searchButton]
    }
    
    // MARK: - Actions
        @objc func viewAllTapped() {
            performSegue(withIdentifier: "showProductsList", sender: nil)
        }
        
        @objc func searchTapped() {
            performSegue(withIdentifier: "showSearch", sender: nil)
        }
        
        @objc func addProductTapped() {
            performSegue(withIdentifier: "showAddProduct", sender: nil)
        }
}
