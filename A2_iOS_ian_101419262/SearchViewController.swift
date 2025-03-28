//
//  SearchViewController.swift
//  A2_iOS_ian_101419262
//
//  Created by ian mcdonald on 2025-03-28.
//


import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Products"
        
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        
        let product = products[indexPath.row]
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = product.desc
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Navigate back to main view and display selected product
        if let productVC = navigationController?.viewControllers.first as? ProductViewController {
            let mainProducts = productVC.products
            guard indexPath.row < products.count,
                  let selectedProductID = products[indexPath.row].productID else {
                return
            }
            
            // Find the index of the selected product in the main products array
            if let index = mainProducts.firstIndex(where: { $0.productID == selectedProductID }) {
                productVC.currentIndex = index
                productVC.displayProduct(at: index)
                navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    // MARK: - Search Bar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        products = ProductManager.shared.searchProducts(query: searchText)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
