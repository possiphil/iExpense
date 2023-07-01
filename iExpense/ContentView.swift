//
//  ContentView.swift
//  iExpense
//
//  Created by Philipp Sanktjohanser on 13.12.22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                Section("Personal Expenses") {
                    ForEach(expenses.personalItems) { expense in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(expense.name)
                                    .font(.headline)
                                Text(expense.type)
                            }
                            
                            Spacer()
                            
                            Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundColor(expense.amount > 10 ? (expense.amount > 100 ? Color.red : Color.red.opacity(0.5)) : Color.yellow)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                
                Section("Business Expenses") {
                    ForEach(expenses.businessItems) { expense in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(expense.name)
                                    .font(.headline)
                                Text(expense.type)
                            }
                            
                            Spacer()
                            
                            Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundColor(expense.amount > 10 ? (expense.amount > 100 ? Color.red : Color.red.opacity(0.5)) : Color.yellow)
                        }
                    }
                    .onDelete(perform: removeBusinessItem)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        var items = [ExpenseItem]()
        
        for offset in offsets {
            items.append(expenses.personalItems[offset])
        }
        
        for item in items {
            expenses.remove(item)
        }
    }
    
    func removeBusinessItem(at offsets: IndexSet) {
        var items = [ExpenseItem]()
        
        for offset in offsets {
            items.append(expenses.businessItems[offset])
        }
        
        for item in items {
            expenses.remove(item)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
