//
//  ProductsListViewController.swift
//  A2_iOS_ian_101419262
//
//  Created by ian mcdonald on 2025-03-28.
//


import UIKit

class ProductsListViewController: UITableViewController {
    
    var products: [Product] = []
    
    func loadProducts() {
        products = ProductManager.shared.fetchProducts()
        
        // If no products exist, preload sample data
        if products.isEmpty {
            print("No products found, preloading data...")
            ProductManager.shared.preloadDataIfNeeded()
            products = ProductManager.shared.fetchProducts()
        }
        
        print("Loaded \(products.count) products")
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "All Products"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadProducts()
    }

    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        
        let product = products[indexPath.row]
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = product.desc
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Navigate back to main view and display selected product
        if let productVC = navigationController?.viewControllers.first as? ProductViewController {
            productVC.currentIndex = indexPath.row
            productVC.displayProduct(at: indexPath.row)
            navigationController?.popToRootViewController(animated: true)
        }
    }
}
