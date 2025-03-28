//
//  ProductManager.swift
//  A2_iOS_ian_101419262
//
//  Created by ian mcdonald on 2025-03-28.
//


import UIKit
import CoreData

class ProductManager {
    static let shared = ProductManager()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Fetch all products
    func fetchProducts() -> [Product] {
        do {
            let request: NSFetchRequest<Product> = Product.fetchRequest()
            let products = try context.fetch(request)
            return products
        } catch {
            print("Error fetching products: \(error)")
            return []
        }
    }
    
    // Add a new product
    func addProduct(id: String, name: String, desc: String, price: Double, provider: String) {
        let newProduct = Product(context: context)
        newProduct.productID = id
        newProduct.name = name
        newProduct.desc = desc
        newProduct.price = price
        newProduct.provider = provider
        
        saveContext()
    }
    
    // Search products by name or description
    func searchProducts(query: String) -> [Product] {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        
        if !query.isEmpty {
            let namePredicate = NSPredicate(format: "name CONTAINS[cd] %@", query)
            let descPredicate = NSPredicate(format: "desc CONTAINS[cd] %@", query)
            request.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [namePredicate, descPredicate])
        }
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error searching products: \(error)")
            return []
        }
    }
    
    // Pre-populate db with sample products
    func preloadDataIfNeeded() {
        let count = fetchProducts().count
        // if no products, add dummy data
        if count == 0 {
            addProduct(id: "PID001", name: "iPhone 16", desc: "Latest iPhone model", price: 1299.99, provider: "Apple")
            addProduct(id: "PID002", name: "MacBook Air M4", desc: "Latest MacBook Air with M4 chip", price: 1699.99, provider: "Apple")
            addProduct(id: "PID003", name: "AirPods Pro", desc: "Wireless earbuds with noise cancellation", price: 249.99, provider: "Apple")
            addProduct(id: "PID004", name: "iPad Air", desc: "Thin and light tablet with M1 chip", price: 599.99, provider: "Apple")
            addProduct(id: "PID005", name: "Samsung Galaxy S23", desc: "Latest Android flagship phone", price: 899.99, provider: "Samsung")
            addProduct(id: "PID006", name: "PS5", desc: "Latest Playstation console", price: 1299.99, provider: "Sony")
            addProduct(id: "PID007", name: "LG Smart TV", desc: "Premium 4K smart TV", price: 3499.99, provider: "LG")
            addProduct(id: "PID008", name: "Nintendo Switch", desc: "Hybrid gaming console", price: 299.99, provider: "Nintendo")
            addProduct(id: "PID009", name: "Logitech MX Master 3", desc: "Premium wireless mouse", price: 99.99, provider: "Logitech")
            addProduct(id: "PID010", name: "Amazon Echo", desc: "Smart speaker with Alexa", price: 49.99, provider: "Amazon")
        }
    }
    
    // Save context
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
