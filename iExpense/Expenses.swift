//
//  Expenses.swift
//  iExpense
//
//  Created by Philipp Sanktjohanser on 13.12.22.
//

import Foundation

class Expenses: ObservableObject {
    private var items = [ExpenseItem]()
    
    @Published var personalItems = [ExpenseItem]()
    @Published var businessItems = [ExpenseItem]()
    
//    @Published var items = [ExpenseItem]() {
//        didSet {
//            if let encoded = try? JSONEncoder().encode(items) {
//                UserDefaults.standard.set(encoded, forKey: "Items")
//            }
//        }
//    }
    
    init() {
        loadItems()
    }
    
    func loadItems() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                filterItems()
            }
        }
    }
    
    func filterItems() {
        personalItems = items.filter { $0.type == "Personal" }
        businessItems = items.filter { $0.type == "Business" }
    }
    
    func add(_ expense: ExpenseItem) {
        items.append(expense)
        save()
    }
    
    func remove(_ expense: ExpenseItem) {
        items.removeAll { $0.id == expense.id }
        save()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: "Items")
            filterItems()
        }
    }
}
