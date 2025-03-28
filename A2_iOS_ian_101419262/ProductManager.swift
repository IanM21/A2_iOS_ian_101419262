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
    
    // Save context
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
