//
//  AddProductViewController.swift
//  A2_iOS_ian_101419262
//
//  Created by ian mcdonald on 2025-03-28.
//


import UIKit

class AddProductViewController: UIViewController {
    @IBOutlet weak var productIDTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var providerTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add New Product"
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let id = productIDTextField.text, !id.isEmpty,
              let name = nameTextField.text, !name.isEmpty,
              let desc = descTextField.text, !desc.isEmpty,
              let priceText = priceTextField.text, !priceText.isEmpty,
              let provider = providerTextField.text, !provider.isEmpty,
              let price = Double(priceText) else {
            
            showAlert(message: "Please fill in all fields with valid information")
            return
        }
            
        ProductManager.shared.addProduct(id: id, name: name, desc: desc, price: price, provider: provider)
        
        navigationController?.popViewController(animated: true)
    }
        
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
