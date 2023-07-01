//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Philipp Sanktjohanser on 13.12.22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
