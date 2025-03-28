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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load products from Core Data
        products = ProductManager.shared.fetchProducts()
        
        // Add dummy products if empty
        if products.isEmpty {
            ProductManager.shared.preloadDataIfNeeded()
            products = ProductManager.shared.fetchProducts()
        }
        
        // Display first product
        if !products.isEmpty {
            displayProduct(at: currentIndex)
        }
    }
    
    func displayProduct(at index: Int) {
        guard index >= 0 && index < products.count else { return }
        
        let product = products[index]
        
        // Debug print to see what values we're working with
        print("Product at index \(index): ID=\(product.productID ?? "nil"), name=\(product.name ?? "nil"), desc=\(product.desc ?? "nil"), price=\(product.price), provider=\(product.provider ?? "nil")")
        
        // Check all outlets are connected
        guard productIDLabel != nil && productNameLabel != nil && productDescLabel != nil &&
              productPriceLabel != nil && productProviderLabel != nil else {
            print("ERROR: One or more label outlets are nil!")
            return
        }
        
        // Safely unwrap all optional values
        productIDLabel.text = product.productID ?? "No ID"
        productNameLabel.text = product.name ?? "No Name"
        productDescLabel.text = product.desc ?? "No Description"
        
        // Format price with extra safety
        if let priceLabel = productPriceLabel {
            priceLabel.text = String(format: "$%.2f", product.price)
        }
        
        productProviderLabel.text = product.provider ?? "No Provider"
        
        // Update nav buttons if they exist
        previousButton?.isEnabled = index > 0
        nextButton?.isEnabled = index < products.count - 1
    }
    
    // MARK: - Actions
    @objc func viewAllTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let productsListVC = storyboard.instantiateViewController(withIdentifier: "ProductsListViewController") as? ProductsListViewController {
            navigationController?.pushViewController(productsListVC, animated: true)
        }
    }
    
    @objc func searchTapped() {
        performSegue(withIdentifier: "showSearch", sender: nil)
    }
    
    @objc func addProductTapped() {
        performSegue(withIdentifier: "showAddProduct", sender: nil)
    }
    
    // If prev button tapped, go back 1 product
    @IBAction func previousButtonTapped(_ sender: Any) {
        if currentIndex > 0 {
            currentIndex -= 1
            displayProduct(at: currentIndex)
        }
    }
    
    // If next button pressed, go to next product 
    @IBAction func nextButtonTapped(_ sender: Any) {
        if currentIndex < products.count - 1 {
            currentIndex += 1
            displayProduct(at: currentIndex)
        }
    }
}
